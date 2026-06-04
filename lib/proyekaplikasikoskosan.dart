import 'package:flutter/material.dart';
import 'package:proyekaplikasikoskosan/dasboardkoskosan.dart';
import 'package:proyekaplikasikoskosan/filedaftarsekarang.dart';

import 'database_helpermomkos.dart';

class Tugas6 extends StatefulWidget {
  const Tugas6({super.key});

  @override
  State<Tugas6> createState() => _Tugas6State();
}

class _Tugas6State extends State<Tugas6> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
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
            controller: emailController,
            decoration: InputDecoration(
              labelText: "Masukkan Email",
              border: OutlineInputBorder(),
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

          // TEKS PASSWORD
          SizedBox(height: 30),
          TextField(
            controller: passwordController,
            obscureText: true,
            decoration: InputDecoration(
              labelText: "Password",
              border: OutlineInputBorder(),
              prefixIcon: Icon(Icons.lock),
            ),
          ),

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

          //  TOMBOL MASUK
          SizedBox(
            width: double.infinity,
            height: 50,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 8, 80, 139),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25),
                ),
              ),

              // onPressed: () {
              //   Navigator.push(
              //     context,
              //     MaterialPageRoute(
              //       builder: (context) => const DashboardPage(),
              //     ),
              //   );
              // },
              onPressed: () async {
                final user = await DBHelper().login(
                  emailController.text,
                  passwordController.text,
                );
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const DashboardPage(),
                  ),
                );
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

                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const DaftarPage(),
                      ),
                    );
                  },

                  child: const Text(
                    " Daftar Sekarang",
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.deepPurple,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
