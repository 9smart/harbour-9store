import QtQuick 2.0
import Sailfish.Silica 1.0
import "../../js/main.js" as Script

BackgroundItem{
    id:showlist
    contentHeight: appnameid.height + authorname.height + apppic.width/5 + Theme.paddingLarge*2
    width: parent.width
    height: contentHeight
    CacheImage{
        id:apppic
        asynchronous: true
        cacheurl: Script.getAppicon(uploader.uid,_id)
        fillMode: Image.PreserveAspectFit;
        width:  Screen.height/12
        height: Screen.height/12
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

        anchors {
            left: parent.left
            top:parent.top
            leftMargin: Theme.paddingSmall
            topMargin: Theme.paddingMedium
            bottomMargin: Theme.paddingMedium
            verticalCenter:parent.verticalCenter
        }
    }
    Label{
        id:appnameid
        text:appname
        width: parent.width-apppic.width-Theme.paddingSmall
        font.pixelSize: Theme.fontSizeMedium
        color: Theme.highlightColor
        opacity:0.8
        font.bold: true
        //truncationMode: TruncationMode.Fade
        horizontalAlignment: Text.AlignLeft
        truncationMode: TruncationMode.Elide
        anchors {
            top:apppic.top
            left: apppic.right
            leftMargin: Theme.paddingLarge
        }
    }
    IconButton{
        id:download
        visible: false
        //图标根据是否升级，是否已经安装再定
        icon.source: "image://theme/icon-s-cloud-download"
        anchors{
            right:parent.right
            verticalCenter:parent.verticalCenter
        }
        //            onClicked: {
        //                console.log("Append to download tasklist");
        //                downList.push(appid)
        //                addNotification(appname+qsTr(" append to download list"),3);

        //            }
    }
    Label{
        id:authorname
        x:apppic.width+Theme.paddingSmall
        text:developer
        font.pixelSize: Theme.fontSizeExtraSmall * 4 / 3
        horizontalAlignment: Text.AlignLeft
        anchors {
            top:appnameid.bottom
            left: apppic.right
            leftMargin: Theme.paddingLarge
            topMargin: Theme.paddingSmall
        }
    }


    RatingBox {
        score:score_num?(score_num == 0?0:(scores/score_num)):0
        width:apppic.width
        height: apppic.width/5
        optional:false
        anchors {
            left: apppic.right
            top:authorname.bottom
            leftMargin: Theme.paddingLarge
            topMargin: Theme.paddingSmall
        }
    }

    Separator {
        visible: (index>0?true:false)
        width:parent.width;
        color: Theme.highlightColor
    }

    onClicked: {
        pageStack.push(Qt.resolvedUrl("../AppDetail.qml"),{
                           "appid":_id,
                           "appname":appname,
                           "developer":developer,
                           "icon":apppic.source,
                           "category":category,
                           "scores":scores,
                           "score_num":score_num,
                           "dateline":dateline
                       })
    }

}
