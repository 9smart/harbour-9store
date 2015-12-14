import QtQuick 2.0
import Sailfish.Silica 1.0
import "./components"
import "../js/main.js" as Script

Page{
    id:welcome
    property alias coverModel: covermodel;
    property alias featuredModel: featuredmodel;
    property alias listmodel: listmodel;


   ListModel{
       id:covermodel;
   }
   ListModel{
       id:featuredmodel;
   }
   ListModel{
       id:listmodel;
   }


    SilicaFlickable{
        id:flick
        enabled: PageStatus.Active
        opacity:PageStatus.Active?1:0
        PullDownMenu {
            id:pulldownid
            MenuItem {
                text: qsTr("About")
                onClicked: pageStack.push(Qt.resolvedUrl("AboutPage.qml"))
            }
            MenuItem {
                text: qsTr("My Apps")
                onClicked: pageStack.push(Qt.resolvedUrl("DownloadPage.qml"))
            }
            MenuItem {
                text: qsTr("Setting")
                onClicked: pageStack.push(Qt.resolvedUrl("SettingPage.qml"))
            }
        }

        PageHeader{
            id:header
            title:qsTr("Welcome,")+user.nickName
        }
        anchors.fill: parent
        contentHeight: content.height + header.height+ category.height + Theme.paddingLarge
        Item{
            id: content
            width: parent.width
            height: newappItem.height
            Component.onCompleted: {
                conBusy.running=false
                content.visible = true;
            }
            BusyIndicator {
                id: conBusy
                anchors.centerIn: parent
                running: true
                size: BusyIndicatorSize.Medium
            }
            visible: false
            anchors.top: header.bottom
//            Item{
//                id:hotappBak
//                Component.onCompleted: {
//                    habusy.running = false
//                }
//                BusyIndicator {
//                    id: habusy
//                    anchors.centerIn: parent
//                    running:true
//                    size: BusyIndicatorSize.Small
//                }
//                visible: !habusy.running
//                anchors.top:parent.top
//                height: hotgrid.height + Theme.itemSizeMedium + Theme.paddingMedium
//                width: parent.width
//                MoreButton{
//                    id:feedButton
//                    width:parent.width
//                    visible: !habusy.running
//                    anchors.top: parent.top
//                    height: Theme.itemSizeMedium
//                    text: qsTr("Recommendation")
//                    onClicked: {
//                        pageStack.push(Qt.resolvedUrl("HotList.qml"),
//                                       {"query_type":"views"
//                                       });
//                    }
//                    WelcomeBoxBackground {
//                        anchors.fill: parent
//                        z: -1
//                    }
//                }

//                Grid{
//                    id:hotgrid
//                    width:parent.width
//                    anchors{
//                        top:feedButton.bottom
//                        left:parent.left
//                        right:parent.right
//                    }

//                    columns: 3
//                    Repeater {
//                        model:
//                        AppBackgroundItem {
//                        }
//                    }
//                }


//            }

            Item{
                Component.onCompleted: {
                    nibusy.running = false
                }
                BusyIndicator {
                    id: nibusy
                    anchors.centerIn: parent
                    running: true
                    size: BusyIndicatorSize.Small
                }
                id:newappItem
                visible: !nibusy.running
                anchors.top:parent.top
                //height: childrenRect.height
                //contentHeight:childrenRect.height
                height: newgrid.height + Theme.itemSizeMedium + Theme.paddingMedium
                width: parent.width
                MoreButton{
                    id:newapps
                    visible: !nibusy.running
                    width:parent.width
                    anchors.top: parent.top
                    height: Theme.itemSizeMedium
                    text: qsTr("NewApps")
                    onClicked: {
                        pageStack.push(Qt.resolvedUrl("AppList.qml"),
                                       {"query_type":""
                                       });
                    }
                    WelcomeBoxBackground {
                        anchors.fill: parent
                        z: -1
                    }
                }
                Grid{
                    id:newgrid
                    width:parent.width
                    anchors{
                        top:newapps.bottom
                        left:parent.left
                        right:parent.right
                    }

                    columns: 3
                    Repeater {
                        model: featuredmodel
                        AppBackgroundItem {
                        }
                    }
                }

            }

            Item{
                Component.onCompleted: {
                    apclassbi.running = false
                    category.visible = true
                }
                BusyIndicator {
                    id: apclassbi
                    anchors.centerIn: parent
                    running: true
                    size: BusyIndicatorSize.Small
                }
                id:category
                visible: !apclassbi.running
                anchors.top:newappItem.bottom
                height: allclass.height + gameclass.height+ appclass.height
                width: parent.width
                MoreButton{
                    id:allclass
                    visible: !apclassbi.running
                    width:parent.width
                    anchors.top: parent.top
                    height: Theme.itemSizeMedium
                    text: qsTr("All Class")
                    onClicked: {
                        pageStack.push(Qt.resolvedUrl("AppClass.qml"));
                    }
                    WelcomeBoxBackground {
                        anchors.fill: parent
                        z: -1
                    }
                }
                MoreButton{
                    id:gameclass
                    width:parent.width
                    visible: !apclassbi.running
                    anchors.top: allclass.bottom
                    height: Theme.itemSizeMedium
                    text: qsTr("Game Class")
                    onClicked: {
                        pageStack.push(Qt.resolvedUrl("AppClass.qml"),{"classtype":"game"});
                    }
                }
                MoreButton{
                    id:appclass
                    visible: !apclassbi.running
                    width:parent.width
                    anchors.top: gameclass.bottom
                    height: Theme.itemSizeMedium
                    text: qsTr("Apps Class")
                    onClicked: {
                        pageStack.push(Qt.resolvedUrl("AppClass.qml"),{"classtype":"app"});
                    }

                }

            }


        }
     VerticalScrollDecorator {flickable: flick}

    }

//    BusyIndicator {
//        id: busyIndicator
//        anchors.centerIn: parent
//        running: !PageStatus.Active
//        size: BusyIndicatorSize.Large
//    }
    Label {
        anchors.centerIn: parent
        width: parent.width
        visible:!PageStatus.Active
        horizontalAlignment: Text.AlignHCenter
        wrapMode: Text.Wrap
        font.pixelSize: Theme.fontSizeExtraLarge
        color: Theme.highlightColor
        text: qsTr("Loading...")
    }

    Component.onCompleted: {
        Script.mainPage = welcome;
        Script.getfeatured(sysinfo.osType);
    }
}
