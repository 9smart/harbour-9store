.import QtQuick.LocalStorage 2.0 as SQL//数据库连接模块

function getDatabase() {
    return SQL.LocalStorage.openDatabaseSync("9store", "1.0", "9smart app shop", 10000);

}

// 程序打开时，初始化表
function initialize() {
    var db = getDatabase();
    db.transaction(
                function(tx) {
                    // 如果setting表不存在，则创建一个
                    // 如果表存在，则跳过此步
                    tx.executeSql('CREATE TABLE IF NOT EXISTS LoginData(token TEXT);');
                });
}

var val="";
function getUserData(){
    var db = getDatabase();
    db.transaction(function(tx) {
        var rs = tx.executeSql('select * from LoginData;');
        //console.log(rs.rowsAffected)
        if (rs.rows.length > 0) {
            val = rs.rows.item(0).token;
        } else {

        }
    });

    return val;
}

function setUserData(token){
    var db = getDatabase();
    db.transaction(function(tx) {
        var rs = tx.executeSql('INSERT OR REPLACE INTO LoginData(token) VALUES (?);', [token]);
        console.log(rs.rowsAffected)
        if (rs.rowsAffected > 0) {
            console.log("Saved!");
        } else {
            console.log("Failed!");
        }
    }
    );
}

function clearValue(){
    var db = getDatabase();
    db.transaction(function(tx) {
        var rs = tx.executeSql('delete from LoginData;');
        console.log(rs.rowsAffected)
        if (rs.rowsAffected > 0) {
            console.log("Deleted!");
        } else {
            console.log("Failed!");
        }
    }
    );
}
