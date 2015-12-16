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
import "../js/main.js" as Main

Page{
    id:showappdetail
    //allowedOrientations: Orientation.Landscape | Orientation.Portrait | Orientation.LandscapeInverted
    property var appid
    property string developer
    property string appname
    property string system
    property string type
    property string category
    property string views
    property string downloads
    property string dateline
    property string version
    property int scores
    property int score_num
    property string size
    property string x86size
    property string summary
    property string url
    property string compatible
    property int comment_num: 0

    Component.onCompleted: {

    }


    ListModel{id:screenShotModel}
    ListModel{id:moreAppsModel}
    ListModel{id:commentsModel}
    ListModel{id:relatedModel}

    width: parent.width
    height: parent.height

    RemorsePopup {
        id: remorse
    }
    SilicaFlickable{
        id:sfl
        contentHeight: detailComp.height+Theme.paddingLarge*3+header.height
        //contentWidth: sfl.width
        anchors.fill: parent
        opacity:(progress.visible?0:1)
        VerticalScrollDecorator {}
        clip:true

        PageHeader {
            id:header
            title: qsTr("AppDetail")
        }
        PullDownMenu {
            id:pulldownmenu
            visible: true//!install.visible && !unistall.visible && !upgrade.visible
            MenuItem {
                id:install
                visible: !isinstalled
                text: qsTr("Install")
                onClicked: {
                    console.log("Hanzi:"+downloadname);

                    install.enabled = false;
                    var downPath =Conv.codefans_net_CC2PY(downloadname.split(".")[0])+".rpm";
                    remorse.execute(qsTr("Start downloading %1").arg(appname),function(){
                        py.newdownload(downPath,downurl);
                        //更新本地记录
                        //updateDownloadList(appid,appname,downPath,icon,1);

                    },3000);


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
            model:moreAppsModel
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
                    id: footerComponent
                    anchors { left: parent.left; right: parent.right }
                    height: visible ? Theme.itemSizeMedium : 0
                    signal clicked()
                    visible: display
                    Item {
                        id:footItem
                        width: parent.width
                        height: Theme.itemSizeMedium
                        Button {
                            anchors.centerIn: parent
                            text: qsTr("Load More...")
                            onClicked: {
                                comments_pagenum++;
                                JS.loadComments(appid,comments_pagenum);
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
                    id: footerComponent
                    anchors { left: parent.left; right: parent.right }
                    height: visible ? Theme.itemSizeMedium : 0
                    visible:(relatedModel.count<related_sum)
                    signal clicked()

                    Item {
                        id:footItem
                        width: parent.width
                        height: Theme.itemSizeMedium
                        Button {
                            anchors.centerIn: parent
                            text: qsTr("Load More...")
                            onClicked: {
                                related_pagenum++;
                                //List.loadAppList(related_pagenum,window.os_type,category,relatedModel);
                                JS.searchRelated(window.os_type,appid,category,related_pagenum);
                            }
                        }
                    }
                }

            }
        }
    }
}
