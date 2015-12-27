import QtQuick 2.0
import Sailfish.Silica 1.0
import "../../js/main.js" as Script

Dialog {
    id:dialog
    property Page parentpage;
    property string cid;
    property string appid;
    property string foolreplay;
    property ListModel replaysTmpModel
    canAccept: subcomments.text.length > 2 && subcomments.text.length < 81
    acceptDestination: parentpage
    acceptDestinationAction: PageStackAction.Pop
    acceptDestinationProperties:replaysTmpModel

    onAccepted: {
        var auth = user.auth;
        //评论楼中楼
        if(cid){
            if(foolreplay){
                Script.sendReplayComment(auth,cid,foolreplay+subcomments.text,sysinfo.phoneName);
                replaysTmpModel.append(
                                    {
                                        "author": {
                                                "uid": user._id,
                                                "nickname": user.nickName,
                                                "avatar": user.avatar
                                                },
                                        "dateline": new Date().getTime(),
                                        "content": foolreplay+subcomments.text,
                                        "model": sysinfo.phoneName
                                        }
                                )
            }else{
                Script.sendReplayComment(auth,cid,subcomments.text,sysinfo.phoneName)
            }


        }else{
        //评论app
           Script.sendComment(auth,appid,subcomments.text,slope.value,sysinfo.phoneName);
        }


    }


    Flickable {
        // ComboBox requires a flickable ancestor
        width: parent.width
        height: parent.height
        interactive: false
        anchors.fill: parent
        Column{
            id: column
            width: parent.width
            height: rectangle.height
            DialogHeader {
                title:cid?qsTr("Replay"):qsTr("Comments&Rate")
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
                    visible: !cid
                    width:parent.width/3
                    height: parent.width/3/6
                    score_n:slope.value
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
                    visible: !cid
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
                    height: Math.max(dialog.width/3, implicitHeight)
                    font.pixelSize: Theme.fontSizeMedium
                    wrapMode: Text.WordWrap
                    placeholderText: qsTr("max 80 character")
                    EnterKey.onClicked : dialog.accept()
                    label: qsTr("Comments")
                }
            }

        }



    }
}



