import QtQuick 2.0
import Sailfish.Silica 1.0
import QtDocGallery 5.0
import org.nemomobile.thumbnailer 1.0
Component{
    CacheImage{
        height:window.height/3-Theme.paddingMedium
        width:window.width/3-Theme.paddingMedium
        smooth:true;
        cacheurl:model.thumburl;
        Rectangle{
            anchors.fill: parent;
            color: "lightgray";
            visible: parent.status!=Image.Ready;
        }
        MouseArea {
            anchors.fill: parent
            onClicked: window.pageStack.push(Qt.resolvedUrl("ImagePage.qml"),
                                             {currentIndex: index, model: screenshotview.model} )
        }
    }
}
