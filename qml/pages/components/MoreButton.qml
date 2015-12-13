import QtQuick 2.0
import Sailfish.Silica 1.0

BackgroundItem {
    id: morePanel

    property alias text: moreLabel.text

    height: Theme.itemSizeSmall

    Label {
        id: moreLabel
        anchors {
            left: parent.left
            leftMargin: Theme.paddingLarge
            right: morePanel.enabled ? moreImage.left : parent.right
            rightMargin: morePanel.enabled ? Theme.paddingMedium : Theme.paddingLarge
            verticalCenter: parent.verticalCenter
        }
        horizontalAlignment: Text.AlignRight
        truncationMode: TruncationMode.Fade
        color: (morePanel.highlighted || !morePanel.enabled)
               ? Theme.highlightColor
               : Theme.primaryColor
    }

    Image {
        id: moreImage
        anchors {
            right: parent.right
            rightMargin: Theme.paddingLarge
            verticalCenter: parent.verticalCenter
        }
        visible: morePanel.enabled
        source: "image://theme/icon-m-right?"
                + (morePanel.highlighted ? Theme.highlightColor : Theme.primaryColor)
    }
}
