import QtQuick 2.0
import Sailfish.Silica 1.0

Item{
    width: parent.width
    height: downprogress.height + statusName.height + Theme.paddingMedium *2
    signal currentAppmanaged(string result)
    Label{
        id:statusName
        width: parent.width
        color: Theme.primaryColor
        font.pixelSize: Theme.fontSizeSmall
        wrapMode: Text.Wrap
        anchors{
            top:parent.top
            topMargin: Theme.paddingMedium
            horizontalCenter: parent.horizontalCenter
        }
    }

    ProgressBar {
        id:downprogress
        visible: false
        anchors{
            top: statusName.bottom
            topMargin: Theme.paddingMedium
            horizontalCenter: parent.horizontalCenter
        }
        value: currper
        minimumValue:0
        maximumValue:100
        width: parent.width - Theme.paddingLarge
    }

    Button{
        id:openLabel
        text:qsTr("Open a image")
        anchors.horizontalCenter: parent.horizontalCenter
        //onClicked: pageStack.push(Qt.resolvedUrl("PreviewGrid.qml"));

    }

    Connections{
        target: signalCenter
        onCurrentAppmanaged:{
            console.log("result:"+result)
            openLabel.text = result
        }
    }


}
