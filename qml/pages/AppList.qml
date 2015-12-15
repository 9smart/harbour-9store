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
import "../js/login.js" as UserData
import "../js/main.js" as Script
import "components"
import "model"
Page{
    id:showlist
    property int operationType: PageStackAction.Animated
    property string prepage
    property string nextpage
    property bool display:false
    property int listsum:0
    property int pagesize:12
    property string query_type:""
    property string type:""
    property string category:""
    property string photoUrl: ""
    property string developer:""
    property string sort
    property alias listmodel:listModel
    ListModel {
        id:listModel
    }

    SilicaFlickable{
        enabled: PageStatus.Active
        anchors.fill: parent
        PullDownMenu {
            id:pulldownid
            MenuItem {
                text: qsTr("Search")
                onClicked: pageStack.push(Qt.resolvedUrl("SearchApp.qml"))
            }

        }
        SilicaListView {
            id:view
            anchors.fill: parent
            header: PageHeader {
                id:header
                title: query_type === ""?qsTr("NewList"):qsTr("HotList")
            }
            model: listModel
            visible: view.count>0
            clip: true
            delegate:AppListComponent{}
            VerticalScrollDecorator {}
            footer:Component{

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
                            visible: prepage?true:false
                            onClicked: {
                                Script.getlist(sysinfo.osType, category, developer, prepage, pagesize, sort);
                                view.scrollToTop()
                            }
                        }
                        Button{
                            text:qsTr("Next Page")
                            visible:nextpage != "null"
                            onClicked: {
                                console.log("nextpage:"+nextpage)
                                Script.getlist(sysinfo.osType, category, developer, nextpage, pagesize, sort);
                                view.scrollToTop()
                            }
                        }
                    }
                }

            }

            ViewPlaceholder{
                enabled: view.count == 0
                text: qsTr("No more apps")

            }
        }


    }

    Component.onCompleted: {
        Script.mainPage = showlist;
        Script.getlist(sysinfo.osType, category, developer, nextpage, pagesize, sort)
    }

}
