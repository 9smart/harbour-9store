import QtQuick 2.0
import Sailfish.Silica 1.0
import "../../js/setting.js" as Script

BackgroundItem{
    id:showcomments
    height:((userPic.height + nick.height)>
                (c_type.height+ messageid.height )?
                 (userPic.height + nick.height):(c_type.height+ messageid.height ))
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

    CircleCacheImage{
       id:userPic
       width:Screen.width/6 - Theme.paddingMedium
       height:width
       cacheurl: from.avatar+"/hd"
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
         text:from.nickname
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
        id:c_type
        text:type == "c_app"?qsTr("comment app"):
                        //type == "r_comment"
                        qsTr("replay comment")
        font.pixelSize: Theme.fontSizeExtraSmall
        anchors {
            top:userPic.top
            left:userPic.right
            leftMargin: Theme.paddingMedium
        }
    }

    Label{
        id:c_conent
        text:type == "c_app"?target.appname:target.content
        font.pixelSize: Theme.fontSizeExtraSmall
        maximumLineCount : 1
        anchors {
            top:c_type.top
            left:c_type.right
            leftMargin: Theme.paddingSmall
            right:parent.right
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
            top:c_conent.bottom
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
    //ListView.onRemove: animateRemoval()

    ContextMenu {
        id:contextMenu
        MenuItem {
            text: qsTr("Clear")
            onClicked:{
                Script.clearNotifyData(_id)
                notifyModel.remove(index)
                contextMenu.hide()
            }
        }
    }

    onClicked: {
      if(!showhistory){
        return;
      }
      contextMenu.show(showcomments)
    }

    // onPressAndHold: {
    // }

}
