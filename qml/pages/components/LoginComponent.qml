import QtQuick 2.0
import Sailfish.Silica 1.0
import "../../js/main.js" as Script

Item {
    id:loginComponent

    signal loginSucceed()
    signal loginFailed(string fail)
    SilicaFlickable {
        anchors.fill: parent

        BusyIndicator {
            id:busyIndicator
            parent: loginComponent
            anchors.centerIn: parent
            size: BusyIndicatorSize.Large
        }

        Column {
            id:column
            anchors{
                top:parent.top
                topMargin: Theme.paddingLarge*4
                horizontalCenter: parent.horizontalCenter
            }

            spacing: Theme.paddingMedium

            PageHeader {
                title: qsTr("Login")
            }

            Rectangle {
                id:rectangle
                width: input.width + Theme.paddingMedium*2
                height: input.height + Theme.paddingMedium*2
                border.color:Theme.highlightColor
                color:"#00000000"
                radius: 30
                Column {
                    id:input
                    anchors{
                        top:rectangle.top
                        topMargin: Theme.paddingMedium
                    }

                    spacing: Theme.paddingMedium

                    TextField {
                        id:userName
                        width:loginComponent.width - Theme.paddingLarge*4
                        height:implicitHeight
                        font.pixelSize: Theme.fontSizeMedium
                        placeholderText: "Enter Username"
                        label: qsTr("UserName")
                    }
                    TextField {
                        id:password
                        width:loginComponent.width - Theme.paddingLarge*4
                        height:implicitHeight
                        font.pixelSize: Theme.fontSizeMedium
                        placeholderText: "Enter Password"
                        label: qsTr("Password")
                    }
                }
            }
            Button {
                anchors.horizontalCenter: parent.horizontalCenter
                text: qsTr("Login")
                onClicked: {
                    errorLabel.visible = false;
                    busyIndicator.running = true;
                    Script.logIn(userName.text,password.text)

                }
            }
            Label{
                id:regester
                text:"donot have accounts?"
                anchors{
                    right: parent.right
                    rightMargin: Theme.paddingMedium
                }
                font {
                    pixelSize: Theme.fontSizeSmall
                    family: Theme.fontFamilyHeading
                }
                MouseArea{
                    anchors.fill: parent
                    onClicked: pageStack.push(Qt.resolvedUrl("../RegisterPage.qml"))
                }
            }
        }

        Label {
            id:errorLabel
            anchors{
                top:column.bottom
                topMargin: Theme.paddingLarge * 2
                bottom: parent.bottom
                bottomMargin: Theme.paddingLarge
                horizontalCenter: parent.horizontalCenter
            }
            width: column.width
            color: Theme.highlightColor
            wrapMode: Text.WrapAtWordBoundaryOrAnywhere
            font.pixelSize: Theme.fontSizeExtraSmall
        }

        Connections {
            target: signalCenter
            onLoginSucceed: {
                errorLabel.visible = false;
                busyIndicator.running = false;
                loginComponent.loginSucceed();
            }
            onLoginFailed: {
                busyIndicator.running = false;
                errorLabel.visible = true;
                errorLabel.text = qsTr("Login fail")+" [ "+fail+" ]. " + qsTr("Please try again.");
            }
        }

    }
}
