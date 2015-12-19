import QtQuick 2.0
import Sailfish.Silica 1.0

BackgroundItem{
    id:showcomments
    //height:(userPic.height>messageid.height?(userPic.height+nick.height):(messageid.height+nick.height))
    height:nick.height + ((userPic.height + scoreBox.height) > messageid.height?(userPic.height + scoreBox.height):messageid.height)
                + Theme.paddingMedium * 3
    contentHeight: height
    width: parent.width
    anchors.leftMargin: Theme.paddingSmall
    anchors.rightMargin: Theme.paddingSmall
    Label{
        id:nick
        text:author.nickname
        font.pixelSize: Theme.fontSizeSmall
        color: Theme.highlightColor
        horizontalAlignment: Text.AlignLeft
        truncationMode: TruncationMode.Elide
        width: parent.width
        anchors {
            top:parent.top
            left: parent.left
            leftMargin: Theme.paddingSmall
            topMargin: Theme.paddingSmall
        }
    }

    Label{
        id:date
        text:getLocalTime(dateline)
        font.pixelSize: Theme.fontSizeExtraSmall
        font.italic: true
        horizontalAlignment: Text.AlignRight
        anchors{
            right:parent.right
            top:nick.top
            rightMargin: Theme.paddingMedium
        }
    }
     CacheImage{
        id:userPic
        width:Screen.width/5 - Theme.paddingMedium
        height:width
        cacheurl: author.avatar
        asynchronous: true
        anchors {
            left: parent.left
            top:nick.bottom
            leftMargin: Theme.paddingSmall
            topMargin: Theme.paddingMedium
            //verticalCenter:parent.verticalCenter
        }
    }
    RatingBox {
        id:scoreBox
        score:score
        optional:false
        opacity: 0.9
        width: userPic.width
        height: width/5
        anchors {
            top:userPic.bottom
            leftMargin: Theme.paddingMedium
            topMargin: Theme.paddingSmall
        }
    }



    Label{
        id:messageid
        text:content
        width: parent.width-userPic.width-Theme.paddingMedium
        font.pixelSize: Theme.fontSizeExtraSmall
        wrapMode: Text.WordWrap
        textFormat: Text.AutoText
        horizontalAlignment: Text.AlignLeft
        truncationMode: TruncationMode.Elide
        anchors {
            top:userPic.top
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

}
