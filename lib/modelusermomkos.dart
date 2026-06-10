class User {
  int? id;
  String nama;
  String email;
  String hp;
  String password;
  String kamar;

  User({
    this.id,
    required this.nama,
    required this.email,
    required this.hp,
    required this.password,
    required this.kamar,
  });

  Map<String, dynamic> toMap() {
    return {
      'nama': nama,
      'email': email,
      'hp': hp,
      'password': password,
      'kamar': kamar,
    };
  }
}
