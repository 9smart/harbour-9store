/*
  Copyright (C) 2013 Jolla Ltd.
  Contact: Thomas Perl <thomas.perl@jollamobile.com>
  All rights reserved.

  You may use this file under the terms of BSD license as follows:

  Redistribution and use in source and binary forms, with or without
  modification, are permitted provided that the following conditions are met:
    * Redistributions of source code must retain the above copyright
      notice, this list of conditions and the following disclaimer.
    * Redistributions in binary form must reproduce the above copyright
      notice, this list of conditions and the following disclaimer in the
      documentation and/or other materials provided with the distribution.
    * Neither the name of the Jolla Ltd nor the
      names of its contributors may be used to endorse or promote products
      derived from this software without specific prior written permission.

  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
  ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
  WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
  DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDERS OR CONTRIBUTORS BE LIABLE FOR
  ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
  (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
  LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
  ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
  (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
  SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
*/

import QtQuick 2.0
import Sailfish.Silica 1.0
import io.thp.pyotherside 1.3

import "pages"
import "pages/components"
import "pages/model"
import "js/login.js" as UserData
import "js/main.js" as Script
import "js/setting.js" as Setting
import org.nemomobile.notifications 1.0
import org.coderus.powermenu.desktopfilemodel 1.0
import org.nemomobile.configuration 1.0
import org.nemomobile.dbus 2.0
import org.nemomobile.dbus 1.0

