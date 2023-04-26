import 'package:sqflite/sqflite.dart';
// ignore: depend_on_referenced_packages
import 'package:path/path.dart' as p;
import 'package:vocab/models/words.dart';

class DatabaseRepository {
  static final DatabaseRepository instance = DatabaseRepository._init();
  DatabaseRepository._init();

  Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await initDB('vocab.db');
    return _database!;
  }

  Future<Database> initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = p.join(dbPath, filePath);

    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    await db.execute('''
      CREATE TABLE vocab(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        word TEXT NOT NULL,
        meaning TEXT NOT NULL
      );
    ''');
  }

  Future insertWord({required Word word}) async {
    try {
      final db = await database;
      db.insert('vocab', word.toMap());
    } catch (e) {
      rethrow;
    }
  }

  Future<List<Word>>? getAllWords() async {
    final db = await database;
    final result = await db.query("vocab");
    return result.map((json) => Word.fromJson(json)).toList();
  }

  Future<void> deleteWord(Word word) async {
    try {
      final db = await database;
      await db.delete("vocab", where: 'id = ?', whereArgs: [word.id]);
    } catch (e) {
      rethrow;
    }
  }

  Future<void> updateWord(Word word) async {
    try {
      final db = await database;
      await db
          .update("vocab", word.toMap(), where: "id = ?", whereArgs: [word.id]);
    } catch (e) {
      rethrow;
    }
  }
}
