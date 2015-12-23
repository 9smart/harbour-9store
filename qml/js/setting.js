.import QtQuick.LocalStorage 2.0 as SQL//数据库连接模块

function getDatabase() {
    return SQL.LocalStorage.openDatabaseSync("9store", "1.0", "9smart app shop", 10000);
}



function initialize() {
    var db = getDatabase();
    db.transaction(
                function(tx) {
                    tx.executeSql('CREATE TABLE IF NOT EXISTS NotificationData(id INTEGER PRIMARY KEY AUTOINCREMENT, json text,status INTEGER DEFAULT 0);');
                });
}

var notifyModel;
function getNotifyData(status) {
    var db = getDatabase();
    notifyModel.clear()
    db.transaction(function(tx) {
        var rs = tx.executeSql('SELECT * FROM NotificationData where status = ?;',[status]);
        for(var i =0;i<rs.rows.length;i++){
          notifModel.append(rs.rows.item(i).json)
        }
    });

    return notifModel;
}

function clearNotifyData(id){
    var db = getDatabase();
    db.transaction(function(tx) {
        var rs = tx.executeSql('update NotificationData set status = -1 where id = ? ;',[id]);
    });
}
