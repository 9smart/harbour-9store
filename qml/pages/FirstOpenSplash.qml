import QtQuick 2.0
import Sailfish.Silica 1.0
import "../js/setting.js" as Setting
import "../js/main.js" as Script
import "../js/login.js" as UserData
Rectangle {
    id: root;
    property real image_1_alpha: 0;
    property real text_1_alpha: 0;

    property real image_2_alpha: 0;
    property real text_2_alpha: 0;

    property real image_31_alpha: 0;
    property real text_31_alpha: 0;

    property real image_32_alpha: 0;
    property real text_32_alpha: 0;

    property color background_color: "#70737C";
    //visible: false;
    anchors.fill: parent;
    color: background_color;
    Image{
        id: image_1_1;
        anchors.fill: parent;
        source: "../img/FirstOpen/011.jpg";
        opacity: image_1_alpha;
    }
    Image{
        id: text_1_1;
        anchors.fill: parent;
        source: "../img/FirstOpen/012.png";
        opacity: text_1_alpha;
    }

    Image{
        id: image_2_1;
        anchors.fill: parent;
        source: "../img/FirstOpen/021.jpg";
        opacity: image_2_alpha
    }
    Image{
        id: text_2_1;
        anchors.fill: parent;
        source: "../img/FirstOpen/022.png";
        opacity: text_2_alpha;
    }

    Image{
        id: image_3_1;
        anchors{
            top:parent.top
            left: parent.left;
        }
        width: 624/1080*parent.width
        //fillMode: Image.PreserveAspectFit
        fillMode: Image.TileHorizontally
        verticalAlignment: Image.AlignLeft
        source: "../img/FirstOpen/031.png";
        opacity: image_31_alpha;
    }
    Image{
        id: image_3_2;
        width: 456/1080*parent.width
        anchors{
            top:parent.top
            right: parent.right;
        }
        //fillMode: Image.PreserveAspectFit
        fillMode: Image.TileHorizontally
        verticalAlignment: Image.AlignRight
        source: "../img/FirstOpen/032.jpg";
        opacity: image_32_alpha;
    }
    Image{
        id: text_3_1;
        anchors.fill: parent;
        source: "../img/FirstOpen/033.png";
        opacity: text_31_alpha;
    }
    Image{
        id: text_3_2;
        anchors.fill: parent;
        //source: "../img/FirstOpen/034.png";
        opacity: text_32_alpha;
    }

    //step1
    NumberAnimation on image_1_alpha {
        from: 0;
        to: 0.4;
        duration: 400;
        running: true;
        onRunningChanged: {
            if(running === false){
                console.log("here1");
                step2_image_1_alpha.start();
                step2_text_1_alpha.start();


            }
        }
    }

    //step2
    NumberAnimation on image_1_alpha {
        id: step2_image_1_alpha;
        from: 0.4;
        to: 1;
        duration: 600;
        running: false;
    }
    NumberAnimation on text_1_alpha {
        id: step2_text_1_alpha;
        property int flag: 0;
        from: 0;
        to:1;
        duration: 600;
        running: false;
        onRunningChanged: {
            //console.log(running + " " + flag);
            if(running === false){
                //if(flag === 1){
                    console.log("here2")
                    step3_timer.start();
                //}
                //else flag++;
            }

        }
    }

    //step3
    Timer{
        id: step3_timer;
        interval: 1000;
        onTriggered: {
            step4_image_1_alpha.start();
            step4_text_1_alpha.start();
            step4_back_color.start();
            console.log("here3");
        }
    }

    //step4
    NumberAnimation on image_1_alpha {
        id: step4_image_1_alpha;
        from: 1;
        to: 0;
        duration: 800;
        running: false;
    }
    NumberAnimation on text_1_alpha {
        id: step4_text_1_alpha;
        from: 1;
        to: 0;
        duration: 800;
        running: false;
    }
    ColorAnimation on background_color {
        id: step4_back_color;
        property int flag: 0;
        from: "#70737C";
        to: "#414457";
        duration: 800;
        running: false;
        onRunningChanged: {
            if(running === false){
                //if(flag === 1){
                console.log("here4")
                    image_1_1.visible = false;
                    text_1_1.visible = false;
                    step5_image_2_alpha.start()
                //}
                //else flag++;
            }
        }
    }

    //step5
    NumberAnimation on image_2_alpha {
        id: step5_image_2_alpha;
        property int flag: 0;
        from: 0;
        to: 0.4;
        duration: 400;
        running: false;
        onRunningChanged: {
            if(running === false){
                //if(flag === 1){
                console.log("here5");
                    step6_image_2_alpha.start();
                    step6_text_2_alpha.start()
                //}
                //else flag++;
            }
        }
    }

    //step6
    NumberAnimation on image_2_alpha {
        id: step6_image_2_alpha;
        from: 0.4;
        to: 1;
        duration: 600;
        running: false;
    }
    NumberAnimation on text_2_alpha {
        id: step6_text_2_alpha;
        property int flag: 0;
        from: 0;
        to: 1;
        duration: 600;
        running: false;
        onRunningChanged: {
            if(running === false){
                ///if(flag === 1)
                console.log("here6");
                    step7_timer.start();
                //else flag++;
            }
        }
    }

    //step7
    Timer{
        id: step7_timer;
        interval: 1000;
        onTriggered: {
            console.log("here7");
            step8_image_2_alpha.start();
            step8_text_2_alpha.start();
            step8_back_color.start();
        }
    }

    //step8
    NumberAnimation on image_2_alpha {
        id: step8_image_2_alpha;
        from: 1;
        to: 0;
        duration: 800;
        running: false;
    }
    NumberAnimation on text_2_alpha {
        id: step8_text_2_alpha;
        from: 1;
        to: 0;
        duration: 800;
        running: false;
    }
    ColorAnimation on background_color {
        id: step8_back_color;
        property int flag: 0;
        from: "#414457";
        to: "#FFFFFF";
        duration: 800;
        running: false;
        onRunningChanged: {
            if(running === false){
                //if(flag === 1){
                console.log("here8");
                    image_2_1.visible = false;
                    text_2_1.visible = false;
                    step9_image_31_alpha.start()
                //}
               // else flag++;
            }
        }
    }

    //step9
    NumberAnimation on image_31_alpha {
        id: step9_image_31_alpha;
        property int flag: 0;
        from: 0;
        to: 0.4;
        duration: 400;
        running: false;
        onRunningChanged: {
            if(running === false){
                //if(flag === 1){
                console.log("here9");
                    step10_image_31_alpha.start();
                    step10_text_31_alpha.start()
                //}
                //else flag++;
            }
        }
    }

    //step10
    NumberAnimation on image_31_alpha {
        id: step10_image_31_alpha;
        from: 0.4;
        to: 1;
        duration: 600;
        running: false;
    }
    NumberAnimation on text_31_alpha {
        id: step10_text_31_alpha;
        property int flag: 0;
        from: 0;
        to: 1;
        duration: 600;
        running: false;
        onRunningChanged: {
            if(running === false){
                //if(flag === 1)
                console.log("here10");
                    step11_image_32_alpha.start();
                //else flag++;
            }
        }
    }

    //step11
    NumberAnimation on image_32_alpha {
        id: step11_image_32_alpha;
        property int flag: 0;
        from: 0;
        to: 0.4;
        duration: 400;
        running: false;
        onRunningChanged: {
            if(running === false){
                //if(flag === 1){
                console.log("here11");
                    step12_image_32_alpha.start();
                    step12_text_32_alpha.start()
                //}
                //else flag++;
            }
        }
    }

    //step12
    NumberAnimation on image_32_alpha {
        id: step12_image_32_alpha;
        from: 0.4;
        to: 1;
        duration: 600;
        running: false;

    }
    NumberAnimation on text_32_alpha {
        id: step12_text_32_alpha;
        property int flag: 0;
        from: 0;
        to: 1;
        duration: 600;
        running: false;
        onRunningChanged: {
            if(running === false){
               // if(flag === 1)
                console.log("here12");
                    //step13_root_alpha.start();
                step13_timer.start();
                //else flag++;
            }
        }
    }
    //step13
    Timer{
        id: step13_timer;
        interval: 1000;
        onTriggered: {
            console.log("here13")
            step14_root_alpha.start();
        }
    }

    //step14
    NumberAnimation on opacity {
        id: step14_root_alpha;
        property int flag: 0;
        from: 1;
        to: 0;
        duration: 800;
        running: false;
        onRunningChanged: {
            if(running === false){
                Script.app = window;
                Script.userData = UserData;
                root.visible = false;
                loadLoginData(UserData.getUserData());
                Setting.upLoad()
            }
        }
    }
}
