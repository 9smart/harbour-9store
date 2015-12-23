/****************************************************************************************
**
** Copyright (C) 2013 Jolla Ltd.
** Contact: Joona Petrell <joona.petrell@jollamobile.com>
** All rights reserved.
**
** This file is part of Sailfish Silica UI component package.
**
** You may use this file under the terms of BSD license as follows:
**
** Redistribution and use in source and binary forms, with or without
** modification, are permitted provided that the following conditions are met:
**     * Redistributions of source code must retain the above copyright
**       notice, this list of conditions and the following disclaimer.
**     * Redistributions in binary form must reproduce the above copyright
**       notice, this list of conditions and the following disclaimer in the
**       documentation and/or other materials provided with the distribution.
**     * Neither the name of the Jolla Ltd nor the
**       names of its contributors may be used to endorse or promote products
**       derived from this software without specific prior written permission.
**
** THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
** ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
** WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
** DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDERS OR CONTRIBUTORS BE LIABLE FOR
** ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
** (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
** LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
** ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
** (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
** SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
**
****************************************************************************************/

import QtQuick 2.0
import Sailfish.Silica 1.0
import "../../js/main.js" as Script

Item {
    id:registerComponent
    signal registerSucceed()
    signal registerFailed(string fail)
    SilicaFlickable {
        anchors.fill: parent
        contentHeight: column.height + Theme.paddingLarge * 5

        VerticalScrollDecorator {}

        BusyIndicator {
            id:busyIndicator
            parent: registerComponent
            anchors.centerIn: parent
            size: BusyIndicatorSize.Large
        }

        Column {
            id: column
            anchors { left: parent.left; right: parent.right }
            PageHeader {
                id:header
                title: qsTr("Create Account")
            }
            spacing: Theme.paddingMedium
            TextField {
                id: email
                anchors { left: parent.left; right: parent.right }
                label: qsTr("Email address");
                inputMethodHints:Qt.ImhNoAutoUppercase | Qt.ImhUrlCharactersOnly | Qt.ImhNoPredictiveText
                validator: RegExpValidator { regExp:/\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*/ }
                placeholderText: label
                EnterKey.enabled: text || inputMethodComposing
                EnterKey.iconSource: "image://theme/icon-m-enter-next"
                EnterKey.onClicked: password.focus = true
            }
            // TextField {
            //     id: firstname
            //     anchors { left: parent.left; right: parent.right }
            //     focus: true;
            //     label: qsTr("User Name");
            //     placeholderText: label
            //     RegExpValidator { regExp: /.{2,14}/ }
            //     inputMethodHints:Qt.ImhNoAutoUppercase | Qt.ImhUrlCharactersOnly
            //     EnterKey.enabled: text || inputMethodComposing
            //     EnterKey.iconSource: "image://theme/icon-m-enter-next"
            //     EnterKey.onClicked: nickname.focus = true
            // }
            TextField {
                id: nickname
                anchors { left: parent.left; right: parent.right }
                focus: true;
                label: qsTr("Nick Name");
                placeholderText: label
                RegExpValidator { regExp: /.{2,14}/ }
                //echoMode: TextInput.text
                EnterKey.enabled: text || inputMethodComposing
                EnterKey.iconSource: "image://theme/icon-m-enter-next"
                EnterKey.onClicked: email.focus = true
            }


            TextField {
                id: password
                anchors { left: parent.left; right: parent.right }
                echoMode: TextInput.Password
                label: qsTr("Password");
                placeholderText: label
                EnterKey.enabled: text || inputMethodComposing
                EnterKey.iconSource: "image://theme/icon-m-enter-next"
                EnterKey.onClicked: confirmPassword.focus = true
            }

            TextField {
                id: confirmPassword
                anchors { left: parent.left; right: parent.right }
                echoMode: TextInput.Password; enabled: password.text || text
                errorHighlight: password.text != text
                label: qsTr("Confirm Password")
                placeholderText: label; opacity: enabled ? 1 : 0.5
                Behavior on opacity { FadeAnimation { } }
                EnterKey.enabled: text || inputMethodComposing
                EnterKey.highlighted: !errorHighlight
                EnterKey.iconSource: "image://theme/icon-m-enter-next"
                //EnterKey.onClicked: reason.focus = true
                EnterKey.onClicked: registerButton.focus = true

            }
            TextField {
                id: reason
                anchors { left: parent.left; right: parent.right }
                opacity: 0
                focus: true;
                text: "from "+sysinfo.phoneName
                label: qsTr("Register reason");
                placeholderText: label
                RegExpValidator { regExp: /.{2,20}/ }
                EnterKey.enabled: text || inputMethodComposing
                EnterKey.iconSource: "image://theme/icon-m-enter-next"
                EnterKey.onClicked: registerButton.focus = true
            }

        }

        Button{
            id:registerButton
            anchors{
                top:column.bottom
                horizontalCenter: parent.horizontalCenter
            }
            text:qsTr("Register")
            enabled: email.text && password.text && confirmPassword.text &&
                     password.text == confirmPassword.text
            onClicked: {
                errorLabel.visible = false;
                busyIndicator.running = true;
                Script.registeR(email.text,nickname.text,password.text,confirmPassword.text,reason.text)

            }
        }
        Label {
            id:errorLabel
            anchors{
                top:column.bottom
                topMargin: Theme.paddingLarge * 4
                horizontalCenter: parent.horizontalCenter
            }
            width: column.width
            color: Theme.highlightColor
            wrapMode: Text.WrapAtWordBoundaryOrAnywhere
            font.pixelSize: Theme.fontSizeExtraSmall
        }

        Connections {
            target: signalCenter
            onRegisterSucceed: {
                errorLabel.visible = false;
                busyIndicator.running = false;
                registerComponent.registerSucceed();
            }
            onRegisterFailed: {
                busyIndicator.running = false;
                errorLabel.visible = true;
                errorLabel.text = qsTr("Register fail")+" [ "+fail+" ]. " + qsTr("Please try again.");
            }
        }
    }


}
