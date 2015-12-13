import QtQuick 2.0
import io.thp.pyotherside 1.4
import "../../js/md5.js" as MD5

Canvas{
    id:canvas
    width: parent.width
    height: parent.height
    property string cacheurl: ""
    property bool cacheimg: opencache
    property real centerWidth: width / 2
    property real centerHeight: height / 2
    property real radius: Math.min(canvas.width, canvas.height) / 2
    property real angleOffset: -Math.PI / 2
    property string localpath: ""
    Python{
        id:imgpy
         Component.onCompleted: {
              addImportPath(Qt.resolvedUrl('../../py'));
                 imgpy.importModule('image', function () {
                        var imglist=cacheurl.split(".")
                        var imgtype=imglist[imglist.length-1]
                        call('image.cacheImg',[cacheurl,MD5.hex_md5(cacheurl),imgtype],function(result){
                             localpath = result;
                        });
           });
      }
    }
    onPaint: {
            var ctx = getContext("2d")
            // draw an image
            ctx.drawImage(localpath, width, height)

            // store current context setup
            ctx.save()
            ctx.clearRect(0, 0, canvas.width, canvas.height);
            // create a triangle as clip region
            ctx.beginPath()
            ctx.strokeStyle = "#00FFFFFF"
            ctx.closePath()
            ctx.arc(canvas.centerWidth,
                        canvas.centerHeight,
                        canvas.radius,
                        angleOffset + canvas.angle,
                        angleOffset + 2*Math.PI);
            ctx.clip()  // create clip from triangle path
            // draw image with clip applied
            ctx.drawImage(localpath, width, height)
            // draw stroke around path
            ctx.stroke()
            // restore previous setup
            ctx.restore()

        }

        Component.onCompleted: {
            loadImage(localpath)
        }
}
