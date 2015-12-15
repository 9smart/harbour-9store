import QtQuick 2.0
import Sailfish.Silica 1.0
import "../../js/main.js" as Script
BackgroundItem {
        id: rectangle
        height: (parent.width - Theme.paddingMedium ) / 3
        width: (parent.width - Theme.paddingMedium ) / 3
        Label{
            id: moreAppname
            text:appname
            //width:rectangle.width-Theme.paddingMedium
            truncationMode: TruncationMode.Elide
            anchors.horizontalCenter: parent.horizontalCenter
            maximumLineCount: 1
            wrapMode: Text.WordWrap
            font {
                pixelSize: Theme.fontSizeSmall
                family: Theme.fontFamilyHeading
            }
        }

        CacheImage{
            id:morepic
            height: parent.width/2
            width:height
            anchors{
                left:parent.left
                right:parent.right
                top:moreAppname.bottom
                margins: Theme.paddingMedium
            }
            asynchronous: true
            cacheurl: Script.getAppicon(uploader.uid,_id)
            fillMode: Image.PreserveAspectFit;
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

        RatingBox{
            id:ratingbox
            score:score_num == 0?0:(scores/score_num)
            width:rectangle.width/2
            height: ratingbox.width/5
            optional:false
            opacity: 0.9
            anchors{
                top:morepic.bottom
                horizontalCenter: parent.horizontalCenter
                bottomMargin: Theme.paddingMedium
            }
        }
        onClicked :{
            pageStack.push(Qt.resolvedUrl("../AppDetail.qml"),{
                                  "appid":_id,
                                  "author":developer,
                                  "icon":morepic.source,
                                  "appname":appname
                              })
        }

    }
