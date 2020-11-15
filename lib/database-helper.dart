import 'dart:async';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:BitMob/moeda.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = new DatabaseHelper.internal();
  factory DatabaseHelper() => _instance;
  static Database _db;
  DatabaseHelper.internal();
  Future<Database> get db async {
    if (_db != null) {
      return _db;
    }
    _db = await initDb();
    return _db;
  }

  initDb() async {
    String databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'notes.db');
    var db = await openDatabase(path, version: 1, onCreate: _onCreate);
    return db;
  }

  void _onCreate(Database db, int newVersion) async {
    await db.execute(
        'CREATE TABLE moeda(id INTEGER PRIMARY KEY,nome TEXT, valor TEXT, simbolo TEXT, variacao_dia TEXT)');
  }

  Future<int> inserirMoeda(Moeda moeda) async {
    var dbClient = await db;
    var result = await dbClient.insert("moeda", moeda.toMap());
    return result;
  }

  Future<List> getMoedas() async {
    var dbClient = await db;
    var result = await dbClient.query("moeda",
        columns: ["id", "nome", "valor", "simbolo", "variacao_dia"]);
    return result.toList();
  }

  Future<int> getCount() async {
    var dbClient = await db;
    return Sqflite.firstIntValue(
        await dbClient.rawQuery('SELECT COUNT(*) FROM moeda'));
  }

  Future<Moeda> getMoeda(int id) async {
    var dbClient = await db;
    List<Map> result = await dbClient.query("moeda",
        columns: ["id", "nome", "valor", "simbolo", "variacao_dia"],
        where: 'id = ?',
        whereArgs: [id]);
    if (result.length > 0) {
      return new Moeda.fromMap(result.first);
    }
    return null;
  }

  Future<int> deleteMoeda(int id) async {
    var dbClient = await db;
    return await dbClient.delete("moeda", where: 'id = ?', whereArgs: [id]);
  }

  Future<int> updateMoeda(Moeda moeda) async {
    var dbClient = await db;
    return await dbClient
        .update("moeda", moeda.toMap(), where: "id = ?", whereArgs: [moeda.id]);
  }

  Future close() async {
    var dbClient = await db;
    return dbClient.close();
  }
}
