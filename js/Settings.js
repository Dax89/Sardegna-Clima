.pragma library
.import QtQuick.LocalStorage 2.0 as Storage

var loaded = false;

function instance()
{
    return openDatabase("1.0")
}

function openDatabase(version)
{
    return Storage.LocalStorage.openDatabaseSync("SardegnaClima", version, "Sardegna Clima Settings", 1000000);  /* DB Size: 1MB */
}

function load(fn)
{
    if(loaded)
        return;

    loaded = true;

    instance().transaction(function(tx) {
         tx.executeSql("CREATE TABLE IF NOT EXISTS Settings(name TEXT PRIMARY KEY, value TEXT)");

         if(!fn)
             return;

         fn(tx);
     });
}

function set(setting, value)
{
    load();
    var db = instance();

    db.transaction(function(tx) {
        transactionSet(tx, setting, value);
    });
}

function get(setting)
{
    load();

    var db = instance();
    var res = false;

    db.readTransaction(function(tx) {
        res = transactionGet(tx, setting);
    });

    return res;
}

function transactionSet(tx, setting, value)
{
    tx.executeSql("INSERT OR REPLACE INTO Settings (name, value) VALUES (?, ?);", [setting, value]);
}

function transactionGet(tx, setting)
{
    var r = tx.executeSql("SELECT value FROM Settings WHERE name = ?", [setting]);

    if(r.rows.length > 0)
        return r.rows.item(0).value;

    return false;
}

function transaction(txfunc)
{
    instance().transaction(txfunc);
}
