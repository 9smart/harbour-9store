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
import QtDocGallery 5.0
import org.nemomobile.thumbnailer 1.0
import "components"
import "../js/main.js" as Script

Page{
    id:showappdetail
    //allowedOrientations: Orientation.Landscape | Orientation.Portrait | Orientation.LandscapeInverted
    property string appid
    property string developer
    property string appname
    property string rpmname
    property string system
    property string type
    property string uploaderuid
    property string category
    property string views
    property string downloads
    property int dateline
    property string version
    property int scores
    property int score_num
    property string size
    property string x86size
    property string summary
    property string url
    property string icon
    property string page
    property int ratingnum
    property string compatible
    property int comment_num: 0
    property alias screenShotsModel: screenShotModel
    property alias relatedAppsModel: relatedModel
    property alias specifiedAuthorModel:specifiedAuthorModel
    property string nextpage
    property string prevpage
    property string author_nextpage
    property string author_prevpage
    property string comm_nextpage
    property string comm_prevpage
    property int pagesize

    property bool shrink:true

    signal commentSendSuccessful()
    signal commentSendFailed(string errorstring)

    ListModel{id:screenShotModel}
    ListModel{id:specifiedAuthorModel}
    ListModel{id:commentsModel}
    ListModel{id:relatedModel}

    width: parent.width
    height: parent.height

    RemorsePopup {
        id: remorse
    }

    onVersionChanged:{
         py.versionCompare(rpmname,version)
    }

    SilicaFlickable{
        id:sfl
        contentHeight: detailComp.height+Theme.paddingLarge*3+header.height
        //contentWidth: sfl.width
        anchors.fill: parent
        VerticalScrollDecorator {}
        clip:true

        PageHeader {
            id:header
            title: appname
        }
        PullDownMenu {
            id:pulldownmenu
            visible: true//!install.visible && !unistall.visible && !upgrade.visible
            MenuItem {
                id:install
                visible:true
                text: qsTr("Install")
                onClicked: {


//                    var downPath =Conv.codefans_net_CC2PY(downloadname.split(".")[0])+".rpm";
//                    remorse.execute(qsTr("Start downloading %1").arg(appname),function(){
//                        py.newdownload(downPath,downurl);
//                        //更新本地记录
//                        //updateDownloadList(appid,appname,downPath,icon,1);

//                    },3000);


                }
            }
            MenuItem{
                id:unistall
                visible: false//isinstalled
                text:qsTr("Unistall")
            }
            MenuItem{
                id:upgrade
                visible: false//
                text:qsTr("Upgrade")
            }
        }

        DetailComponent{
            id:detailComp
            //width: parent.width
            anchors {
                left: parent.left
                right:parent.right
                top:header.bottom
                leftMargin: Theme.paddingMedium
                rightMargin: Theme.paddingMedium
            }
        }

    }

    Page{
        id:otherAppsPage
        AppGridComponent{
            header:PageHeader {
                id:otherheader
                title: qsTr("otherApps")
            }
            model:specifiedAuthorModel
            height: parent.height
            anchors.fill: parent
        }

    }
    Page{
        id:commentsPage

        SilicaListView {
            id: commentsView
            header:PageHeader {
                id:commentsheader
                title: qsTr("Comments")
            }
            clip: true
            model: commentsModel
            anchors.fill: parent
            spacing:Theme.paddingLarge
            delegate: CommentsComponent{}
            footer: Component{
                Item {
                    id: loadMoreID
                    anchors {
                        left: parent.left;
                        right: parent.right;
                    }
                    height: Theme.itemSizeMedium
                    Row {
                        id:footItem
                        spacing: Theme.paddingLarge
                        anchors.horizontalCenter: parent.horizontalCenter
                        Button {
                            text: qsTr("Prev Page")
                            visible: prevpage != ""
                            onClicked: {
                                Script.getComment(appid,prevpage)

                            }
                        }
                        Button{
                            text:qsTr("Next Page")
                            visible:nextpage != ""
                            onClicked: {
                               Script.getComment(appid,nextpage)
                            }
                        }
                    }
                }

            }

            VerticalScrollDecorator {}
        }
    }

    Page{
        id:relatedPage

        SilicaListView {
            id:view
            anchors.fill: parent
            header: PageHeader{
                title:qsTr("Related Apps")
            }
            PushUpMenu{
                visible:relatedModel.count>6
                MenuItem{
                    text:qsTr("scrollToTop")
                    onClicked: view.scrollToTop()
                }
            }
            model : relatedModel
            clip: true
            spacing:Theme.paddingLarge
            delegate:AppListComponent{}

            VerticalScrollDecorator {}
            footer: Component{

                Item {
                    id: loadMoreID
                    anchors {
                        left: parent.left;
                        right: parent.right;
                    }
                    height: Theme.itemSizeMedium
                    Row {
                        id:footItem
                        spacing: Theme.paddingLarge
                        anchors.horizontalCenter: parent.horizontalCenter
                        Button {
                            text: qsTr("Prev Page")
                            visible: author_prevpage != ""
                            onClicked: {
                                Script.getrelatedlist(sysinfo.os_type,category,author_prevpage,pagesize)

                            }
                        }
                        Button{
                            text:qsTr("Next Page")
                            visible:author_nextpage != ""
                            onClicked: {
                               Script.getrelatedlist(sysinfo.os_type,category,author_nextpage,pagesize)
                            }
                        }
                    }
                }
            }
        }
    }

    Component.onCompleted: {
       Script.infoPage = showappdetail
       Script.commentmodel = commentsModel
       Script.getinfo(appid)
       Script.getComment(appid,comm_nextpage)
       Script.getrelatedlist(sysinfo.osType,category,page,pagesize)
       Script.getSpecifiedAuthorList(sysinfo.osType,developer,page,pagesize)

    }

    Connections{
        target: signalCenter
        onCommentSendSuccessful:{
            Script.getComment(appid,comm_nextpage);
            signalCenter.showMessage(qsTr("Send Successful!"))
        }
        onCommentSendFailed:{
            signalCenter.showMessage(errorstring)
        }

    }
}
