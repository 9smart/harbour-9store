import QtQuick 2.0
import Sailfish.Silica 1.0
import "components"
import com.stars.widgets 1.0

Page{

    SilicaFlickable{
        id:fickable
        anchors.fill: parent
        VerticalScrollDecorator {}
        PageHeader{
            id:header
            title:qsTr("Settings")
        }
        contentHeight: colum.height
        Item{
            id:colum
            anchors.top: header.bottom
            width: parent.width
            height: user_avatar.height + user_nickname.height
            Item{width:1;height:1}
            MyImage{
                id:user_avatar
                anchors.top: parent.top
                anchors.horizontalCenter: parent.horizontalCenter
                width: parent.width/4
                height: parent.width/4
                smooth: true
                source: user.avatar
                maskSource: "../img/mask.bmp"
                cache: true
                MouseArea{
                    anchors.fill: parent
//                    onClicked: {
//                        if(user_avatar.maskSource=="")
//                            user_avatar.maskSource="qrc:/Image/mask.bmp"
//                        else
//                            user_avatar.maskSource=""
//                    }
                }
            }
            Item{width:1;height:1}
            Text {
                id: user_nickname
                text: user.nickName
                anchors.top: user_avatar.bottom
                anchors.topMargin: Theme.paddingMedium
                anchors.horizontalCenter: parent.horizontalCenter
                font.pointSize: Theme.fontSizeMedium
                color: Theme.highlightColor
            }

            Item{width:1;height:1}
            Item{
                width: parent.width
                height:cacheSwitch.height
                anchors.top: user_nickname.bottom
                TextSwitch {
                    id: cacheSwitch
                    checked: false
                    text: qsTr("Cache Img")
                }

            }
        }

    }


}
