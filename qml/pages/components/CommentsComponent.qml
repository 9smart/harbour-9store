import QtQuick 2.0
import Sailfish.Silica 1.0


BackgroundItem{
    id:showcomments
    height:((userPic.height + nick.height)>
                (phoneModel.height+ messageid.height + numbers.height)?
                 (userPic.height + nick.height):(phoneModel.height+ messageid.height + numbers.height))
                + Theme.paddingMedium * 4
                +(contextMenu.active?contextMenu.height:0)
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

    Image{
        id:userPic
        anchors {
            left: parent.left
            top:parent.top
            leftMargin: Theme.paddingSmall
            topMargin: Theme.paddingMedium
        }
        width:Screen.width/6 - Theme.paddingMedium
        height:width
        fillMode: Image.PreserveAspectFit;
        CircleCacheImage{
           id:circulcache
           visible: opencircle
           cacheurl: author.avatar+"/hd"
           anchors.fill: parent
           smooth: true;
           cache: true
           maskSource: "../../img/mask.bmp"
           width: parent.width
           height: parent.height
       }
        CacheImage{
            id:cacheimg
            visible: !opencircle
            cacheurl: author.avatar+"/hd"
            anchors.fill: parent
            width: parent.width
            height: parent.height
        }

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
        text:qsTr("from:")+model+" "+qsTr("ratings:")
        font.pixelSize: Theme.fontSizeExtraSmall
        anchors {
            top:userPic.top
            left:userPic.right
            leftMargin: Theme.paddingMedium
        }
    }
    RatingBox {
        id:scoreBox
        score_n:score
        optional:false
        opacity: 0.9
        width: userPic.width
        height: width/5
        anchors {
            verticalCenter: phoneModel.verticalCenter
            left:phoneModel.right
        }
    }
    Label{
        id:numbers
        text:qsTr("replays:(")+reply_num+")"
        font.pixelSize: Theme.fontSizeSmall
        color: Theme.highlightColor
        anchors {
            top:messageid.bottom
            topMargin: Theme.paddingMedium
            right: parent.right
            rightMargin: Theme.paddingMedium
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
                                                                    "parentpage":commentsPage,
                                                                    "cid":_id
                                                                })
            }
        }
    }

    onClicked: {
        if(reply_num == 0){
            return
        }
         pageStack.push(Qt.resolvedUrl("ReplayCommentsComponent.qml"),{"replaysmodel":replys,
                                                                        "_id":_id})
    }

    onPressAndHold: {
        contextMenu.show(showcomments)
    }

}
