
import QtQuick 2.0
import QtWebKit 3.0
import Sailfish.Silica 1.0
import "../js/login.js" as UserData

Page{
    Item{
    id:user_center_main

    anchors.fill: parent
    opacity:1
    visible: true

    function updataData(){
        if(uid!=""){
            console.log("push to WelcomePage")
            pageStack.push(Qt.resolvedUrl("WelcomePage.qml"));
        }
    }



    Behavior on opacity {
        NumberAnimation{duration: 300}
    }


    SilicaWebView{
        id: webLogin
        //http://www.9smart.cn/user/thirdPartyLogin?state=weibo&code=f3758e1c81327f70622719b536f6f3ef
        opacity: 1
        visible: true
        url:"https://api.weibo.com/oauth2/authorize?response_type=code&client_id=3076228594&redirect_uri=http://www.9smart.cn/user/thirdPartyLogin&state=weibo"
        anchors.fill: parent
        //experimental.userAgent:"Qt; Mozilla/5.0 (Windows NT 6.2; Win64; x64) AppleWebKit/537.36  (KHTML, like Gecko) Chrome/32.0.1667.0 Safari/537.36"

        Behavior on opacity {
            NumberAnimation{duration: 300}
        }

        onUrlChanged: {
            console.log("url:"+url)
            var tmp = "http://www.9smart.cn/user/thirdPartyLogin?state=weibo&code=f3758e1c81327f70622719b536f6f3ef"
            if(url.length == tmp.length){

            }
            if(loadRequest.status == WebView.LoadSucceededStatus){
                Qt.inputMethod.hide()
                console.log("title:"+title)
                var obj=JSON.parse(title)
                if( obj ){
                    console.log("登录成功")
                    signalCenter.showMessage(qsTr("Logined Success"));
                    opacity = 0//登陆成功
                    webLogin.url = "http://www.9smart.cn/member/login"
                    uid=obj.uid;
                    accesstoken=obj.accesstoken;
                    nickname=obj.nickname;
                    avatar=obj.avatar;
                    gender=obj.gender;
                    logintype=obj.logintype;
                    userstate=1;
                    UserData.setValue(title);
                    updataData();

                }
            }
        }
        BusyIndicator {
            anchors.centerIn: parent
            running: webLogin.loading
        }
    }
    }
}
