import QtQuick 2.0
import Sailfish.Silica 1.0
//import org.pycage.jollastore 1.0

BackgroundItem {
    id: feedItem

    property var model: null

    width: parent.width
    height: width / 4 + appTitleLabel.height + Theme.paddingMedium + Theme.paddingSmall
    visible: model !== null

    onClicked: {
        if (model.collection !== "") {
            navigationState.openCategory(model.collection, ContentModel.TopNew);
        } else {
            navigationState.openApp(model.appUuid, ApplicationState.Normal);
        }
    }

    Image {
        id: typeIcon

        property int itemType: model ? model.itemType : Feed.Unknown

        anchors {
            verticalCenter: titleLabel.verticalCenter
            right: parent.horizontalCenter
            rightMargin: Theme.paddingMedium
        }
        source: {
            var src = "image://theme/icon-"
            if (itemType === Feed.Like) {
                src += "s-like"
            } else if (itemType === Feed.Comment) {
                src += "s-chat"
            } else if (itemType === Feed.New) {
                src += "s-new"
            } else {
                src += "m-jolla"
            }
            src += "?" + Theme.highlightColor
            return src
        }
    }

    Label {
        id: titleLabel
        anchors {
            left: parent.left
            leftMargin: Theme.paddingLarge
            right: typeIcon.left
            rightMargin: Theme.paddingMedium
            top: parent.top
        }
        font.pixelSize: Theme.fontSizeExtraSmall
        color: Theme.highlightColor
        truncationMode: TruncationMode.Fade
        text: model ? model.title : ""
    }

    Label {
        id: textLabel
        anchors {
            left: parent.left
            leftMargin: Theme.paddingLarge
            right: parent.horizontalCenter
            rightMargin: Theme.paddingLarge
            top: titleLabel.bottom
            topMargin: Theme.paddingMedium
        }
        color: feedItem.highlighted ? Theme.highlightColor : Theme.primaryColor
        font.pixelSize: Theme.fontSizeExtraSmall
        wrapMode: Text.Wrap
        maximumLineCount: 3
        text: model ? model.description : ""
    }

//    AppImage {
//        id: appImage

//        property string appCover: model ? model.cover : ""
//        property string appIcon: model ? model.icon : ""

//        anchors {
//            left: parent.horizontalCenter
//            right: parent.right
//            bottom: appTitleLabel.top
//            bottomMargin: appCover !== "" ? Theme.paddingSmall : Theme.paddingMedium
//        }
//        height: appCover !== "" ? width / 2 : Theme.itemSizeSmall
//        image: appCover !== "" ? appCover : appIcon
//    }

    Label {
        id: appTitleLabel
        width: Math.min(implicitWidth, 0.4 * feedItem.width)
        anchors {
            bottom: parent.bottom
            bottomMargin: Theme.paddingMedium + (appImage.appCover === "" ? height : 0)
            horizontalCenter: appImage.horizontalCenter
        }
        color: feedItem.highlighted ? Theme.highlightColor : Theme.primaryColor
        font.pixelSize: Theme.fontSizeExtraSmall
        truncationMode: TruncationMode.Fade
        text: model ? model.appTitle : ""
    }
}
