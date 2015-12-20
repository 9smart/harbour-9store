import QtQuick 2.0
import io.thp.pyotherside 1.4

Canvas{
    id:canvas
    property bool asynchronous: true
    property string cacheurl: ""
    property bool cacheimg: opencache
    property string localpath

    Python{
        id:imgpy
         Component.onCompleted: {
             addImportPath(Qt.resolvedUrl('.././py')); // adds import path to the directory of the Python script
             imgpy.importModule('image', function () {
                    call('image.cacheImg',[cacheurl],function(result){
                         localpath = result;
                        loadImage(localpath)
                    });
           })
      }
    }

    onPaint:{
            var ctx = getContext("2d")
            ctx.fillStyle = "#00FFFFFF";
            ctx.fillRect(0, 0, canvas.width, canvas.height);
            ctx.beginPath();
            ctx.arc(canvas.width/2, canvas.height/2, 100, 0, Math.PI * 2, true);
            ctx.closePath();
            ctx.clip();
            ctx.drawImage(localpath, 0, 0)
        }

       Component.onCompleted: loadImage(localpath)


}
