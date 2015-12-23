import QtQuick 2.0
import Sailfish.Silica 1.0
import "../../js/main.js" as Script

Item{
    width: parent.width
    height: downprogress.height + statusName.height +
            + col.height + Theme.paddingMedium
    signal currentAppmanaged(string result)
    property bool downbar: false


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
               installButton.text = qsTr("Installing")
               var rpm = rpmname+"-"+version+"."+sysinfo.cpuModel+".rpm";
               console.log("url:"+downloadurl)
               downbar = true;
               py.newdownload(downloadurl,rpmname,version);
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
              upgradeButton.text = qsTr("Upgrading")
               var rpm = rpmname+"-"+version+"."+sysinfo.cpuModel+".rpm";
               console.log("url:"+downloadurl)
               py.newdownload(downloadurl,rpmname,version);
            }

        }

        Button{
            id:uninstallButton
            text:qsTr("Uninstall")
            visible: !installButton.visible
            anchors{
                horizontalCenter: parent.horizontalCenter
            }
            onClicked:{
                uninstallButton.text = qsTr("Uninstalling")
                remorse.execute(qsTr("Start uninstall %1").arg(appname),function(){
                    py.uninstallRpm(rpmname,version);
                },3000);


            }

        }

    }

    ProgressBar {
        id:downprogress
        visible: downbar
        width: parent.width
        anchors{
            top: col.bottom
            topMargin: Theme.paddingMedium
            leftMargin: Theme.paddingLarge
            rightMargin: Theme.paddingLarge
            horizontalCenter: parent.horizontalCenter
        }
        value: currper
        minimumValue:0
        maximumValue:100
    }

    Connections{
        target: signalCenter
        onCurrentAppmanaged:{
            downbar = false;
            console.log(result)
            installButton.visible = false
            upgradeButton.visible = false
            uninstallButton.visible =  false
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
