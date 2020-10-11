import 'package:path/path.dart' as path;
import 'package:sqflite/sqflite.dart' as sql;

class DBHelper {
  static Future<sql.Database> database() async {
    final dbPath = await sql.getDatabasesPath();
    return sql.openDatabase(path.join(dbPath, 'myNotes.db'),
        onCreate: (db, version) {
      return db.execute(
          'CREATE TABLE user_notes(id TEXT PRIMARY KEY, title TEXT, content TEXT)');
    }, version: 1);
  }

  static Future<void> insert({String table, Map<String, Object> data}) async {
    final db = await DBHelper.database();

    db.insert(
      table,
      data,
      conflictAlgorithm: sql.ConflictAlgorithm.replace,
    );
  }

  static Future<List<Map<String, dynamic>>> getData({String table}) async {
    final db = await DBHelper.database();

    return db.query(table, orderBy: 'id DESC');
  }

  static Future<void> updateData(
      {String table, Map<String, dynamic> values, String id}) async {
    final db = await DBHelper.database();

    db.update(
      table,
      values,
      where: 'id = ?',
      whereArgs: [id],
      conflictAlgorithm: sql.ConflictAlgorithm.replace,
    );
  }

  static Future<void> deleteNoteData({String table, String id}) async {
    final db = await DBHelper.database();

    db.delete(
      table,
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  static Future<void> closeDB() async {
    final db = await DBHelper.database();
    db.close();
  }
}
