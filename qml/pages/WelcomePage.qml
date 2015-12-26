import QtQuick 2.0
import Sailfish.Silica 1.0
import "./components"
import "../js/main.js" as Script

Page{
    id:welcome
    property alias covermodel: coverModel;
    property alias featuredModel: featuredmodel;
    property alias listmodel: listmodel;
   ListModel{
       id:coverModel;
   }
   ListModel{
       id:featuredmodel;
   }
   ListModel{
       id:listmodel;
   }

//   onStatusChanged: {
//           if (status == PageStatus.Active) {
//               if (pageStack._currentContainer.attachedContainer == null) {
//                   pageStack.pushAttached(Qt.resolvedUrl("NotificationPage.qml"))
//               }
//           }
//       }

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
                text: qsTr("Notifications")
                onClicked: pageStack.push(Qt.resolvedUrl("NotificationPage.qml"))
            }
            MenuItem {
                text: qsTr("Setting")
                onClicked: pageStack.push(Qt.resolvedUrl("SettingPage.qml"))
            }
            MenuItem {
                text: qsTr("Search")
                onClicked: pageStack.push(Qt.resolvedUrl("AppList.qml"),
                                          {
                                              "showsearch":true,
                                              "category":"",
                                              "developer":""
                                          })
            }
        }

        PageHeader{
            id:header
            title:qsTr("Welcome,")+user.nickName
        }
        anchors.fill: parent
        contentHeight: content.height + header.height + Theme.paddingLarge
        Item{
            id: content
            width: parent.width
            height: posterItem.height+ newappItem.height + category.height
            anchors.top: header.bottom
            //banner
            ActivitiesComponent{
                id:posterItem
                anchors.top:parent.top
                width: Screen.width
                height: Screen.height/3.5
            }
            Item{
                id:newappItem
                anchors.top:posterItem.bottom
                //height: childrenRect.height
                //contentHeight:childrenRect.height
                height: newgrid.height + Theme.itemSizeMedium + Theme.paddingMedium
                width: parent.width
                MoreButton{
                    id:newapps
                    width:parent.width
                    anchors.top: parent.top
                    height: Theme.itemSizeMedium
                    text: qsTr("NewApps")
                    onClicked: {
                        if(loading){
                            return;
                        }
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
                id:category
                anchors.top:newappItem.bottom
                height: allclass.height + gameclass.height+ appclass.height
                width: parent.width
                MoreButton{
                    id:allclass
                    width:parent.width
                    anchors.top: parent.top
                    height: Theme.itemSizeMedium
                    text: qsTr("All Category")
                    onClicked: {
                        if(loading){
                            return;
                        }
                        pageStack.push(Qt.resolvedUrl("AppCategory.qml"));
                    }
                    WelcomeBoxBackground {
                        anchors.fill: parent
                        z: -1
                    }
                }
                MoreButton{
                    id:gameclass
                    width:parent.width
                    anchors.top: allclass.bottom
                    height: Theme.itemSizeMedium
                    text: qsTr("Games")
                    onClicked: {
                        if(loading){
                            return;
                        }

                        pageStack.push(Qt.resolvedUrl("AppCategory.qml"),{"type":"game"});
                    }
                }
                MoreButton{
                    id:appclass
                    width:parent.width
                    anchors.top: gameclass.bottom
                    height: Theme.itemSizeMedium
                    text: qsTr("Apps")
                    onClicked: {
                        if(loading){
                            return;
                        }
                        pageStack.push(Qt.resolvedUrl("AppCategory.qml"),{"type":"app"});
                    }

                }

            }


        }
     VerticalScrollDecorator {flickable: flick}

    }

    Component.onCompleted: {
        Script.mainPage = welcome;
        Script.getfeatured(sysinfo.osType);
        Script.getcover(sysinfo.osType);
    }
}
