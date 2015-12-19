
import QtQuick 2.0
import Sailfish.Silica 1.0

Item {
    property alias label: label.text
    width: parent.width
    height:label.height
    anchors {
        right: parent.right
        left: parent.left
    }
    Separator {
        id:separator
        width:parent.width - label.width;
        color: Theme.highlightColor
        anchors{
            right: label.left
            top:label.top
            topMargin: label.height/2
            margins: Theme.paddingLarge
        }
    }
    Label {
        id: label
        //width: parent.width
        color: Theme.highlightColor
        font.pixelSize: Theme.fontSizeExtraSmall
        anchors{
            right: parent.right
            margins: Theme.paddingLarge
        }
    }


}
