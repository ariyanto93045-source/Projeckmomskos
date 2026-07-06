import 'package:flutter_test/flutter_test.dart';
import 'package:proyekaplikasikoskosan/database_helpermomkos.dart';
import 'package:proyekaplikasikoskosan/modelusermomkos.dart';

void main() {
  test('toFirestoreDocument preserves user data', () {
    final user = User(
      nama: 'Budi',
      email: 'budi@example.com',
      hp: '081234567890',
      password: '123456',
      kamar: 'A1',
      role: 'penghuni',
    );

    final data = DBHelper.toFirestoreDocument(user);

    expect(data['nama'], 'Budi');
    expect(data['email'], 'budi@example.com');
    expect(data['hp'], '081234567890');
    expect(data['password'], '123456');
    expect(data['kamar'], 'A1');
    expect(data['role'], 'penghuni');
  });
}
