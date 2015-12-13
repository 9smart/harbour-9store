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
import "./components"
import "../js/search.js" as JS
Page {
    id: searchPage
    property string searchString
    property bool display:false
    property int listsum:0
    property int pagenum:1
    //property bool keepSearchFieldFocus:true

    PageHeader {
        id:header
        title: qsTr("Search")
    }
    BusyIndicator {
        id:progress
        running: true
        size: BusyIndicatorSize.Large
        anchors.centerIn: parent
    }

    SilicaFlickable{
        id:searchItem
        anchors{
            top:header.bottom
            left:parent.left
            right: parent.right
            bottom:parent.bottom
        }

        width: parent.width
        //height: Screen.height-header.height
        Component.onCompleted: {
            progress.visible=false
        }

        SearchField {
            id: searchField
            width: parent.width
            Binding {
                target: searchPage
                property: "searchString"
                value: searchField.text
            }
            EnterKey.onClicked: {
                JS.searchApp(window.os_type,searchField.text,pagenum);
                parent.focus=true
                }
            }




        ListModel {
            id:appListModel
        }

    Item {
//         width: parent.width
//         height: Screen.height-header.height - Theme.itemSizeMedium *2
//         y:header.height
        anchors{
            top:parent.top
            topMargin: Theme.itemSizeMedium
            left:parent.left
            right:parent.right
            bottom:parent.bottom
        }

        SilicaListView {
            y:header.height
            id:view
            anchors.fill:parent
            model : appListModel
            clip: true
            delegate:AppListComponet{}
            footer: Component{
                Item {
                    id: footerComponent
                    anchors { left: parent.left; right: parent.right }
                    height: visible ? Theme.itemSizeMedium : 0
                    visible:(appListModel.count<listsum)
                    signal clicked()
                    Item {
                        id:footItem
                        width: parent.width
                        height: Theme.itemSizeMedium
                        Button {
                            anchors.centerIn: parent
                            text: qsTr("Load More...")
                            onClicked: {
                                pagenum++;
                                JS.searchApp(window.os_type,searchField.text,pagenum);
                            }
                        }
                    }
                }

            }

            VerticalScrollDecorator {}


            }
        }
    }

}
