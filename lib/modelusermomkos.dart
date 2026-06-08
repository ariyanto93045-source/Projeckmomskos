class User {
  int? id;
  String nama;
  String email;
  String hp;
  String password;

  User({
    this.id,
    required this.nama,
    required this.email,
    required this.hp,
    required this.password,
  });

  Map<String, dynamic> toMap() {
    return {'nama': nama, 'email': email, 'hp': hp, 'password': password};
  }
}
