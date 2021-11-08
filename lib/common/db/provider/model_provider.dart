import 'package:flutter_router_demo/program/model/model.dart';
import 'package:path/path.dart' as path;
import 'package:sqflite/sqflite.dart';

abstract class BaseModelProvider<T> {
  static Database? _database;

  OnDatabaseCreateFn? get onDatabaseCreate => null;

  OnDatabaseVersionChangeFn? get onDatabaseVersionUpgrade => null;

  OnDatabaseVersionChangeFn? get onDatabaseVersionDowngrade => null;

  OnDatabaseOpenFn? get onDatabaseOpen => null;

  OnDatabaseConfigureFn? get onDatabaseConfigure => null;

  Future<void> open({String database = "data.db"}) async {
    var _databasePath = path.join(await getDatabasesPath(), 'database');
    final db = await openDatabase(
      _databasePath,
      version: 1,
      onCreate: onDatabaseCreate,
      onUpgrade: onDatabaseVersionUpgrade,
      onDowngrade: onDatabaseVersionDowngrade,
      onOpen: onDatabaseOpen,
      onConfigure: onDatabaseConfigure,
    );
    _database = db;
  }

  Future<bool> insert(T t) {
    if (_database == null) return Future.value(false);
    return _insert(_database!, t);
  }

  Future<bool> _insert(Database database, T t);

  Future<bool> delete(T t) {
    if (_database == null) return Future.value(false);
    return _delete(_database!, t);
  }

  Future<bool> _delete(Database database, T t);

  Future<bool> update(T t) {
    if (_database == null) return Future.value(false);
    return _update(_database!, t);
  }

  Future<bool> _update(Database database, T t);

  Future<List<T>?> get(int id) {
    if (_database == null) return Future.value(null);
    return _get(_database!, id);
  }

  Future<List<T>?> _get(Database database, int id);

  Future<void> close() => _database?.close() ?? Future.value();
}

class SingleProgramProvider extends BaseModelProvider<SingleProgram> {
  static const _tableName = "singleProgram";
  static const _id = "_id";
  static const _columnId = "id";
  static const _columnTitle = "title";
  static const _columnDescription = "description";
  static const _columnRuntimeHours = "runtimeHours";
  static const _columnSeoName = "seoName";

  @override
  OnDatabaseCreateFn? get onDatabaseCreate => (Database database, int version) async {
        await database.execute("create table $_tableName "
            "("
            "$_id integer primary key autoincrement, "
            "$_columnId text not null, "
            "$_columnTitle text not null, "
            "$_columnDescription text not null, "
            "$_columnRuntimeHours text not null, "
            "$_columnSeoName text not null"
            ")");
      };

  @override
  Future<bool> _insert(Database database, SingleProgram t) async {
    final id = await database.insert(_tableName, t.toJson());
    return id >= 0;
  }

  @override
  Future<bool> _delete(Database database, SingleProgram t) async {
    final id = await database.delete(_tableName, where: '$_columnId = ?', whereArgs: [t.id]);
    return id >= 0;
  }

  @override
  Future<List<SingleProgram>?> _get(Database database, int id) async {
    // List<Map<String, dynamic>> list = await database.query(
    //   _tableName,
    //   columns: [_columnId, _columnTitle, _columnDescription, _columnRuntimeHours, _columnSeoName],
    //   where: '$_columnId = ?',
    //   whereArgs: [id],
    // );
    List<Map<String, dynamic>> list = await database.rawQuery('SELECT * FROM $_tableName');
    if (list.isNotEmpty) {
      return list.map((e) => SingleProgram.fromJson(e)).toList();
    }
    return null;
  }

  @override
  Future<bool> _update(Database database, SingleProgram t) async {
    final id = await database.update(_tableName, t.toJson(), where: '$_columnId = ?', whereArgs: [t.id]);
    return id >= 0;
  }
}
