import 'package:flutter/material.dart';
import 'package:proyekaplikasikoskosan/dasboardkoskosan.dart';
import 'package:proyekaplikasikoskosan/database_helpermomkos.dart';
import 'package:proyekaplikasikoskosan/filedaftarsekarang.dart';
import 'package:proyekaplikasikoskosan/modelusermomkos.dart';

class Tugas6 extends StatefulWidget {
  const Tugas6({super.key});

  @override
  State<Tugas6> createState() => _Tugas6State();
}

class _Tugas6State extends State<Tugas6> {
  Future<void> login() async {
    final result = await DBHelper().login(email.text, password.text);

    //  login berhasil

    if (result.isNotEmpty) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("Login Berhasil")));

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => DashboardPage(nama: result.first[nama]),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Email atau Password Salah")),
      );
    }
  }

  final formKey = GlobalKey<FormState>();

  TextEditingController nama = TextEditingController();

  TextEditingController email = TextEditingController();

  TextEditingController hp = TextEditingController();

  TextEditingController password = TextEditingController();
  int? selectedId;

  // REGISTER

  void register() async {
    final userEmail = email.text.trim();
    final userPassword = password.text;
    final userNama = nama.text;
    final userhp = hp.text;

    if (userEmail.isEmpty || userPassword.isEmpty) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('isi semua filed bro!')));
      return;
    }

    final user = User(
      nama: userNama,
      hp: userhp,
      email: userEmail,
      password: userPassword,
    );

    bool success = await DBHelper().registerUser(user);

    // Cek apakah widget masih terpasang (mounted) sebelum menggunakan context

    if (!mounted) return;

    if (success) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Akun berhasil dibuat')));
      setState(() {});
      // Tambahkan navigasi ke halaman login jika perlu
    } else {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Email sudah terdaftar!')));
    }
  }

  //  GET DATA
  Future<List<Map<String, dynamic>>> getData() {
    return DBHelper().getUsers();
  }

  // SIMPAN DATA

  Future simpanData() async {
    if (formKey.currentState!.validate()) {
      User user = User(
        nama: nama.text,
        email: email.text,
        hp: hp.text,
        password: password.text,
      );
      await DBHelper().registerUser(user);

      nama.clear();
      email.clear();
      hp.clear();
      password.clear();

      setState(() {});
    }
  }

  Future updateData() async {
    if (selectedId == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Pilih data yang akan diedit")),
      );
      return;
    }

    User user = User(
      id: selectedId,
      nama: nama.text,
      email: email.text,
      hp: hp.text,
      password: password.text,
    );

    await DBHelper().updateUser(user.toMap());

    nama.clear();
    email.clear();
    hp.clear();
    password.clear();

    selectedId = null;

    setState(() {});

    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text("Data berhasil diupdate")));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // APPBAR
      appBar: AppBar(
        title: const Text(
          "MY MOM KOS",
          style: TextStyle(color: Colors.redAccent),
        ),

        backgroundColor: Colors.green,
        centerTitle: true,
      ),

      // LISTVIEW SEBAGAI ROOT
      body: ListView(
        padding: const EdgeInsets.all(15),

        children: [
          // JUDUL FORM
          const Text(
            "KOSKU APP",
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.redAccent,
              fontSize: 25,
              fontWeight: FontWeight.bold,
            ),
          ),

          // JUDUL LIST
          const Text(
            "Kelola Hunian Menjadi Lebih Simple dan Mudah ",
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
          ),

          SizedBox(height: 50),

          const Text(
            "Nomor Hp atau Email",
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              fontStyle: FontStyle.italic,
            ),
          ),

          // INPUT EMAIL
          TextField(
            controller: email,
            decoration: InputDecoration(
              labelText: "Masukkan Email",
              border: OutlineInputBorder(), // buat kotak border
              prefixIcon: Icon(Icons.email),
            ),
          ),

          SizedBox(height: 25), // untuk batas border atas dan bawah
          // INPUT NOMOR HP
          TextField(
            decoration: InputDecoration(
              labelText: "Masukkan Nomor HP",
              border: OutlineInputBorder(),
              prefixIcon: Icon(Icons.phone),
            ),
          ),

          SizedBox(height: 30),

          // INPUT PASSWORD
          TextField(
            controller: password,
            obscureText: true,
            decoration: const InputDecoration(
              labelText: "Password",
              border: OutlineInputBorder(),
            ),
          ),

          // const Text(
          //   "Password",
          //   style: TextStyle(
          //     fontSize: 12,
          //     fontWeight: FontWeight.bold,
          //     fontStyle: FontStyle.italic,
          //   ),
          // ),
          const Text(
            "Lupa Password?",
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              fontStyle: FontStyle.italic,
            ),
          ),

          SizedBox(height: 15),

          SizedBox(height: 30),

          //  tombol masuk
          SizedBox(
            width: double.infinity,
            height: 50,
            child: ElevatedButton(
              // icon: const Icon(Icons.arrow_forward, color: Colors.white),
              // label: const Text("Masuk", style: TextStyle(color: Colors.white)),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 8, 80, 139),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25),
                ),
              ),

              //  tombol login
              onPressed: () async {
                await login();
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Text(
                    "Masuk",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  SizedBox(width: 10),

                  Icon(Icons.login, color: Colors.white),
                ],
              ),
            ),
          ),
          SizedBox(height: 40),
          Row(
            children: const [
              Expanded(child: Divider()),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: Text(
                  "ATAU",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              Expanded(child: Divider()),
            ],
          ),
          SizedBox(height: 40),
          Row(
            children: [
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: () {},

                  icon: const Icon(Icons.g_mobiledata, color: Colors.black),

                  label: const Text(
                    "Google",
                    style: TextStyle(color: Colors.black, fontSize: 18),
                  ),

                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 10),

                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                ),
              ),
              SizedBox(width: 35),
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: () {},

                  icon: const Icon(Icons.facebook, color: Colors.black),
                  label: const Text(
                    "Facebook",
                    style: TextStyle(color: Colors.black, fontSize: 18),
                  ),

                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 10),

                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 70),

          // FOOTER
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 10),
            decoration: const BoxDecoration(
              color: Color.fromARGB(255, 11, 163, 37),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(20),
                bottomRight: Radius.circular(20),
              ),
            ),

            // belum punya akun
            // child: Row(
            //   mainAxisAlignment: MainAxisAlignment.center,
            //   children: [
            //     Text("Belum punya akun? ", style: TextStyle(fontSize: 18)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Belum punya akun? ",
                  style: TextStyle(fontSize: 18),
                ),
                const Icon(
                  Icons.app_registration,
                  color: Colors.deepPurple,
                  size: 20,
                ),

                // Icon(
                //   Icons.app_registration,
                //   color: Colors.deepPurple,
                //   size: 20,
                // ),
                SizedBox(width: 5),

                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const DaftarPage()),
                    );
                  },

                  child: const Text(
                    "Daftar Sekarang",
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.deepPurple,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),

                // //  dafatar sekarang
                // Text("Daftar Sekarang",
                //   style: TextStyle(
                //     fontSize: 18,
                //     color: Colors.deepPurple,
                //     fontWeight: FontWeight.bold,
                //   ),
                // ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
