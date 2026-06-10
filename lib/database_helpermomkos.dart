import 'dart:developer';

import 'package:path/path.dart';
import 'package:proyekaplikasikoskosan/modelusermomkos.dart';
import 'package:sqflite/sqflite.dart';

class DBHelper {
  static final DBHelper _instance = DBHelper._internal();
  factory DBHelper() => _instance;
  DBHelper._internal();

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB();
    return _database!;
  }

  // TAMBAHKAN DISINI

  Future<void> tampilkanUser() async {
    final db = await database;

    List<Map<String, dynamic>> data = await db.query('users');

    print(data);
  }

  Future<Database> _initDB() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'ppkd.db');

    return await openDatabase(
      path,
      version: 2,
      onCreate: (db, version) async {
        await db.execute('''
CREATE TABLE users(
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  nama TEXT,
  email TEXT UNIQUE,
  hp TEXT,
  password TEXT,
  kamar TEXT
)
''');
      },
      // onUpgrade: (db, oldVersion, newVersion) {
      //    await db.execute('''
      //     CREATE TABLE users(
      //       id INTEGER PRIMARY KEY AUTOINCREMENT,
      //       email TEXT UNIQUE,
      //       password TEXT
      //     )
      //   ''');
      // },
    );
  }

  // Fungsi Register CREATE

  Future<bool> registerUser(User pengguna) async {
    final db = await database;
    try {
      final result = await db.insert('users', pengguna.toMap());
      log("INSERT SUCCESS ID: $result");
      return true;
    } catch (e) {
      log("INSERT ERROR: $e");
      return false;
    }
  }
  // fungsi login

  Future<List<Map<String, dynamic>>> login(
    String email,
    String password,
  ) async {
    final db = await database;

    return await db.query(
      'users',
      where: '(email = ? OR hp = ?) AND password = ?',
      whereArgs: [email, email, password],
    );
  }

  // READ
  Future<List<Map<String, dynamic>>> getUsers() async {
    final db = await database;
    return await db.query('users');
  }

  // UPDATE
  Future<int> updateUser(Map<String, dynamic> user) async {
    final db = await database;

    return await db.update(
      'users',
      user,
      where: 'id = ?',
      whereArgs: [user['id']],
    );
  }

  // DELETE
  Future<int> deleteUser(int id) async {
    final db = await database;

    return await db.delete('users', where: 'id = ?', whereArgs: [id]);
  }
}
