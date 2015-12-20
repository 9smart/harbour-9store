import QtQuick 2.0
import Sailfish.Silica 1.0
import "../../js/main.js" as Script

Item{
    height: infomess.height+summaryid.height+screenShotLabel.height+
            oteherAppsItem.height+commentsItem.height+
            rateItem.height+relatedItem.height+Theme.paddingLarge *2
            +downprogress.height
            + screenshotslt.height * 4

    CacheImage{
        id:appicon
        asynchronous: true
        cacheurl:icon//Script.getAppicon(uploaderuid,appid)
        fillMode: Image.PreserveAspectFit;
        width:  window.height/8-Theme.paddingMedium
        height: window.height/8-Theme.paddingMedium
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
            leftMargin: window.width/3-appicon.width - Theme.paddingMedium
            topMargin: Theme.paddingSmall
        }

    }
    Label{
        id:versionid
        width: appicon.width
        text:"<font size='2' > "+qsTr("downloads")+":</font><font size='1' >"+downloads+"</font><br/>"
             //+"<font size='2' > "+qsTr("views")+":</font><font size='1' >"+views+"</font><br/>"
        font.pixelSize: Theme.fontSizeExtraSmall
        truncationMode: TruncationMode.Fade
        anchors {
            left: appicon.left
            top:appicon.bottom
            leftMargin: Theme.paddingSmall
        }
    }
    Label{
        id:infomess
        //Format.formatFileSize()
        text:type+"->"+category+"<br/>"+
             "<font size='2' > "+qsTr("version")+":</font><font size='1' >"+version+"</font><br/>"+
             "<font size='2' > "+qsTr("filesize")+":</font><font size='1' >"+(sysinfo.cpuModel == "arm"?size:x86size)+"</font><br/>"+
             "<font size='2' > "+qsTr("dateline")+":</font><font size='1' >"+getLocalTime(dateline)+"</font>"
        font.pixelSize: Theme.fontSizeExtraSmall*5/4
        horizontalAlignment: Text.AlignLeft
        anchors {
            top:appicon.top
            left:appicon.right
            //topMargin: Theme.paddingSmall
            leftMargin: Theme.paddingLarge*2
        }


    }


    CurrentOpeartion{
        id:downprogress
        anchors{
            left:parent.left
            right:parent.right
            top:infomess.bottom
        }
    }


    DetailLabelText{
        id:screenshotslt
        width:parent.width;
        label: qsTr("ScreenShots")
        anchors{
            top:downprogress.bottom
            topMargin: Theme.paddingMedium
        }

    }

    Label{
        id:screenShotLabel
        height: (screenShotModel.count>0?(window.height/3-Theme.paddingMedium):0);
        enabled: true;
        visible: screenShotModel.count>0;
        SilicaFlickable{
            id:screenshots;
            anchors.left: parent.left;
            anchors.right: parent.right;
            height: parent.height;
            flickableDirection: Flickable.HorizontalFlick;
            contentWidth: (window.width/3-Theme.paddingSmall)*screenshotview.count;
            Row{
                anchors.left: parent.left;
                anchors.top: parent.top;
                anchors.margins: Theme.paddingSmall;
                spacing: Theme.paddingSmall;
                Repeater{
                    id:screenshotview;
                    model: screenShotModel;
                    delegate: ScreenshotBox{}
                }
            }
        }
        anchors {
            top:screenshotslt.bottom
            topMargin: Theme.paddingMedium
            left:parent.left
            right:parent.right
        }


    }


    DetailLabelText{
        id:sumlabeltext
        width:parent.width;
        label: qsTr("Summary")
        anchors{
            top:screenShotLabel.bottom
            topMargin: Theme.paddingMedium
        }
    }
    TextCollapsible {
       id:summaryid
       anchors {
           top:sumlabeltext.bottom
           topMargin: Theme.paddingLarge
           left: parent.left
           right: parent.right
       }

       font.pixelSize: Theme.fontSizeSmall
       wrapMode: Text.WordWrap

       text: summary !== undefined ? summary : ""
   }


    DetailLabelText{
        id:otherslt
        width:parent.width;
        label: qsTr("OthersInfo")
        anchors{
            top:summaryid.bottom
            topMargin: Theme.paddingMedium
        }
    }

    BackgroundItem{
        id:oteherAppsItem
        enabled: specifiedAuthorModel.count > 0
        opacity: enabled?1:0.7
        height: Theme.itemSizeSmall +Theme.paddingMedium
        anchors{
            top:otherslt.bottom
            left:parent.left
            right:parent.right
            topMargin: Theme.paddingMedium
        }

        Label{
            id:otherApps
            text:developer+qsTr("'s other apps")+" ("+specifiedAuthorModel.count+")"
            font.pixelSize: Theme.fontSizeMedium
            truncationMode: TruncationMode.Fade
            anchors{
                left: parent.left
                verticalCenter:parent.verticalCenter
            }

        }
        IconButton {
            id:iconid
            icon.source: "image://theme/icon-m-right"
            anchors{
                right: parent.right
                verticalCenter:parent.verticalCenter
            }
        }
        onClicked: {
            pageStack.push(otherAppsPage)
        }


    }

//    DetailLabelText{
//        width:parent.width;
//        label: qsTr("Comments")
//    }

    BackgroundItem{
        height: Theme.itemSizeSmall +Theme.paddingMedium
        id:commentsItem
        enabled: commentsModel.count > 0
        opacity: enabled?1:0.7
        anchors{
            top:oteherAppsItem.bottom
            left:parent.left
            right:parent.right
            topMargin: Theme.paddingMedium
        }
        Label{
            id:rate
            text:qsTr("Comments")+"("+commentsModel.count+")"
            font.pixelSize: Theme.fontSizeMedium
            truncationMode: TruncationMode.Fade
            anchors{
                left:parent.left
                verticalCenter:parent.verticalCenter
            }

        }
        RatingBox {
            score:score_num?(score_num == 0?0:(scores/score_num)):0
            optional:false
            //width:parent.width
            anchors {
                left: rate.right
                leftMargin: Theme.paddingMedium
                verticalCenter:parent.verticalCenter
            }
        }
        IconButton {
            icon.source: "image://theme/icon-m-right"
            anchors{
                right: parent.right
                verticalCenter:parent.verticalCenter
            }
        }
        onClicked: {
            pageStack.push(commentsPage)
        }


    }


//    DetailLabelText{
//        width:parent.width;
//        label: qsTr("Related")
//    }

    BackgroundItem{
        id:relatedItem
        enabled: relatedModel.count > 0
        opacity: enabled?1:0.7
        height: Theme.itemSizeSmall +Theme.paddingMedium
        contentHeight: height
        anchors{
            top:commentsItem.bottom
            left:parent.left
            right:parent.right
            //topMargin: Theme.paddingLarge
        }
        Label{
            text:qsTr("Related Apps (")+relatedModel.count+")"
            font.pixelSize: Theme.fontSizeMedium
            truncationMode: TruncationMode.Fade
            anchors{
                left:parent.left
                verticalCenter:parent.verticalCenter
            }

        }
        IconButton {
            icon.source: "image://theme/icon-m-right"
            anchors{
                right: parent.right
                verticalCenter:parent.verticalCenter
            }
        }
        onClicked: {
            pageStack.push(relatedPage)
        }


    }


    SubmitCommentComponent{
        id:rateItem
        anchors {
            left: parent.left
            top:relatedItem.bottom
            topMargin: Theme.paddingMedium
        }
    }

}
