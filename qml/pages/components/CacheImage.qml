import QtQuick 2.0
import Sailfish.Silica 1.0
import io.thp.pyotherside 1.3

Image{
    id:thumbnail
    asynchronous: true
    property string cacheurl: ""
    property bool cacheimg: opencache
    fillMode: Image.PreserveAspectFit;
    Python{
        id:imgpy
         Component.onCompleted: {
         addImportPath('/usr/share/harbour-9store/qml/py'); // adds import path to the directory of the Python script
         imgpy.importModule('image', function () {
                call('image.cacheImg',[cacheurl],function(result){
                    if(!result){
                        thumbnail.source = "file:////usr/share/harbour-9store/qml/img/default_avatar.png"
                    }else{
                        thumbnail.source = "file:///"+result;
                    }
                     waitingIcon.visible = false;
                });
       })
      }
    }
    Image{
        id:waitingIcon
        anchors.centerIn: parent
        fillMode: Image.PreserveAspectFit
        source: "image://theme/icon-m-refresh";
        //visible: parent.status==Image.Loading
    }

//    MouseArea {
//        anchors.fill: parent
//        onClicked: {
//            pageStack.push(Qt.resolvedUrl("ImagePage.qml"),
//                                  {} );
//               }
//        onPressAndHold: {
//            py.saveImg(MD5.hex_md5(objects.imagen),objects.imagen_leyenda+"."+GetDate.parseDate(currentDay));

//        }
//    }


}
