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
import "../js/applist.js" as JS
import "../js/login.js" as UserData
import "components"
Page{
    id:showlist
    property int operationType: PageStackAction.Animated
    property int pagenum:1
    property bool display:false
    property int listsum:0
    property string query_type:""
    property string type:""
    property string category:""
    property string photoUrl: ""
    Component.onCompleted: {
          JS.loadAppList(pagenum,window.os_type,query_type,appListModel,type,category);
    }
    SilicaFlickable{
        PageHeader {
            id:header
            title: query_type === ""?qsTr("NewList"):qsTr("HotList")
        }
        anchors.fill: parent
        PullDownMenu {
            id:pulldownid
            MenuItem {
                text: qsTr("Search")
                onClicked: pageStack.push(Qt.resolvedUrl("SearchApp.qml"))
            }

        }


        Progress{
            id:progress
            anchors.centerIn: parent
        }
        ListModel {
            id:appListModel
        }

        AppListViewComponet{
            anchors{
                top:header.bottom
                left:parent.left
                right: parent.right
                bottom:parent.bottom
                //bottomMargin: Theme.paddingMedium
            }
        }
        Label{
            id:nohistory
            visible: !progress.visible && PageStatus.Active && appListModel.count === 0
            text:"暂无记录"
            color: Theme.highlightColor
            anchors.centerIn: parent
            font.pixelSize: Theme.fontSizeExtraLarge
        }

    }



}

