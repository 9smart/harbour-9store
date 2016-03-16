import QtQuick 2.0
import Sailfish.Silica 1.0
import "../../js/main.js" as Script

Item{

    width: parent.width
    height: col.height + Theme.paddingMedium
    signal currentAppmanaged(string result)
    signal appisopened(string result)
    property bool downbar: false

    Component.onDestruction: {
        statusName.text = "";
    }

    Column{
        id:col
        width: parent.width
        spacing: Theme.paddingMedium
        Label{
            id:statusName
            width: parent.width
            color: Theme.primaryColor
            font.pixelSize: Theme.fontSizeSmall
            wrapMode: Text.WordWrap
            text:currname
            anchors{
                horizontalCenter: parent.horizontalCenter
            }
        }
        Button{
            id:openButton
            text:qsTr("Open")
            //visible: uninstallButton.visible && !installButton.visible
            visible: false
            anchors{
                horizontalCenter: parent.horizontalCenter
            }
            onClicked:{
                openButton.text = qsTr("Opening")
                py.openapp(rpmname);
                openButton.text = qsTr("Opened")
                openButton.enabled = false;
            }

        }
        Button{
            id:installButton
            text:qsTr("Install")
            visible: !downprogress.visible
            anchors{
                horizontalCenter: parent.horizontalCenter
            }
            onClicked:{
                installButton.text = qsTr("Installing")
                installButton.enabled = false
                var rpm = rpmname+"-"+version+"."+sysinfo.cpuModel+".rpm";
                getDownloadUrl()
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
                console.log("parent.width:"+parent.width)
                upgradeButton.text = qsTr("Upgrading")
                upgradeButton.enabled = false
                getDownloadUrl()
            }

        }

        Button{
            id:uninstallButton
            text:qsTr("Uninstall")
            visible: false//!installButton.visible
            enabled: false
            anchors{
                horizontalCenter: parent.horizontalCenter
            }
            onClicked:{
                return;
                remorse.execute(qsTr("Start uninstall %1").arg(appname),function(){
                    uninstallButton.text = qsTr("Uninstalling")
                    uninstallButton.enabled = false
                    //openButton.enabled = false;
                    py.uninstallRpm(rpmname,version);
                },3000);
            }

        }
    ProgressBar {
        id:downprogress
        visible: currper > 0 && currper < 100
        width: parent.width
        anchors{
            horizontalCenter: parent.horizontalCenter
        }
        value: currper
        minimumValue:0
        maximumValue:100
    }
  }

    Connections{
        target: signalCenter
        onCurrentAppmanaged:{
            //installButton.visible = false
            upgradeButton.visible = false
            //uninstallButton.visible =  false
            console.log("result:"+result)
            switch(result){
            case ("Install"):
                installButton.text = qsTr("Install")
                installButton.visible = true;
                installButton.enabled = true;
                break;
            case("Upgrade"):
                upgradeButton.text = qsTr("Upgrade")
                upgradeButton.visible = true;
                upgradeButton.enabled = true;
                //openButton.visible = true;
                //openButton.enabled = true;
                installButton.visible = false;
                break;
            case("Uninstall"):
                uninstallButton.text = qsTr("Uninstall")
                uninstallButton.visible = true;
                uninstallButton.enabled = false;
                //openButton.visible = true;
                //openButton.enabled = true;
                installButton.visible = false;
                break;
            default:
                installButton.visible = true;
                break;
            }
        }

        onAppisopened:{
            console.log("result:"+result)
            if(result.toString() == "yes"){
                //openButton.text = qsTr("Opened")
                //openButton.enabled = false;
            }else{
                ////openButton.visible = true;
            }
        }
    }



}
