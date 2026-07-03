import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:proyekaplikasikoskosan/modelusermomkos.dart';

class UserModelFirebase {
  final String? uid;
  final String nama;
  final String email;
  final String hp;
  final String kamar;
  final String role;
  // Catatan: Tidak disarankan menyimpan password plaintext di Firestore demi keamanan.
  // Firebase Auth sudah menangani enkripsi & verifikasi password secara aman.
  final String? password;

  UserModelFirebase({
    this.uid,
    required this.nama,
    required this.email,
    required this.hp,
    required this.kamar,
    required this.role,
    this.password,
  });

  // Mengonversi UserModelFirebase ke Map untuk disimpan di Firestore/Firebase
  Map<String, dynamic> toMap() {
    final Map<String, dynamic> data = {
      'nama': nama,
      'email': email,
      'hp': hp,
      'kamar': kamar,
      'role': role,
    };
    if (uid != null) {
      data['uid'] = uid;
    }
    // Jika password diisi (misal untuk sinkronisasi lokal), kita bisa abaikan saat ke Firestore
    // demi keamanan, namun jika Anda tetap ingin menyimpannya, hilangkan komentar baris di bawah:
    // if (password != null) {
    //   data['password'] = password;
    // }
    return data;
  }

  // Membuat UserModelFirebase dari Map (misalnya data dari dokumen Firestore)
  factory UserModelFirebase.fromMap(Map<String, dynamic> map, {String? documentId}) {
    return UserModelFirebase(
      uid: documentId ?? map['uid'] as String?,
      nama: map['nama'] as String? ?? '',
      email: map['email'] as String? ?? '',
      hp: map['hp'] as String? ?? '',
      kamar: map['kamar'] as String? ?? '',
      role: map['role'] as String? ?? '',
      password: map['password'] as String?,
    );
  }

  // Membuat UserModelFirebase langsung dari DocumentSnapshot Firestore
  factory UserModelFirebase.fromFirestore(DocumentSnapshot<Map<String, dynamic>> doc) {
    final data = doc.data() ?? {};
    return UserModelFirebase.fromMap(data, documentId: doc.id);
  }

  // Konversi dari model lokal SQLite (User) ke UserModelFirebase
  factory UserModelFirebase.fromUser(User user, {String? uid}) {
    return UserModelFirebase(
      uid: uid,
      nama: user.nama,
      email: user.email,
      hp: user.hp,
      kamar: user.kamar,
      role: user.role,
      password: user.password,
    );
  }

  // Konversi UserModelFirebase ke model lokal SQLite (User)
  User toUser() {
    return User(
      id: null, // SQLite menggunakan ID integer auto-increment
      nama: nama,
      email: email,
      hp: hp,
      password: password ?? '',
      kamar: kamar,
      role: role,
    );
  }

  // Helper copyWith untuk mempermudah perubahan data parsial
  UserModelFirebase copyWith({
    String? uid,
    String? nama,
    String? email,
    String? hp,
    String? kamar,
    String? role,
    String? password,
  }) {
    return UserModelFirebase(
      uid: uid ?? this.uid,
      nama: nama ?? this.nama,
      email: email ?? this.email,
      hp: hp ?? this.hp,
      kamar: kamar ?? this.kamar,
      role: role ?? this.role,
      password: password ?? this.password,
    );
  }
}
