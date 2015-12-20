import QtQuick 2.0
import Sailfish.Silica 1.0
import "../../js/main.js" as Script
Column {
    width: parent.width
    spacing: Theme.paddingSmall
    Button {
        id: wizard

        property string selection

        anchors.horizontalCenter: parent.horizontalCenter
        text: qsTr("Add comment&Rate")
        onClicked: pageStack.push(firstWizardPage)
    }

    Label {
        anchors.horizontalCenter: parent.horizontalCenter
        text: wizard.selection
        color: Theme.highlightColor
    }

    Component {
        id: firstWizardPage

        Dialog {
            id:dialog
            canAccept: subcomments.text.length > 0
            acceptDestination: showappdetail
            acceptDestinationAction: PageStackAction.Pop
            allowedOrientations: Orientation.Landscape | Orientation.Portrait | Orientation.LandscapeInverted

            onAccepted: {
                var auth = user.auth;
                Script.sendComment(auth,showappdetail.appid,subcomments.text,ratingbox.score,sysinfo.phoneName);
            }

            Flickable {
                // ComboBox requires a flickable ancestor
                width: parent.width
                height: parent.height
                interactive: false
                anchors.fill: parent
//                PageHeader{
//                    id:dialogHead
//                    title:qsTr("Comments&Rate")
//                }

                Column{
                    id: column
                    width: parent.width
                    height: rectangle.height
                    DialogHeader {
                        title:qsTr("Comments&Rate")
                    }
                    anchors{
                        //top:dialogHead.bottom
                        left:parent.left
                        right:parent.right
                    }

                    spacing: Theme.paddingLarge
                    Rectangle{
                        id:rectangle
                        width: parent.width-Theme.paddingLarge
                        height: subcomments.height +ratingbox.height+slope.height+ Theme.paddingLarge*3
                        anchors.horizontalCenter: parent.horizontalCenter
                        border.color:Theme.highlightColor
                        color:"#00000000"
                        radius: 30
                        RatingBox{
                            id: ratingbox
                            optional:false
                            width:parent.width/3
                            height: parent.width/3/6
                            score:slope.value
                            anchors{
                                top:parent.top
                                horizontalCenter: parent.horizontalCenter
                                topMargin: Theme.paddingLarge
                            }
                        }
                        Slider {
                            id: slope
                            width: parent.width
                            value: 5.0
                            stepSize: 1.0
                            minimumValue: 0
                            maximumValue: 5.0
                            anchors{
                                top:ratingbox.bottom
                                topMargin: Theme.paddingMedium
                                horizontalCenter: parent.horizontalCenter
                            }
                        }
                        TextArea {
                            id:subcomments
                            anchors{
                                top:slope.bottom
                                topMargin: Theme.paddingMedium
                            }
                            //validator: RegExpValidator { regExp: /.{1,128}/ }
                            width:window.width - Theme.paddingLarge*4
                            height: Math.max(firstWizardPage.width/3, implicitHeight)
                            font.pixelSize: Theme.fontSizeMedium
                            wrapMode: Text.WordWrap
                            placeholderText: qsTr("input your comments")
                            EnterKey.onClicked : dialog.accept()
                            label: qsTr("Comments")
                        }
                    }

                }



            }
        }
    }

}
