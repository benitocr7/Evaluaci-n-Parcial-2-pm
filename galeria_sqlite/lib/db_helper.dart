import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DBHelper {
  static Database? _db;

  static const String autor = "EM-7"; // CAMBIA ESTO

  static Future<Database> get database async {
    if (_db != null) return _db!;
    _db = await _initDB();
    return _db!;
  }

  static Future<Database> _initDB() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'galeria.db');

    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE galeria (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            titulo TEXT,
            imageUrl TEXT,
            autor TEXT
          )
        ''');

        for (int i = 1; i <= 15; i++) {
          await db.insert('galeria', {
            'titulo': 'Imagen $i',
            'imageUrl': 'https://picsum.photos/seed/$i/300/200',
            'autor': autor,
          });
        }
      },
    );
  }

  static Future<List<Map<String, dynamic>>> obtenerPorAutor() async {
    final db = await database;
    return await db.query(
      'galeria',
      where: 'autor = ?',
      whereArgs: [autor],
    );
  }
}
