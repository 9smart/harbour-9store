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
import "../js/setting.js" as Setting
Page {
    id: aboutPage
    property int egg: 1
    Item {
        id: aboutInfos
        property string version:window.version
       }
    SilicaFlickable {
        id: aboutFlick
        anchors.fill: parent
        PageHeader {
            id: header
            title: qsTr("About")
        }
        width: parent.width
        contentHeight: aboutColumn.height + Theme.paddingLarge * 8
        contentWidth: aboutFlick.width
        clip:true
        VerticalScrollDecorator { flickable: aboutFlick }
        Column {
            id: aboutColumn
            anchors {
                left: parent.left
                right: parent.right
                top:header.bottom
            }
            spacing: Theme.paddingMedium
            Item {width: 1;height: 1}
            LabelText {
                anchors {
                    margins: Theme.paddingLarge
                }
                label: qsTr("Thanks")
                text: qsTr("Thanks warehouse,jolla-store,powermenu2,pyotherside,harbour-dyncal,sailfish-ytplayer,harbour-callrecorder and You!<br/>")

            }
            Item {width: 1;height: 1}
            LabelText {
                anchors {
                    margins: Theme.paddingLarge
                }
                label: "主要功能"
                text: "1、分类浏览；<br/>2、搜索；<br/>3、根据人气和下载量浏览；<br/>4、应"+
                      "用下载列表，直接点击下载列表即可进行安装。<br/>"

            }
            Item {width: 1;height: 1}
            LabelText {
                anchors {
                    margins: Theme.paddingLarge
                }
                label: "开发团队"
                text: "我们是来自民间开发者自发组成的团队，名字叫做“久智团队”。通过网络结识，目前团队有十余位成员，其中有专门从事软件开发的程序员，也有上班族、大学生，甚至还有医生等等。尽管我们从事着不同的行业，但因共同的爱好与理想，我们走到了一起。<br/>"

            }
            Item {width: 1;height: 1}
            LabelText {
                anchors {
                    margins: Theme.paddingLarge
                }
                label: "团队定位"
                text: "国内首支依托Qt跨平台优势，专注小众系统的应用"+
                      "开发，及在国内的发展与推广。"

            }
            Item {width: 1;height: 1}
            LabelText {
                anchors {
                    margins: Theme.paddingLarge
                }
                label: "目前成果"
                text: "久店，是一款小众系统平台上的应用商店，拥有简洁的界面，友好的操作体验。里面的应用目前虽然不多，不过我们会持之以恒不断的增加，重要的是我们会第一时间将最新的应用发布到久店。目前已经开发到公测版本的有Symbian和Sailfish OS平台。MeeGo平台正在做适配工作，而UbuntuTouch的版本也在开发计划之中。<br/>"

            }
            Item {width: 1;height: 1}
            LabelText {
                anchors {
                    margins: Theme.paddingLarge
                }
                label: "发展方向"
                text: "未来我们除了不断更新升级久店之外，还计划开放论坛：“酒坛”，提供给各位机友讨论之用。对于想要学习应用开发的同学，也提供一个专门发布开发教程以及开发工具的“久智学院”。还有大家可能听说过的我们自己的新闻资讯类应用：“久闻”。<br/>"

            }
            Item {width: 1;height: 1}
            LabelText {
                anchors {
                    margins: Theme.paddingLarge
                }
                label: "欢迎加入"
                text: "欢迎广大移动平台开发和爱好者加入我们，"+
                      "我们热爱技术是一个团结有爱，充满包容并积极向上的团体。"
                MouseArea{
                    anchors.fill: parent
                    onClicked: {
                        if(egg == 9){
                            Setting.reopenLoad()
                            signalCenter.showMessage(qsTr("egg opened!"))
                            return;
                        }else{
                            egg=egg+1;
                        }
                    }
                }
            }
            Item {width: 1;height: 1}
            LabelText {
                anchors {
                    margins: Theme.paddingLarge
                }
                label: "联系方式"
                text: "QQ群：346578991<br/>"+
                      "Email：contact@9smart.cn<br/>"


            }
        }
    }
}
