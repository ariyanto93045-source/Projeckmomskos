import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:proyekaplikasikoskosan/modelusermomkos.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DBHelper {
  static final DBHelper _instance = DBHelper._internal();
  factory DBHelper() => _instance;
  DBHelper._internal();

  static Database? _database;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB();
    return _database!;
  }

  Future<void> tampilkanUser() async {
    final snapshot = await _firestore.collection('users').get();
    log(snapshot.docs.map((d) => d.data()).toList().toString());
  }

  Future<void> migrateLocalUsersToFirestore() async {
    final db = await database;
    final localUsers = await db.query('users');

    for (final row in localUsers) {
      final email = row['email']?.toString();
      if (email == null || email.isEmpty) continue;

      final existing = await _firestore
          .collection('users')
          .where('email', isEqualTo: email)
          .limit(1)
          .get();

      final data = Map<String, dynamic>.from(row);
      data.remove('id');

      if (existing.docs.isEmpty) {
        await _firestore.collection('users').add(data);
      } else {
        await existing.docs.first.reference.set(data, SetOptions(merge: true));
      }
    }
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
  kamar TEXT,
  role TEXT
)
''');
      },
    );
  }

  static Map<String, dynamic> toFirestoreDocument(User pengguna) {
    return {
      'nama': pengguna.nama,
      'email': pengguna.email,
      'hp': pengguna.hp,
      'password': pengguna.password,
      'kamar': pengguna.kamar,
      'role': pengguna.role,
    };
  }

  Future<bool> registerUser(User pengguna) async {
    try {
      final existing = await _firestore
          .collection('users')
          .where('email', isEqualTo: pengguna.email)
          .limit(1)
          .get();

      if (existing.docs.isNotEmpty) {
        return false;
      }

      await _firestore.collection('users').add(toFirestoreDocument(pengguna));
      log('INSERT SUCCESS TO FIRESTORE');
      return true;
    } catch (e) {
      log('INSERT ERROR: $e');
      return false;
    }
  }

  Future<List<Map<String, dynamic>>> login(
    String email,
    String password,
  ) async {
    final snapshot = await _firestore
        .collection('users')
        .where('email', isEqualTo: email)
        .where('password', isEqualTo: password)
        .limit(1)
        .get();

    return snapshot.docs.map((doc) {
      final data = doc.data();
      return {
        'id': doc.id,
        'nama': data['nama'],
        'email': data['email'],
        'hp': data['hp'],
        'password': data['password'],
        'kamar': data['kamar'],
        'role': data['role'],
      };
    }).toList();
  }

  Future<List<Map<String, dynamic>>> getUsers() async {
    final snapshot = await _firestore.collection('users').get();
    return snapshot.docs.map((doc) {
      final data = doc.data();
      return {
        'id': doc.id,
        'nama': data['nama'],
        'email': data['email'],
        'hp': data['hp'],
        'password': data['password'],
        'kamar': data['kamar'],
        'role': data['role'],
      };
    }).toList();
  }

  Future<int> updateUser(Map<String, dynamic> user) async {
    try {
      final id = user['id'];
      if (id is int || id is String) {
        await _firestore.collection('users').doc(id.toString()).update({
          'nama': user['nama'],
          'email': user['email'],
          'hp': user['hp'],
          'password': user['password'],
          'kamar': user['kamar'],
          'role': user['role'],
        });
        return 1;
      }
      return 0;
    } catch (e) {
      log('UPDATE ERROR: $e');
      return 0;
    }
  }

  Future<int> deleteUser(dynamic id) async {
    try {
      await _firestore.collection('users').doc(id.toString()).delete();
      return 1;
    } catch (e) {
      log('DELETE ERROR: $e');
      return 0;
    }
  }
}
