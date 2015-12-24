import QtQuick 2.0
import Sailfish.Silica 1.0
import io.thp.pyotherside 1.3
import com.stars.widgets 1.0

MyImage{
    id:thumbnail
    //asynchronous: true
    property string cacheurl
    property bool cacheimg: opencache

    Python{
        id:imgpy
         Component.onCompleted: {
         addImportPath('/usr/share/harbour-9store/qml/py'); // adds import path to the directory of the Python script
         imgpy.importModule('image', function () {
                call('image.cacheImg',[cacheurl],function(result){
                    if(!result){
                        thumbnail.source = "file:///usr/share/harbour-9store/qml/img/default_avatar.png"
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
        source: "../../img/default_avatar.png";
        visible: parent.status==Image.Error
    }
}
