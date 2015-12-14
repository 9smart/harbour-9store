import QtQuick 2.0
import Sailfish.Silica 1.0

SilicaListView {
    id:view
    visible: view.model.count>0
    anchors.bottomMargin: Theme.paddingMedium
    PushUpMenu{
        visible: view.model.count> 8
        MenuItem{
            text:qsTr("scrollToTop")
            onClicked: view.scrollToTop()
        }
    }
    model : appListModel
    clip: true
    //spacing:Theme.paddingMedium
    delegate:AppListComponent{}

    VerticalScrollDecorator {}
    footer: Component{

        Item {
            id: footerComponent
            anchors { left: parent.left; right: parent.right }
            height: visible ? Theme.itemSizeMedium : 0
            visible:(appListModel.count<listsum)
            signal clicked()

            Item {
                id:footItem
                width: parent.width
                height: Theme.itemSizeMedium
                Button {
                    anchors.centerIn: parent
                    text: qsTr("Load More...")
                    onClicked: {
                        pagenum = pagenum+1
                        JS.loadAppList(pagenum,apptype,category);
                    }
                }
            }
        }

    }

    ViewPlaceholder{
        enabled: view.count == 0
        text: qsTr("No more apps")

    }
}
