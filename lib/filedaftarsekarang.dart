import 'package:flutter/material.dart';
import 'package:proyekaplikasikoskosan/database_helpermomkos.dart';
import 'package:proyekaplikasikoskosan/modelusermomkos.dart';

class DaftarPage extends StatefulWidget {
  const DaftarPage({super.key});

  @override
  State<DaftarPage> createState() => _DaftarPageState();
}

class _DaftarPageState extends State<DaftarPage> {
  final nama = TextEditingController();
  final email = TextEditingController();
  final hp = TextEditingController();
  final password = TextEditingController();

  @override
  void dispose() {
    nama.dispose();
    email.dispose();
    hp.dispose();
    password.dispose();
    super.dispose();
  }

  Future<void> simpanData() async {
    if (nama.text.isEmpty ||
        email.text.isEmpty ||
        hp.text.isEmpty ||
        password.text.isEmpty) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("Semua data harus diisi")));
      return;
    }

    try {
      bool berhasil = await DBHelper().registerUser(
        User(
          nama: nama.text,
          email: email.text,
          hp: hp.text,
          password: password.text,
        ),
      );

      await DBHelper().tampilkanUser();

      if (berhasil) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text("Akun berhasil dibuat")));
        Navigator.pop(context);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Email sudah dipakai / gagal daftar")),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Error: $e")));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF0F9D58), Color(0xFF0B8043)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Card(
                elevation: 12,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(
                        Icons.person_add_alt_1,
                        size: 70,
                        color: Colors.green,
                      ),

                      const SizedBox(height: 10),

                      const Text(
                        "DAFTAR AKUN",
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Colors.green,
                        ),
                      ),

                      const SizedBox(height: 25),

                      TextField(
                        controller: nama,
                        decoration: InputDecoration(
                          labelText: "Nama Lengkap",
                          prefixIcon: const Icon(Icons.person),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                        ),
                      ),

                      const SizedBox(height: 15),

                      TextField(
                        controller: email,
                        decoration: InputDecoration(
                          labelText: "Email",
                          prefixIcon: const Icon(Icons.email),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                        ),
                      ),

                      const SizedBox(height: 15),

                      TextField(
                        controller: hp,
                        decoration: InputDecoration(
                          labelText: "Nomor HP",
                          prefixIcon: const Icon(Icons.phone),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                        ),
                      ),

                      const SizedBox(height: 15),

                      TextField(
                        controller: password,
                        obscureText: true,
                        decoration: InputDecoration(
                          labelText: "Password",
                          prefixIcon: const Icon(Icons.lock),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                        ),
                      ),

                      const SizedBox(height: 25),

                      SizedBox(
                        width: double.infinity,
                        height: 50,
                        child: ElevatedButton(
                          onPressed: () {
                            simpanData();
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.green,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                          ),
                          child: const Text(
                            "DAFTAR",
                            style: TextStyle(fontSize: 18),
                          ),
                        ),
                      ),

                      const SizedBox(height: 10),

                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text("Sudah punya akun? Login"),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}


















// import 'package:flutter/material.dart';
// import 'package:proyekaplikasikoskosan/database_helpermomkos.dart';
// import 'package:proyekaplikasikoskosan/modelusermomkos.dart';

// class DaftarPage extends StatefulWidget {
//   const DaftarPage({super.key});

//   @override
//   State<DaftarPage> createState() => _DaftarPageState();
// }

// class _DaftarPageState extends State<DaftarPage> {
//   final nama = TextEditingController();
//   final email = TextEditingController();
//   final hp = TextEditingController();
//   final password = TextEditingController();

//   @override
//   void dispose() {
//     nama.dispose();
//     email.dispose();
//     hp.dispose();
//     password.dispose();
//     super.dispose();
//   }

//   Future<void> simpanData() async {
//     if (nama.text.isEmpty ||
//         email.text.isEmpty ||
//         hp.text.isEmpty ||
//         password.text.isEmpty) {
//       ScaffoldMessenger.of(
//         context,
//       ).showSnackBar(const SnackBar(content: Text("Semua data harus diisi")));
//       return;
//     }
//     try {
//       bool berhasil = await DBHelper().registerUser(
//         User(
//           nama: nama.text,
//           email: email.text,
//           hp: hp.text,
//           password: password.text,
//         ),
//       );
//       await DBHelper().tampilkanUser();
//       if (berhasil) {
//         ScaffoldMessenger.of(
//           context,
//         ).showSnackBar(const SnackBar(content: Text("Akun berhasil dibuat")));
//         Navigator.pop(context);
//       } else {
//         ScaffoldMessenger.of(context).showSnackBar(
//           const SnackBar(content: Text("Email sudah dipakai / gagal daftar")),
//         );
//       }
//     } catch (e) {
//       ScaffoldMessenger.of(
//         context,
//       ).showSnackBar(SnackBar(content: Text("Error: $e")));
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("Daftar Akun Baru"),
//         backgroundColor: Colors.green,
//       ),

//       body: Padding(
//         padding: const EdgeInsets.all(20),

//         child: ListView(
//           children: [
//             TextField(
//               controller: nama,
//               decoration: const InputDecoration(
//                 labelText: "Nama Lengkap",
//                 border: OutlineInputBorder(),
//               ),
//             ),

//             const SizedBox(height: 15),

//             TextField(
//               controller: email,
//               decoration: const InputDecoration(
//                 labelText: "Email",
//                 border: OutlineInputBorder(),
//               ),
//             ),

//             const SizedBox(height: 15),

//             TextField(
//               controller: hp,
//               decoration: const InputDecoration(
//                 labelText: "Nomor HP",
//                 border: OutlineInputBorder(),
//               ),
//             ),

//             const SizedBox(height: 15),

