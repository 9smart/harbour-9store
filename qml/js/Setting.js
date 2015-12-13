.import QtQuick.LocalStorage 2.0 as SQL//数据库连接模块


function getDatabase() {
    return SQL.LocalStorage.openDatabaseSync("9store", "1.0", "settings", 10000);
}


// 程序打开时，初始化表
function initialize() {
    var db = getDatabase();
    db.transaction(
                function(tx) {
                    tx.executeSql('CREATE TABLE IF NOT EXISTS settings(value TEXT);');
                });
}

var val="";
function getUserData() {
    var db = getDatabase();
    db.transaction(function(tx) {
        var rs = tx.executeSql('SELECT value FROM settings;');
        if (rs.rows.length > 0) {
            val= rs.rows.item(0).value;
        }
    });

    return val;
}

//设置有图模式
function setUserData(val) {
    var db = getDatabase();
    db.transaction(function(tx) {
        var rs = tx.executeSql('insert into newcnbeta values (?);', [val]);
        if(rs.rowsAffected > 0 ){
            console.log("rowsAffected");
        }

    });
}

function clearUserData(){
    var db = getDatabase();
    db.transaction(function(tx) {
        var rs = tx.executeSql('delete from settings;');
        if(rs.rowsAffected > 0 ){
        }

    });
}
