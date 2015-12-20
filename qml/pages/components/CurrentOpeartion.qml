import QtQuick 2.0
import Sailfish.Silica 1.0
import "../../js/main.js" as Script

Item{
    width: parent.width
    height: downprogress.height + statusName.height +
            + col.height + Theme.paddingMedium *2
    signal currentAppmanaged(string result)
    property bool downbar: false



    function showdownbar(){

    }

    Label{
        id:statusName
        width: parent.width
        color: Theme.primaryColor
        font.pixelSize: Theme.fontSizeSmall
        wrapMode: Text.Wrap
        anchors{
            top:parent.top
            topMargin: Theme.paddingMedium
            horizontalCenter: parent.horizontalCenter
        }
    }



    Column{
        id:col
        anchors{
            top:statusName.bottom
            left:parent.left
            right:parent.right
        }
        spacing: Theme.paddingMedium
        Button{
            id:installButton
            text:qsTr("Install")
            visible: false
            anchors{
                horizontalCenter: parent.horizontalCenter
            }
            onClicked:{
               var rpm = rpmname+"-"+version+"."+sysinfo.cpuModel+".rpm";
               console.log("url:"+downloadurl)
               py.newdownload(downloadurl,rpmname,version);
               downbar = true;
            }

        }

        Button{
            id:upgradeButton
            text:qsTr("Upgrade")
            visible: false
            anchors{
                horizontalCenter: parent.horizontalCenter
            }
            onClicked:{
               var rpm = rpmname+"-"+version+"."+sysinfo.cpuModel+".rpm";
               console.log("url:"+downloadurl)
               py.newdownload(downloadurl,rpmname,version);
            }

        }

        Button{
            id:uninstallButton
            text:qsTr("UnInstall")
            visible: !installButton.visible
            anchors{
                horizontalCenter: parent.horizontalCenter
            }
            onClicked:{
                remorse.execute(qsTr("Start uninstall %1").arg(appname),function(){
                    py.uninstallRpm(rpmname,version);
                },3000);


            }

        }

    }

    ProgressBar {
        id:downprogress
        visible: downbar && value > 99.99
        anchors{
            top: col.bottom
            topMargin: Theme.paddingMedium
            horizontalCenter: parent.horizontalCenter
        }
        value: currper
        minimumValue:0
        maximumValue:100
        width: parent.width - Theme.paddingLarge
    }

    Connections{
        target: signalCenter
        onCurrentAppmanaged:{
            console.log("result:"+result)
            switch(result){
            case ("Install"):
                installButton.visible = true;
                break;
            case("Upgrade"):
                upgradeButton.visible = true;
                break;
            case("Uninstall"):
                uninstallButton.visible = true;
                break;
            default:
                break;
            }
        }
    }


}
