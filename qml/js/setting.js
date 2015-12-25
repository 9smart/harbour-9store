.import QtQuick.LocalStorage 2.0 as SQL//数据库连接模块

function getDatabase() {
    return SQL.LocalStorage.openDatabaseSync("9store", "1.0", "9smart app shop", 10000);
}

function initialize() {
    var db = getDatabase();
    db.transaction(
                function(tx) {
                    tx.executeSql('CREATE TABLE IF NOT EXISTS NotificationData(id VARCHAR(60) PRIMARY KEY, json text,status INTEGER DEFAULT 0);');
                });
    db.transaction(
                function(tx) {
                    tx.executeSql('CREATE TABLE IF NOT EXISTS Christmas(id integer PRIMARY KEY);');
                });
}

var notifyModel;
function getNotifyData(status) {
    var db = getDatabase();
    notifyModel.clear()
    db.transaction(function(tx) {
        var rs = tx.executeSql('SELECT * FROM NotificationData where status = ?;',[status]);
        for(var i =0;i<rs.rows.length;i++){
          notifyModel.append(JSON.parse(rs.rows.item(i).json))
        }
    });

    return notifyModel;
}

function clearNotifyData(id){
    console.log("id:"+id)
    var db = getDatabase();
    db.transaction(function(tx) {
        var rs = tx.executeSql('update NotificationData set status = 1 where id = ? ;',[id]);
    });
}

//判断首次启动

var flag=true;
function firstLoad(){
    var db = getDatabase();
    db.transaction(function(tx) {
        var rs = tx.executeSql('SELECT * from Christmas;');
        if(rs.rows.length > 0){
            flag = false;
        }else{
            flag = true;
        }
    });
   return flag;
}

function upLoad(){
    var db = getDatabase();
    db.transaction(function(tx) {
        var rs = tx.executeSql('insert into Christmas values(1);');
    });
}

function reopenLoad(){
    var db = getDatabase();
    db.transaction(function(tx) {
        var rs = tx.executeSql('delete from Christmas;');
    });
}
