import QtQuick 2.0
import Sailfish.Silica 1.0
BackgroundItem {
        id: rectangle
        height: (parent.width - Theme.paddingMedium ) / 3
        width: (parent.width - Theme.paddingMedium ) / 3
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


        Label{
            id:moreimgid
            height: parent.width/2
            width:moreimgid.height
            anchors{
                left:parent.left
                right:parent.right
                top:moreAppname.bottom
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
                //source: icon
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
        RatingBox{
            id:ratingbox
            score:(scores/ratingnum)
            width:rectangle.width/2
            height: ratingbox.width/5
            optional:false
            opacity: 0.7
            anchors{
                left:parent.left
                top:moreimgid.bottom
                leftMargin: Theme.paddingMedium
                rightMargin:  Theme.paddingMedium
                bottomMargin: Theme.paddingMedium
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
