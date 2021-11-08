import 'package:flutter_router_demo/util/logger.dart';
import 'package:path/path.dart' as flutter_path;
import 'package:sqflite/sqflite.dart';

class DB {
  late Database _database;

  Future<Database> init() async {
    var path = flutter_path.join(await getDatabasesPath(), 'my_db.db');
    Log.i("path: $path");
    final exist = await databaseExists(path);
    Log.i("exist: $exist");
    if (exist) {
      await deleteDatabase(path);
    }
    _database = await openDatabase(
      path,
      version: 1,
      onCreate: (Database db, int version) async {
        Log.i("onCreate: version $version");
        await db.execute('CREATE TABLE Test (id INTEGER PRIMARY KEY, name TEXT, value INTEGER, num REAL)');
      },
      onUpgrade: (Database db, int oldVersion, int newVersion) async {
        Log.i("onUpgrade: newVersion $newVersion");
      },
    );
    return _database;
  }

  void insert() async {
    await _database.transaction((txn) async {
      int id1 = await txn.rawInsert('INSERT INTO Test(name, value, num) VALUES("aaa", 123, 1.23)');
      Log.i("insert: $id1");
      int id2 = await txn.rawInsert('INSERT INTO Test(name, value, num) VALUES(?, ?, ?)', ['bbb', 456, 4.56]);
      Log.i("insert: $id2");
    });
  }

  void query() async {
    List<Map> list = await _database.rawQuery('SELECT * FROM Test');
    Log.i("query: $list");
  }
}
