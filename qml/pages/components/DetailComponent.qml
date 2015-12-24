import QtQuick 2.0
import Sailfish.Silica 1.0
import "../../js/main.js" as Script

Item{
    height: infomess.height +infocate.height +summaryid.height+screenShotLabel.height+
            oteherAppsItem.height+commentsItem.height
            +relatedItem.height+Theme.paddingLarge *2
            +downprogress.height

    Label{
        id:infocate
        text:(type == "app"?qsTr("app"):qsTr("game"))+
                    "->"+category
        font.pixelSize: Theme.fontSizeSmall
        horizontalAlignment: Text.AlignLeft
        anchors {
            top:parent.top
            left:parent.left
            topMargin: Theme.paddingMedium
            leftMargin: Theme.paddingSmall
        }
    }

    Label{
        id:infomess
        text:
             "<font size='2' color='"+Theme.highlightColor+"'> "+qsTr("version")+":</font><font size='1' >"+version+"</font><br/>"+
             "<font size='2' color='"+Theme.highlightColor+"'> "+qsTr("filesize")+":</font><font size='1' >"+(sysinfo.cpuModel == "arm"?size:x86size)+"</font><br/>"
        font.pixelSize: Theme.fontSizeSmall
        horizontalAlignment: Text.AlignLeft
        anchors {
            top:infocate.bottom
            left:parent.left
            topMargin: Theme.paddingMedium
            leftMargin: Theme.paddingSmall
        }
    }

    Label{
        id:extinfomess
        text:
             "<font size='2' color='"+Theme.highlightColor+"'> "+qsTr("downloads")+":</font><font size='1' >"+downloads+"</font><br/>"+
             "<font size='2' color='"+Theme.highlightColor+"'> "+qsTr("dateline")+":</font><font size='1' >"+Script.humanedate(dateline)+"</font>"
        font.pixelSize: Theme.fontSizeSmall
        horizontalAlignment: Text.AlignLeft
        anchors {
            top: infomess.top
            right:parent.right
            rightMargin: Theme.paddingSmall
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
        label: qsTr("Other Info")
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
        width: parent.width
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
            if(loading){
                return;
            }
            pageStack.push(otherAppsPage)
        }


    }

//    DetailLabelText{
//        width:parent.width;
//        label: qsTr("Comments")
//    }

    BackgroundItem{
        height: Theme.itemSizeSmall +Theme.paddingMedium
        width: parent.width
        id:commentsItem
        //enabled: commentsModel.count > 0
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
            if(loading){
                return;
            }
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
        width: parent.width
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
            if(loading){
                return;
            }
            pageStack.push(relatedPage)
        }


    }


//    Column {
//        id:rateItem
//        anchors {
//            left: parent.left
//            top:relatedItem.bottom
//            topMargin: Theme.paddingMedium
//        }
//        width: parent.width
//        spacing: Theme.paddingSmall
//        Button {
//            id: wizard

//            property string selection

//            anchors.horizontalCenter: parent.horizontalCenter
//            text: qsTr("Add comment&Rate")
//            onClicked:{
//                if(loading){
//                    return;
//                }

//            }
//        }

//        Label {
//            anchors.horizontalCenter: parent.horizontalCenter
//            text: wizard.selection
//            color: Theme.highlightColor
//        }
//    }

}
