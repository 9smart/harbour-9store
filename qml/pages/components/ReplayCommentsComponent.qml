import QtQuick 2.0
import Sailfish.Silica 1.0

Page{
    id:replaysPage
    property ListModel replaysmodel
    property string _id
    property alias replaysTmpModel:replaystmpModel
    signal commentSendSuccessful

    ListModel{
        id:replaystmpModel
    }

    SilicaListView {
        id: commentsView
        header:PageHeader {
            id:commentsheader
            title: qsTr("Replys")
        }
        clip: true
        anchors.fill: parent
        delegate:  BackgroundItem{
            id:showcomments
            height:((userPic.height + nick.height)>
                        (phoneModel.height+ messageid.height )?
                         (userPic.height + nick.height):(phoneModel.height+ messageid.height))
                         +(contextMenu.active?contextMenu.height:0)
                        + Theme.paddingMedium * 4
            contentHeight: height
            width: parent.width
            anchors.leftMargin: Theme.paddingSmall
            anchors.rightMargin: Theme.paddingSmall

            Label{
                id:date
                text:getLocalTime(dateline)
                font.pixelSize: Theme.fontSizeExtraSmall
                font.italic: true
                horizontalAlignment: Text.AlignRight
                anchors{
                    right:parent.right
                    top:userPic.top
                    rightMargin: Theme.paddingMedium
                }
            }

            CircleCacheImage{
               id:userPic
               width:Screen.width/6 - Theme.paddingMedium
               height:width
               cacheurl: author.avatar+"/hd"
               smooth: true;
               cache: true
               anchors {
                   left: parent.left
                   top:parent.top
                   leftMargin: Theme.paddingSmall
                   topMargin: Theme.paddingMedium
               }
               maskSource: "../../img/mask.bmp"
           }
             Label{
                 id:nick
                 text:author.nickname
                 font.pixelSize: Theme.fontSizeExtraSmall * 0.7
                 horizontalAlignment: Text.AlignLeft
                 truncationMode: TruncationMode.Elide
                 maximumLineCount: 3
                 wrapMode: Text.WordWrap
                 anchors {
                     top:userPic.bottom
                     horizontalCenter: userPic.horizontalCenter
                     topMargin: Theme.paddingSmall
                 }
             }

            Label{
                id:phoneModel
                text:qsTr("from:")+model
                font.pixelSize: Theme.fontSizeExtraSmall
                anchors {
                    top:userPic.top
                    left:userPic.right
                    leftMargin: Theme.paddingMedium
                }
            }
            Label{
                id:messageid
                text:content
                width: parent.width-userPic.width-Theme.paddingMedium
                font.pixelSize: Theme.fontSizeExtraSmall
                wrapMode: Text.WordWrap
                color: Theme.highlightColor
                textFormat: Text.AutoText
                horizontalAlignment: Text.AlignLeft
                truncationMode: TruncationMode.Elide
                anchors {
                    top:phoneModel.bottom
                    left:userPic.right
                    margins: Theme.paddingMedium
                }
            }

            //model
            Separator {
                visible: (index>0?true:false)
                width:parent.width;
                color: Theme.highlightColor
            }
            ContextMenu {
                id:contextMenu
                MenuItem {
                    text: qsTr("Replay")
                    onClicked:{
                        pageStack.push(Qt.resolvedUrl("SubmitCommentComponent.qml"),{
                                                                            "parentpage":replaysPage,
                                                                            "cid":_id,
                                                                            "foolreplay":"@"+author.nickname+": ",
                                                                            "replaysTmpModel":replaysTmpModel
                                                                        })
                    }
                }
            }

            onPressAndHold: {
                contextMenu.show(showcomments)
            }
        }
        VerticalScrollDecorator {}
    }

    Component.onCompleted: {

        commentsView.model = replaysmodel
        console.log("count:"+replaysmodel.count)
    }

    Connections{
        target: signalCenter
        onCommentSendSuccessful:{
            if(replaysTmpModel&&replaysTmpModel.count > 0){
               replaysmodel.append(replaysTmpModel.get(0))
            }
        }
    }
}
