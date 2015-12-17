import QtQuick 2.0
import Sailfish.Silica 1.0

SilicaGridView {
    id: gridView
    clip: true
    height: childrenRect.height
    width: childrenRect.width
    currentIndex: -1
    cellWidth: gridView.width / 3
    cellHeight: cellWidth
    cacheBuffer: 2000;
    delegate: AppBackgroundItem {}

    //VerticalScrollDecorator {}

}

