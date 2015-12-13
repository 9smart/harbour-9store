import QtQuick 2.0
import Sailfish.Silica 1.0
Row {
    spacing: Theme.paddingLarge
    anchors.horizontalCenter: parent.horizontalCenter

    BusyIndicator {
        running: true
        size: BusyIndicatorSize.Large
        anchors.verticalCenter: parent.verticalCenter
    }
}
