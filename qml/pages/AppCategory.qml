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
import "../js/main.js" as Script
import Sailfish.Silica 1.0
import "components"

Page{
    id:categoryPage
    property alias categorymodel:categoryModel;
    property string type

    ListModel{
        id:categoryModel
    }
    SilicaFlickable {
        anchors.fill: parent

        PageHeader {
            id:header
            title: qsTr("Category")
        }
        SilicaListView {
            id:view
            anchors{
                top:header.bottom
                left:parent.left
                right: parent.right
                bottom:parent.bottom
                //bottomMargin: Theme.paddingMedium
            }
            model : categoryModel
            clip: true
            delegate:BackgroundItem{
                id:showlist
                width: parent.width
                Label{
                    id:classnameid
                    text:category
                    font.pixelSize: Theme.fontSizeMedium
                    truncationMode: TruncationMode.Fade
                    anchors{
                        right: iconid.left
                        leftMargin: Theme.paddingLarge
                        verticalCenter:parent.verticalCenter
                    }
                }
                IconButton {
                    id:iconid
                    icon.source: "image://theme/icon-m-right"
                    anchors{
                        right: parent.right
                        verticalCenter:parent.verticalCenter
                    }
                }

                onClicked: {
                    pageStack.push(Qt.resolvedUrl("AppList.qml"),{
                                       "category":category
                                   })
                }
            }


            VerticalScrollDecorator {}
        }

    }

    Component.onCompleted: {
        Script.mainPage =categoryPage;
        Script.getcategory(type)
    }
}