ApplicationWindow
{
    id:window
    property string version:"0.2-5";
    property bool loading:false;
    property alias user: user;
    property alias sysinfo:sysinfo;
    property var downList: [];
    property real currper: 0.0
    property bool opencache: true
    property string currname;
    property bool opencircle :true

    cover: Qt.resolvedUrl("cover/CoverPage.qml")


    ListModel{
        id:versionModel
    }

    ListModel{
        id:installedModel
    }


    DBusInterface {
            id: ssuDBus
            busType: DBusInterface.SystemBus
            destination: 'org.nemo.ssu'
            path: '/org/nemo/ssu'
            iface: 'org.nemo.ssu'
        }

    DBusInterface {
            id: systemdManager

            service: 'org.freedesktop.systemd1'
            path: '/org/freedesktop/systemd1'
            iface: 'org.freedesktop.systemd1.Manager'

            bus: DBusInterface.SessionBus

            signalsEnabled: true

            property var jobRemovedCallbacks: ({})

            function jobRemoved(jobId, objectPath, unit, result)
            {
                console.log('jobId: ' + jobId + ', unit: ' + unit);

                if (unit == 'harbour-9store.service')
                    systemdUnit.updateState();
            }

            function jobNew(id, job, unit)
            {
                console.log('id: ' + id + ', job: ' + job + ', unit: ' + unit);
            }

            function setJobRemovedCallback(jobId, callback)
            {
                jobRemovedCallbacks[jobId] = callback;
            }

            Component.onCompleted: {
                var args = [{
                    type: 's',
                    value: 'harbour-9store.service'
                }];

                systemdManager.typedCall('Subscribe', [], function(result) {
                    console.log('Subscribe result: ' + result);

                    systemdManager.typedCall('LoadUnit', args, function(result) {
                        console.log('Retrieved unit path: ' + result)
                        systemdUnit.path = result
                    });
                });

            }
        }

        DBusInterface {
            id: systemdUnit

            service: 'org.freedesktop.systemd1'
            iface: 'org.freedesktop.systemd1.Unit'

            bus: DBusInterface.SessionBus

            property bool isActive: false
            property bool isEnabled: false

            onPathChanged: {
                updateState();
            }

            function disable()
            {
                console.log('');

                var params = [{
                                  type: 'as',
                                  value: [ 'harbour-9store.service' ] // unit to disable
                              }, {
                                  type: 'b',                                 // 'disable temporarily' flag
                                  value: false                               // we disable persistently
                              }];

                systemdManager.typedCall('DisableUnitFiles', params, function(result) {
                    console.log(result);

                    systemdManager.typedCall('Reload', [], function() {
                        systemdUnit.updateState();
                    });
                });

            }

            function enable()
            {
                console.log('');

                var params = [{
                                  type: 'as',
                                  value: [ 'harbour-9store.service' ]   // unit to enable
                              }, {
                                  type: 'b',                                   // 'enable temporarily' flag
                                  value: false                                 // we enable persistently
                              }, {
                                  type: 'b',                                   // 'overwrite symlinks' flag
                                  value: false                                 // we don't
                              }];

                systemdManager.typedCall('EnableUnitFiles', params, function(result) {
                    console.log(result);

                    systemdManager.typedCall('Reload', [], function() {
                        systemdUnit.updateState();
                    });
                });
            }

            function restart()
            {
                console.log('');

                systemdUnit.typedCall('Restart', [{ type: 's', value: 'replace' }]);
            }

            function start()
            {
                console.log('');

                systemdUnit.typedCall('Start', [{type:'s',value:'replace'}]);
            }

            function stop(callback) {
                console.log('');

                systemdUnit.typedCall('Stop', [{type:'s',value:'replace'}]);
            }

            function updateState()
            {
                isActive = (getProperty('ActiveState') === 'active' &&
                            getProperty('SubState') === 'running');
                isEnabled = (getProperty('UnitFileState') === 'enabled');
            }
        }
    BusyIndicator {
        id: busyIndicator
        anchors.centerIn: parent
        running: loading
        size: BusyIndicatorSize.Large
    }

    RemorsePopup {
        id: remorse
    }


    initialPage: Component {
        Page{
            id:splashPage

            Component.onCompleted: {
                Setting.initialize()
                var flag = Setting.firstLoad()
                if(flag){
                    splash.visible = false;
                    firstopen.visible = true;
                    timerDisplay.running = false;
                }else{
                    firstopen.visible = false;
                    splash.visible = true;
                    timerDisplay.running = true;
                }
            }

            FirstOpenSplash{
                id:firstopen
            }

            SilicaFlickable {
                id: splash
                visible: false
                anchors.fill:parent
                Item{
                    anchors.fill: parent
                    width: parent.width
                    height: parent.height
                    Label{
                        id:welcomFont
                        text:qsTr("Welcome to")
                        font.pixelSize: Theme.fontSizeExtraLarge
                        anchors{
                            left:parent.left
                            leftMargin:Theme.paddingLarge
                            bottom:storeName.top
                            //bottomMargin: Theme.paddingSmall
                        }
                    }
                    Label{
                        id:storeName
                        text:qsTr("9Store")
                        font.pixelSize: Theme.fontSizeExtraLarge
                        color: Theme.highlightColor
                        anchors{
                            left:parent.left
                            leftMargin:Theme.paddingLarge
                            bottom:vendor.top
                            bottomMargin: Theme.paddingLarge * 2
                        }
                    }

                    Label{
                        id:vendor
                        text:qsTr("9Smart")
                        font.pixelSize: Theme.fontSizeMedium
                        //color: Theme.highlightColor
                        opacity:0.5
                        anchors{
                            left:parent.left
                            leftMargin:Theme.paddingLarge
                            bottom:parent.bottom
                            bottomMargin: Theme.paddingLarge
                        }
                    }

                    BusyIndicator{
                        anchors{
                            right:parent.right
                            rightMargin: Theme.paddingLarge
                            bottom:parent.bottom
                            bottomMargin: Theme.paddingLarge
                        }
                        running: true
                        size: BusyIndicatorSize.Small
                    }

                }


                NumberAnimation on opacity {duration: 500}


          }
            Timer {
                id: timerDisplay
                running: false;
                repeat: false;
                triggeredOnStart: false
                interval: 2 * 1000
                onTriggered: {
                    splash.visible = false;
                    Script.app = window;
                    Script.userData = UserData;
                    loadLoginData(UserData.getUserData());

                }
            }
        }
    }

    //检查用户登录状态
    function checkStatus(userstate){
        if(userstate === 0){
            toLoginPage();
        }
    }

    //跳到登录页面
    function toLoginPage(){
        while(pageStack.depth>1) {
            pageStack.pop(undefined, PageStackAction.Immediate);
        }
        pageStack.replace(Qt.resolvedUrl("pages/LoginDialog.qml"));
         //pageStack.push(Qt.resolvedUrl("pages/UserCenter.qml"));
    }

    function toWelcomePage(){
        while(pageStack.depth>1) {
            pageStack.pop(undefined, PageStackAction.Immediate);
        }
        pageStack.replace(Qt.resolvedUrl("pages/WelcomePage.qml"));
    }

    function toNotificationPage(){
        pageStack.replace(Qt.resolvedUrl("pages/NotificationPage.qml"));
    }
    function zero(num){
           if(typeof(num)=='undefined'){
               return 0;
           }
           return num;
       }

    function loadLoginData(oritxt) {
            if(!oritxt) {
                console.log("->UserCenter")
               toLoginPage();
               return;
            }
            var obj=JSON.parse(oritxt);
            user.username = obj.user.username;
            user.nickName = obj.user.nickname;
            user.avatar = obj.user.avatar;
            user.auth = obj.user.auth;
            user._id = obj.user._id;
            user.avatar_hd = obj.user.avatar_hd;
            user.noticeNumber = obj.user.notice_num;
            user.userState = true;
            pageStack.replace(Qt.resolvedUrl("pages/WelcomePage.qml"));
        }

    //status:0未安装，1已安装，2已卸载
    function updateDownloadList(appid,appname,downPath,icon,status){
        Down.updateDown(appid,appname,downPath,icon,status);
    }

    Connections{
            target: signalCenter;
            onLoadStarted:{
                window.loading=true;
                processingtimer.restart();
            }
            onLoadFinished:{
                window.loading=false;
                processingtimer.stop();
            }
            onLoadFailed:{
                window.loading=false;
                processingtimer.stop();
                signalCenter.showMessage(errorstring);
            }
        }
    Signalcenter{
           id: signalCenter;
       }

    Notification{
        id:notification
        appName: "9Store"
        remoteActions: [ {
                "name": "9Store",
                "displayName": qsTr("9Store"),
                "icon": "icon-s-do-it",
                "path": "/example",
                "service": 'org.freedesktop.systemd1',
                "iface": 'org.freedesktop.systemd1.Unit',
                "method": "doSomething",
                "arguments": [ "argument", 1 ]
            } ]
        onClicked:{
            console.log("clicked!!!")
            window.activate()
            toNotificationPage()

        }

    }

    function addNotification(message) {
        notification.previewBody = "9Store";
        notification.previewSummary = message;
        notification.close();
        notification.publish();
    }

    function getLocalTime(nS) {
        return Script.humanedate(nS)
    }

    Timer{
        id:processingtimer;
        interval: 60000;
        onTriggered: signalCenter.loadFailed(qsTr("error"));
    }


    function afterOpera(rpmname,version){
        py.versionCompare(rpmname,version)
    }

    User{
        id:user;
    }

    SysInfo{
        id:sysinfo;
    }

    Python {
        id: py
        signal progress(string rpmname,string per)
        signal status(string str,string rpmname,string version)
        Component.onCompleted: {
            addImportPath('/usr/share/harbour-9store/qml/py');
            py.importModule('mypy', function () {
            });
            py.importModule('rpms', function () {
            });
            py.importModule('sysinfo',function(){
            });

            setHandler('progress',progress);
            setHandler('status',status);

            py.getSysinfo();
        }
        onProgress: {
            currper = per;
            currname = rpmname;
        }


        onStatus:{
            afterOpera(rpmname,version);
            parseMsg(str);
        }
        //注册安装方法
        function installRpm(rpmPath){
            console.log("Path:"+rpmPath)
            call('mypy.install',[rpmPath],function(result){
                return result
            })

        }

        //注册打开方法
        function openapp(rpmname){
            call('mypy.openApp',[rpmname],function(result){
                return result
            })
        }

        //注册检查是否需要更新方法

        function checkInstalled(arr){
            call('rpms.getListAppinfo',[arr],function(result){

            })
        }

        function getAppinfo(rpmname){
            call('rpms.getAppinfo',[rpmname],function(result){
                var rpminfo = result;

            })
        }

        function newdownload(downurl,rpmname,version){
            //currname = rpmname;
            //console.log("starting download..."+rpmname)
            call('mypy.newdownload',[downurl,rpmname,version],function(result){
                return result
            })
        }

        function versionCompare(rpmname,version){
            call('mypy.versionCompare',[rpmname,version],function(result){
                signalCenter.currentAppmanaged(result);
            })
        }

        function getSysinfo(){
            call('sysinfo.getSysinfo',[],function(result){
                var obj = result
                sysinfo.cpuModel = obj.cpuModel;
                //sysinfo.phoneName = obj.phoneName;
            })
        }

    function isopened(rpmname){
        //signalCenter.appisopened("")
        call('mypy.isopened',[rpmname],function(result){
                signalCenter.appisopened(result)
        })

    }
        //注册卸载软件方法
        function uninstallRpm(realName,version){
            console.log("starting remove...")
            call('mypy.unistall',[realName,version],function(result){
                return result
            })
        }

        function uninstallRpmNostatus(realName){
            call('mypy.unistallpkg',[realName],function(result){
                return result
            })
        }
        //定义消息规则
        //0,开始下载
        //1,下载完成，开始安装
        //2,安装完成
        //3,升级成功
        //4,卸载完成
        function parseMsg(data){
            console.log('Event: ' + data);
            var sendMsg="";
            switch(data.toString()){
            case "0":
                sendMsg=qsTr("Begin download")
                break;
            case "1":
                sendMsg=qsTr("Downloaded,Installing")
                break;
            case "2":
                sendMsg=qsTr("Installing")
                break;
            case "3":
                sendMsg=qsTr("Updated")
                break;
            case "4":
                sendMsg=qsTr("Removed")
                break;
            case "-1":
                sendMsg=qsTr("Error")
                break;
            default:
                sendMsg=qsTr("Unknown")
            }

            signalCenter.showMessage(sendMsg)
        }

        onError:{
            signalCenter.showMessage(traceback)
            console.log(traceback)
        }

    }

//    DesktopFileSortModel {
//        id: desktopModel
//        showHidden: false
//    }



    Component.onCompleted: {
        Script.signalcenter = signalCenter;
        UserData.initialize()
        Setting.initialize()
        opencircle = Setting.getCircle();
        ssuDBus.typedCallWithReturn("displayName", [ {"type": "i", "value": "1"} ],
                                                            function (type) {
                                    sysinfo.phoneName = type
                                })


    }
}
