import QtQuick 2.0
import Sailfish.Silica 1.0

BackgroundItem{
    id:showcomments
    //height:(userPic.height>messageid.height?(userPic.height+nick.height):(messageid.height+nick.height))
    height: scoreBox.height+nick.height+messageid.height+Theme.paddingMedium*4
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
        width: parent.width-userPic.width
        anchors {
            top:parent.top
            left: parent.left
            leftMargin: Theme.paddingSmall
            topMargin: Theme.paddingSmall
        }
    }

     CacheImage{
        id:userPic
        width:Screen.width/5
        height:Screen.width/5
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
        //width:parent.width
        anchors {
            left: userPic.right
            top:parent.top
            leftMargin: Theme.paddingMedium
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
            bottom:parent.bottom
            bottomMargin: Theme.paddingMedium
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
            top:scoreBox.bottom
            left:userPic.right
            leftMargin: Theme.paddingMedium
        }
    }

    //model
    Separator {
        visible: (index>0?true:false)
        width:parent.width;
        color: Theme.highlightColor
    }

}
