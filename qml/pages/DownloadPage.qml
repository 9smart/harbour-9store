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

import "components"
Page{
    id:downPage

    Component.onCompleted: {
        JS.getDownload();
    }
    SilicaFlickable {
        anchors.fill: parent

         PageHeader {
            id:header
            title: qsTr("Downloaded")
        }

        ListModel {
            id:downloadModel
        }

        SilicaListView {
            id:listview
            anchors{
                top: header.bottom
                left:parent.left
                right:parent.right
                bottom:parent.bottom
            }
            model:downloadModel
            visible: downloadModel.count > 0
            clip: true
            spacing:Theme.paddingMedium
            delegate:
                ListItem{
                    id:downlist
                    menu:contextMenuComponent
                    function remove(appid) {
                        remorseAction(qsTr("Removing..."), function() {
                            downloadModel.remove(index);
                            //TODO
                            JS.removeApp(appid);
                        });
                    }
                    width: parent.width
                    ListView.onRemove: animateRemoval()
                    CacheImage{
                        id:apppic
                        asynchronous: true
                        //sourceUncached: icon
                        fillMode: Image.PreserveAspectFit;
                        width:  Screen.height/12
                        height: Screen.height/12
                        cacheurl: icon
                        Image{
                            anchors.fill: parent;
                            source: "../img/App_icon_Loading.svg";
                            visible: parent.status==Image.Loading;
                        }
                        Image{
                            anchors.fill: parent;
                            source: "../img/App_icon_Error.svg";
                            visible: parent.status==Image.Error;
                        }

                        anchors {
                            left: parent.left
                            top:parent.top
                            leftMargin: Theme.paddingMedium
                            verticalCenter:parent.verticalCenter
                        }
                    }
                    Label{
                        id:appnameid
                        text:appname
                        width: parent.width-apppic.width-Theme.paddingSmall
                        font.pixelSize: Theme.fontSizeMedium
                        color: Theme.highlightColor
                        font.bold: true
                        //truncationMode: TruncationMode.Fade
                        horizontalAlignment: Text.AlignLeft
                        truncationMode: TruncationMode.Elide
                        anchors {
                            top:apppic.top
                            left: apppic.right
                            leftMargin: Theme.paddingMedium
                        }
                    }
                    Label{
                        id:localpath
                        text:downpath
                        width: parent.width-apppic.width-Theme.paddingSmall
                        font.pixelSize: Theme.fontSizeExtraSmall
                        color: Theme.highlightColor
                        horizontalAlignment: Text.AlignLeft
                        truncationMode: TruncationMode.Elide
                        anchors {
                            top:appnameid.bottom
                            //margins: Theme.paddingMedium
                            left: apppic.right
                        }
                    }
                    Component {
                        id: contextMenuComponent
                        ContextMenu {
                            MenuItem {
                                text: "删除"
                                onClicked: {
                                    remove(appid)
                                }
                            }
                        }
                    }
                    onClicked: {
                        pageStack.push(Qt.resolvedUrl("AppDetail.qml"),{
                                           "appid":appid
                                       })
                    }
            }

            VerticalScrollDecorator {}
        }

    }


}