//             TextField(
//               controller: password,
//               obscureText: true,
//               decoration: const InputDecoration(
//                 labelText: "Password",
//                 border: OutlineInputBorder(),
//               ),
//             ),

//             const SizedBox(height: 25),

//             ElevatedButton(
//               onPressed: () {
//                 simpanData();
//               },
//               child: const Text("DAFTAR"),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }






// import 'package:flutter/material.dart';
// import 'package:proyekaplikasikoskosan/database_helpermomkos.dart';
// import 'package:proyekaplikasikoskosan/modelusermomkos.dart';

// class AuthPage extends StatefulWidget {
//   const AuthPage({super.key});

//   @override
//   State<AuthPage> createState() => _AuthPageState();
// }

// class _AuthPageState extends State<AuthPage> {
//   bool isLogin = true;

//   final nama = TextEditingController();
//   final email = TextEditingController();
//   final hp = TextEditingController();
//   final password = TextEditingController();

//   void togglePage() {
//     setState(() {
//       isLogin = !isLogin;
//     });
//   }

//   Future<void> login() async {
//     final result = await DBHelper().login(email.text, password.text);

//     if (result.isNotEmpty) {
//       ScaffoldMessenger.of(
//         context,
//       ).showSnackBar(const SnackBar(content: Text("Login berhasil")));
//     } else {
//       ScaffoldMessenger.of(
//         context,
//       ).showSnackBar(const SnackBar(content: Text("Email / Password salah")));
//     }
//   }

//   Future<void> register() async {
//     if (nama.text.isEmpty ||
//         email.text.isEmpty ||
//         hp.text.isEmpty ||
//         password.text.isEmpty) {
//       ScaffoldMessenger.of(
//         context,
//       ).showSnackBar(const SnackBar(content: Text("Semua data wajib diisi")));
//       return;
//     }

//     bool success = await DBHelper().registerUser(
//       User(
//         nama: nama.text,
//         email: email.text,
//         hp: hp.text,
//         password: password.text,
//       ),
//     );

//     if (success) {
//       ScaffoldMessenger.of(
//         context,
//       ).showSnackBar(const SnackBar(content: Text("Akun berhasil dibuat")));
//       setState(() {
//         isLogin = true;
//       });
//     } else {
//       ScaffoldMessenger.of(
//         context,
//       ).showSnackBar(const SnackBar(content: Text("Email sudah terdaftar")));
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Container(
//         width: double.infinity,
//         decoration: const BoxDecoration(
//           gradient: LinearGradient(
//             colors: [Color(0xFF0F9D58), Color(0xFF0B8043)],
//             begin: Alignment.topLeft,
//             end: Alignment.bottomRight,
//           ),
//         ),
//         child: Center(
//           child: SingleChildScrollView(
//             child: Padding(
//               padding: const EdgeInsets.all(20),
//               child: Card(
//                 elevation: 10,
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(20),
//                 ),
//                 child: Padding(
//                   padding: const EdgeInsets.all(20),
//                   child: Column(
//                     mainAxisSize: MainAxisSize.min,
//                     children: [
//                       Text(
//                         isLogin ? "LOGIN" : "REGISTER",
//                         style: const TextStyle(
//                           fontSize: 26,
//                           fontWeight: FontWeight.bold,
//                           color: Colors.green,
//                         ),
//                       ),

//                       const SizedBox(height: 20),

//                       if (!isLogin)
//                         TextField(
//                           controller: nama,
//                           decoration: InputDecoration(
//                             labelText: "Nama Lengkap",
//                             prefixIcon: const Icon(Icons.person),
//                             border: OutlineInputBorder(
//                               borderRadius: BorderRadius.circular(15),
//                             ),
//                           ),
//                         ),

//                       if (!isLogin) const SizedBox(height: 15),

//                       TextField(
//                         controller: email,
//                         decoration: InputDecoration(
//                           labelText: "Email",
//                           prefixIcon: const Icon(Icons.email),
//                           border: OutlineInputBorder(
//                             borderRadius: BorderRadius.circular(15),
//                           ),
//                         ),
//                       ),

//                       const SizedBox(height: 15),

//                       if (!isLogin)
//                         TextField(
//                           controller: hp,
//                           decoration: InputDecoration(
//                             labelText: "No HP",
//                             prefixIcon: const Icon(Icons.phone),
//                             border: OutlineInputBorder(
//                               borderRadius: BorderRadius.circular(15),
//                             ),
//                           ),
//                         ),

//                       if (!isLogin) const SizedBox(height: 15),

//                       TextField(
//                         controller: password,
//                         obscureText: true,
//                         decoration: InputDecoration(
//                           labelText: "Password",
//                           prefixIcon: const Icon(Icons.lock),
//                           border: OutlineInputBorder(
//                             borderRadius: BorderRadius.circular(15),
//                           ),
//                         ),
//                       ),

//                       const SizedBox(height: 25),

//                       SizedBox(
//                         width: double.infinity,
//                         height: 50,
//                         child: ElevatedButton(
//                           style: ElevatedButton.styleFrom(
//                             backgroundColor: Colors.green,
//                             shape: RoundedRectangleBorder(
//                               borderRadius: BorderRadius.circular(15),
//                             ),
//                           ),
//                           onPressed: () {
//                             isLogin ? login() : register();
//                           },
//                           child: Text(
//                             isLogin ? "LOGIN" : "REGISTER",
//                             style: const TextStyle(fontSize: 18),
//                           ),
//                         ),
//                       ),

//                       const SizedBox(height: 10),

//                       TextButton(
//                         onPressed: togglePage,
//                         child: Text(
//                           isLogin
//                               ? "Belum punya akun? Daftar"
//                               : "Sudah punya akun? Login",
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

