import QtQuick 2.0
import Sailfish.Silica 1.0
Item{
    height: infomess.height+summaryid.height+screenShotLabel.height+
            oteherAppsItem.height+commentsItem.height+
            rateItem.height+relatedItem.height+Theme.paddingLarge *2
            +downprogress.height
            //relatedApps.height+sectID.height
    CacheImage{
        id:appicon
        asynchronous: true
        cacheurl:icon
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
        text:"<font size='2' > "+qsTr("downloads")+":</font><font size='1' >"+downloads+"</font><br/>"+
             "<font size='2' > "+qsTr("views")+":</font><font size='1' >"+views+"</font><br/>"
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
        text:type+"->"+category+"<br/>"+
             "<font size='2' > "+qsTr("author")+":</font><font size='1' >"+author+"</font><br/>"+
             "<font size='2' > "+qsTr("version")+":</font><font size='1' >"+version+"</font><br/>"+
             "<font size='2' > "+qsTr("filesize")+":</font><font size='1' >"+Format.formatFileSize(size)+"</font><br/>"+
             "<font size='2' > "+qsTr("dateline")+":</font><font size='1' >"+dateline+"</font>"
        font.pixelSize: Theme.fontSizeExtraSmall*5/4
        horizontalAlignment: Text.AlignLeft
        anchors {
            top:appicon.top
            left:appicon.right
            //topMargin: Theme.paddingSmall
            leftMargin: Theme.paddingLarge*2
        }


    }
    Separator {
        width:parent.width;
        visible: downprogress.visible
        color: Theme.highlightColor
        anchors.top:infomess.bottom
    }

    CurrentOpeartion{
        id:downprogress
        anchors{
            left:parent.left
            right:parent.right
            top:infomess.bottom
        }
    }


    Separator {
        width:parent.width;
        color: Theme.highlightColor
        anchors.top:downprogress.bottom
    }
    Label{
        id:summaryid
        width: parent.width

        text:"<font size='1' >"+summary+"</font>"
        font.pixelSize: Theme.fontSizeExtraSmall*4/3
        wrapMode: Text.WordWrap
        //horizontalAlignment: Text.AlignRight
        anchors {
            top:downprogress.bottom
            topMargin: Theme.paddingMedium
            left:parent.left
            leftMargin: Theme.paddingSmall
            rightMargin: Theme.paddingSmall
        }



    }

    Separator {
        visible: (screenShotModel.count>0?true:false)
        width:parent.width;
        color: Theme.highlightColor;
        anchors.top:screenShotLabel.top
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
            top:summaryid.bottom
            //topMargin: Theme.paddingLarge
            left:parent.left
            right:parent.right
        }


    }
    Separator {
        visible: (moreAppsModel.count>0?true:false)
        width:parent.width;
        color: Theme.highlightColor;
        anchors.top:oteherAppsItem.top
    }
    BackgroundItem{
        visible: (moreAppsModel.count>0?true:false)
        height: (moreAppsModel.count>0?Theme.itemSizeSmall:0);
        id:oteherAppsItem
        anchors{
            top:screenShotLabel.bottom
            left:parent.left
            right:parent.right
            topMargin: Theme.paddingMedium
        }

        Label{
            id:otherApps
            text:author+" ("+moreAppsModel.count+")"
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
    Separator {
        width:parent.width;
        visible:(commentsModel.count>0)
        anchors.top: commentsItem.top
        color: Theme.highlightColor
    }
    BackgroundItem{
        visible: (commentsModel.count>0)
        height: (commentsModel.count>0?Theme.itemSizeSmall:0);
        id:commentsItem
        anchors{
            top:oteherAppsItem.bottom
            left:parent.left
            right:parent.right
            //topMargin: Theme.paddingLarge
        }
        Label{
            id:rate
            text:qsTr("Comments (")+commentsModel.count+")"
            font.pixelSize: Theme.fontSizeMedium
            truncationMode: TruncationMode.Fade
            anchors{
                left:parent.left
                verticalCenter:parent.verticalCenter
            }

        }
        RatingBox {
            score:(scores/ratingnum)
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

    Separator {
        visible: relatedModel.count>0
        width:parent.width;
        anchors.top: relatedItem.top
        color: Theme.highlightColor
    }
    BackgroundItem{
        visible: relatedModel.count>0
        id:relatedItem
        height: relatedModel.count>0 ?Theme.itemSizeSmall:0
        anchors{
            top:commentsItem.bottom
            left:parent.left
            right:parent.right
            //topMargin: Theme.paddingLarge
        }
        Label{
            text:qsTr("Related Apps (")+related_sum+")"
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
    Separator {
        width:parent.width;
        anchors.top: rateItem.top
        color: Theme.highlightColor
    }

    SubmitCommentComponet{
        id:rateItem
        enabled: userstate === 1
        opacity:userstate === 1?1:0.5
        anchors {
            left: parent.left
            top:relatedItem.bottom
            //topMargin: Theme.paddingMedium
        }
    }

}
