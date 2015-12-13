import QtQuick 2.0
import Sailfish.Silica 1.0
Item{
        id:relatedComponet
        anchors.fill: parent
        SectionHeader {
            id:relatedtip
            text:qsTr("Related")
            height: Theme.itemSizeMedium
            anchors {
                left:parent.left
            }
            Separator {
                width:parent.width;
                color: Theme.highlightColor
            }
        }
        SilicaGridView {
            id: gridView
            height: childrenRect.height
            model: moreAppsModel
            anchors.fill: parent
            cellWidth: gridView.width / 3
            cellHeight: cellWidth
            delegate: BackgroundItem {
                id: rectangle
                width: gridView.cellWidth
                height: gridView.cellHeight
                Label{
                    id: moreappnameid
                    x: morepic.width/2
                    text:moreappname
                    font.pixelSize: Theme.fontSizeExtraSmall
                    wrapMode: Text.WordWrap
                    maximumLineCount: 1
                }
                Label{
                    id: label
                    x: morepic.width/2
                    y:moreappnameid.height
                    text:"<font size='2' > "+qsTr("views")+":</font><font size='1' >"+moreviews+"</font>"
                    color: Theme.highlightColor
                    font.pixelSize: Theme.fontSizeExtraSmall
                    horizontalAlignment: Text.AlignRight
                }
                Label{
                    id:moreimgid
                    CacheImage{
                        id:morepic
                        x:implicitWidth/2
                        y:label.height+moreappnameid.height
                        fillMode: Image.Stretch;
                        width:  implicitWidth
                        height: implicitHeight
                        cacheurl: moreicon
                        asynchronous: true
                    }
                }
                onClicked :{
                    pageStack.replace(Qt.resolvedUrl("AppDetail.qml"),{
                                          "appid":moreappid,
                                          "author":author
                                      })
                }

            }

            VerticalScrollDecorator {}

        }
    }
