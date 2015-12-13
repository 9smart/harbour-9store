import QtQuick 2.0
import Sailfish.Silica 1.0

Item{
    anchors.fill: parent
    PathView {
        z:10
        id: banner;
        y:-height-view.contentY;
        //            opacity: view.contentY/height > 1 ? 0 : 1-view.contentY/height;
        //            visible: opacity>0.0;
        width: parent.width;
        height: Math.floor(width *21/32);

        model: ListModel{}
        preferredHighlightBegin: 0.5;
        preferredHighlightEnd: 0.5;
        path: Path {
            startX: -banner.width*banner.count/2 + banner.width/2;
            startY: banner.height/2;
            PathLine {
                x: banner.width*banner.count/2 + banner.width/2;
                y: banner.height/2;
            }
        }
        delegate: Item {
            implicitWidth: banner.width;
            implicitHeight: banner.height;
            clip:true
            Image {
                anchors.centerIn: parent;
                fillMode: Image.PreserveAspectCrop;
                source: previewImg.status === Image.Ready
                        ? "" : "img/image_loading_light.png";
            }
            Image {
                id: previewImg;
                anchors.fill: parent;
                fillMode: Image.PreserveAspectCrop;
                //smooth: true;
                source: image;
            }
            Rectangle{
                width: parent.width;
                height: parent.height;
                //anchor.fill:parent;
                gradient: Gradient {
                    GradientStop { position: 0.5; color: "#00000000" }
                    GradientStop { position: 1.0; color:"#08202c" }
                }
            }
            Label{
                id:articatitle
                anchors{
                    left: parent.left
                    right: parent.right
                    bottom: parent.bottom
                    margins: css.paddingM
                }
                text:title
                font.pixelSize: css.fontSmall;
                wrapMode: Text.WrapAnywhere;
                font.letterSpacing: 2;
                color: css.clMid
            }
            Rectangle {
                anchors.fill: parent;
                color: "black";
                opacity: mouseArea.pressed ? 0.3 : 0;
            }
            MouseArea {
                id: mouseArea;
                anchors.fill: parent;
                onClicked: {
                    pageStack.push(Qt.resolvedUrl("../AppDetail.qml"),{"appid":appid});
                }
            }
        }
        Timer {
            running: Qt.application.active && banner.count > 1 && !banner.moving && !view.moving;
            interval: 3000;
            repeat: true;
            onTriggered: banner.incrementCurrentIndex();
        }
    }
    Rectangle{
        z:8
        anchors.top:banner.bottom
        //            opacity: view.contentY/banner.height > 1 ? 0 : 1-view.contentY/banner.height;
        //            visible: opacity>0.0;
        width: parent.width;
        height: Math.floor(width *21/64);
        gradient: Gradient {
            GradientStop { position: 0; color: "#08202c" }
            GradientStop { position: 1.0; color: "#00000000" }
        }
    }
    Row{
        z:11
        anchors.left: parent.left;
        anchors.bottom: banner.bottom
        //            opacity: view.contentY/banner.height > 1 ? 0 : 1-view.contentY/banner.height;
        //            visible: opacity>0.0;
        Repeater{
            model: 5
            Rectangle{
                width: css.win_w/5
                height: 10
                color: banner.currentIndex==index?"#22ffffff":"#44000000"
                MouseArea {
                    anchors.fill: parent;
                    onClicked: {
                        banner.currentIndex=index;
                    }
                }
            }
        }
    }
}
