import QtQuick 2.0
import Sailfish.Silica 1.0

SilicaGridView {
    id: gridView
    clip: true
    height: childrenRect.height
    width: childrenRect.width
    currentIndex: -1
    cellWidth: gridView.width / 3
    cellHeight: cellWidth
    cacheBuffer: 2000;
    delegate: BackgroundItem {
        id: rectangle
        width: gridView.cellWidth
        height: gridView.cellHeight
        Label{
            id: moreAppname
            x: morepic.width/2
            text:appname
            width:rectangle.width-Theme.paddingMedium
            truncationMode: TruncationMode.Elide
            anchors.left: parent.left
            anchors.leftMargin: Theme.paddingMedium
            font {
                pixelSize: Theme.fontSizeSmall
                family: Theme.fontFamilyHeading
            }
        }
        RatingBox{
            id:ratingbox
            score:(scores/ratingnum)
            width:rectangle.width/2
            height: ratingbox.width/5
            optional:false
            anchors{
                left:parent.left
                top:moreAppname.bottom
                margins: Theme.paddingMedium
            }
        }
        Label{
            id:moreimgid
            height: parent.width/2
            width:moreimgid.height
            anchors{
                left:parent.left
                right:parent.right
                top:ratingbox.bottom
                margins: Theme.paddingMedium
            }
            CacheImage{
                id:morepic
                //anchors.fill: parent
                asynchronous: true
                cacheurl: icon
                fillMode: Image.PreserveAspectFit;
                width: parent.height
                height:parent.height
                Image{

                    anchors.fill: parent;
                    source: "../../img/App_icon_Loading.svg";
                    visible: parent.status==Image.Loading;
                }
                Image{

                    anchors.fill: parent;
                    source: "../../img/App_icon_Error.svg";
                    visible: parent.status==Image.Error;
                }
            }
        }
        onClicked :{
            pageStack.push(Qt.resolvedUrl("../AppDetail.qml"),{
                                  "appid":appid,
                                  "author":author,
                                  "icon":icon,
                                  "appname":appname
                              })
        }

    }

    //VerticalScrollDecorator {}

}

