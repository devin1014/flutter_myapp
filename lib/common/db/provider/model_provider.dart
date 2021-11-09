import 'package:flutter_router_demo/util/logger.dart';
import 'package:path/path.dart' as path_util;
import 'package:sqflite/sqflite.dart';

abstract class BaseDatabaseProvider<T> {
  static const _table = "table_1";
  static const _id = "_id";
  static const _columnKey = "key";
  static const _columnRequestDate = "requestDate";
  static const _columnExpiredDate = "expiredDate";
  static const _columnData = "data";
  static Database? _database;

  OnDatabaseCreateFn? get onDatabaseCreate => (Database database, int version) async {
        await database.execute("create table $_table "
            "("
            "$_id integer primary key autoincrement, "
            "$_columnKey text not null, "
            "$_columnRequestDate text not null, "
            "$_columnExpiredDate text not null, "
            "$_columnData text not null"
            ")");
      };

  OnDatabaseVersionChangeFn? get onDatabaseVersionUpgrade => null;

  OnDatabaseVersionChangeFn? get onDatabaseVersionDowngrade => null;

  OnDatabaseOpenFn? get onDatabaseOpen => null;

  OnDatabaseConfigureFn? get onDatabaseConfigure => null;

  Future<void> open({String database = "data.db", int version = 1, bool delete = false}) async {
    if (_database != null) return;
    final path = path_util.join(await getDatabasesPath(), database);
    assert(() {
      Log.d("database path: $path");
      return true;
    }());
    if (delete) {
      await deleteDatabase(path);
    }
    _database = await openDatabase(
      path,
      version: version,
      onCreate: onDatabaseCreate,
      onUpgrade: onDatabaseVersionUpgrade,
      onDowngrade: onDatabaseVersionDowngrade,
      onOpen: onDatabaseOpen,
      onConfigure: onDatabaseConfigure,
    );
  }

  Future<bool> insert(String key, T t) {
    if (_database == null) return Future.value(false);
    return _insert(_database!, key, t);
  }

  Future<bool> _insert(Database database, String key, T value);

  Future<bool> delete(String key) {
    if (_database == null) return Future.value(false);
    return _delete(_database!, key);
  }

  Future<bool> _delete(Database database, String key);

  Future<bool> update(String key, T value) {
    if (_database == null) return Future.value(false);
    return _update(_database!, key, value);
  }

  Future<bool> _update(Database database, String key, T value);

  Future<List<T?>> get(String key) {
    if (_database == null) return Future.value(List.empty());
    return _get(_database!, key);
  }

  Future<List<T?>> _get(Database database, String key);

  Future<void> close() => _database?.close() ?? Future.value();
}

/// -----------------------------------------------------------------------------
/// Provider
/// -----------------------------------------------------------------------------
class DatabaseProvider extends BaseDatabaseProvider<String> {
  static const _dbTable = BaseDatabaseProvider._table;

  @override
  Future<bool> _insert(Database database, String key, String value) async {
    final id = await database.insert(_dbTable, {
      BaseDatabaseProvider._columnKey: key,
      BaseDatabaseProvider._columnRequestDate: DateTime.now().toString(),
      BaseDatabaseProvider._columnExpiredDate: "-1",
      BaseDatabaseProvider._columnData: value,
    });
    return id >= 0;
  }

  @override
  Future<bool> _delete(Database database, String key) async {
    final id = await database.delete(
      _dbTable,
      where: '${BaseDatabaseProvider._columnKey} = ?',
      whereArgs: [key],
    );
    return id >= 0;
  }

  @override
  Future<List<String?>> _get(Database database, String key) async {
    List<Map<String, dynamic>> list = await database.query(
      BaseDatabaseProvider._table,
      columns: [BaseDatabaseProvider._columnData],
      where: '${BaseDatabaseProvider._columnKey} = ?',
      whereArgs: [key],
    );
    if (list.isEmpty) return List.empty();
    return list.map((e) => (e.values.first as String)).toList();
  }

  @override
  Future<bool> _update(Database database, String key, String value) async {
    final id = await database.update(
        _dbTable,
        {
          BaseDatabaseProvider._columnKey: key,
          BaseDatabaseProvider._columnRequestDate: DateTime.now().toString(),
          BaseDatabaseProvider._columnExpiredDate: "-1",
          BaseDatabaseProvider._columnData: value,
        },
        where: '$BaseDatabaseProvider._columnKey = ?',
        whereArgs: [key]);
    return id >= 0;
  }
}
