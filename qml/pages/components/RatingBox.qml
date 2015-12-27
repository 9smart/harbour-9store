import QtQuick 2.0
import Sailfish.Silica 1.0
Item {
    id: scorebox
    property real score_n: 5
    property bool optional:  false;
    Loader {
        id: loader
        //sourceComponent: score > 0 ? stars : unrated
        sourceComponent:stars
    }
    Component {
        id: stars
        Row {
            spacing: 4
            Repeater {
                model: 5
                delegate: Image {
                    height: scorebox.height
                    width: scorebox.width/6
                    //source: ((score_n-1) >= index)?"../../img/Score_1.svg":"../../img/Score_3.svg"
                    source: {
                        if((score_n-index)>=1)
                            return "../../img/Score_1.png";
                        else if((score_n-index)>0&&(score_n-index)<1)
                            return "../../img/Score_2.png";
                        else return "../../img/Score_3.png"
                    }
//                    MouseArea{
//                        anchors.fill: parent;
//                        enabled: optional;
//                        onClicked: {
//                            score_n=index+1;
//                        }
//                    }
                }
            }
        }

    }
}
