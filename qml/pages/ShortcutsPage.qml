import QtQuick 2.1
import Sailfish.Silica 1.0
import org.coderus.powermenu.desktopfilemodel 1.0
import org.nemomobile.configuration 1.0
import ".."

Page {
    id: page
    objectName: "shortcutsPage"

    signal selected(string path)
    property bool searchEnabled: false
    property bool showHidden: false
    property variant selectedValues: []

    SilicaFlickable {
        id: view
        anchors.fill: page
        contentHeight: content.height

        PullDownMenu {
            //background: Component { ShaderTiledBackground {} }
            MenuItem {
                text: searchEnabled
                      ? qsTr("Hide search field")
                      : qsTr("Show search field")
                enabled: shortcutsRepeater.count > 0
                onClicked: {
                    searchEnabled = !searchEnabled
                }
            }
        }

        Column {
            id: content
            width: parent.width

            PageHeader {
                id: title
                title: qsTr("Select shortcuts")
            }

            Item {
                id: searchFieldPlaceholder
                width: parent.width

                height: !searchField.enabled ? 0 : searchField.height
                Behavior on height {
                    NumberAnimation {
                        duration: 150
                        easing.type: Easing.InOutQuad
                    }
                }
            }

            SearchField {
                id: searchField
                parent: searchFieldPlaceholder
                width: parent.width
                enabled: page.searchEnabled
                onEnabledChanged: {
                    if (!enabled) {
                        text = ''
                    }
                }
                focus: enabled
                visible: opacity > 0
                opacity: page.searchEnabled ? 1 : 0
                Behavior on opacity {
                    FadeAnimation {
                        duration: 150
                    }
                }
            }


            Repeater {
                id: shortcutsRepeater
                delegate: shortcutDelegate
                model: desktopModel
                width: parent.width
                enabled: false
            }
        }

        VerticalScrollDecorator {}
    }

    BusyIndicator {
        anchors.centerIn: view
        size: BusyIndicatorSize.Large
        visible: !shortcutsRepeater.enabled
        running: visible
    }

    DesktopFileSortModel {
        id: desktopModel
        filter: searchField.text
        showHidden: page.showHidden
        onDataFillEnd: {
            shortcutsRepeater.enabled = true
        }
    }


    Component {
        id: shortcutDelegate
        ListItem {
            id: item
            width: parent.width
            //contentHeight: iconImage.height + Theme.paddingLarge
            //height: contentHeight
            highlighted: down || selectedValues.indexOf(model.path) >= 0
            menu: contextMenuComponent
            function remove(rpmname) {
                remorseAction("正在卸载", function() {
                    listModel.remove(index);
                    py.uninstallRpmNostatus(rpmname)
                })
            }

            ListView.onRemove: animateRemoval()
            Image {
                id: iconImage
                source: model.icon
                width: Screen.height/12
                height: Screen.height/12
                smooth: true
                anchors {
                    left: parent.left
                    leftMargin: Theme.paddingLarge
                    verticalCenter: parent.verticalCenter
                }
            }

            Label {
                text: Theme.highlightText(model.name, searchField.text, Theme.highlightColor)
                anchors {
                    left: iconImage.right
                    leftMargin: Theme.paddingMedium
                    verticalCenter: parent.verticalCenter
                }
                color: item.pressed ? Theme.highlightColor : Theme.primaryColor
            }
            Item{
                width: parent.width
                height: Theme.itemSizeSmall
            }

//            onClicked: {
//                //console.log(model.path)
//                console.log(getAppversion(model.rpmname))
//                if (shortcutsRepeater.enabled) {
//                    selected(model.path)
//                    pageStack.pop()
//                }
//            }


            Component {
                id: contextMenuComponent
                ContextMenu {
                    id:contextMenu
                    MenuItem {
                        text: qsTr("Uninstall")
                        onClicked: remove(model.rpmname)
                    }
                }
            }
        }
    }


}
