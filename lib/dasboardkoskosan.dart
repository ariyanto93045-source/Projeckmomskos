import 'package:flutter/material.dart';
import 'package:proyekaplikasikoskosan/database_helpermomkos.dart';

class DashboardPage extends StatefulWidget {
  final String nama;

  const DashboardPage({super.key, required this.nama});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  Future<List<Map<String, dynamic>>> getUsers() {
    return DBHelper().getUsers();
  }

  List<Map<String, String>> penghuniBaru = [];

  void showEditDialog(Map<String, dynamic> user) {
    final nama = TextEditingController(text: user['nama']);
    final email = TextEditingController(text: user['email']);
    final hp = TextEditingController(text: user['hp']);
    final password = TextEditingController(text: user['password']);

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Edit Data Penghuni"),
          content: SingleChildScrollView(
            child: Column(
              children: [
                TextField(controller: nama),
                TextField(controller: email),
                TextField(controller: hp),
                TextField(controller: password),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Batal"),
            ),

            ElevatedButton(
              onPressed: () async {
                await DBHelper().updateUser({
                  "id": user['id'],
                  "nama": nama.text,
                  "email": email.text,
                  "hp": hp.text,
                  "password": password.text,
                });
                Navigator.pop(context);
                setState(() {});
              },

              child: const Text("Simpan"),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Dashboard")),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: getUsers(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }

          final users = snapshot.data!;
          return ListView.builder(
            itemCount: users.length,
            itemBuilder: (context, index) {
              final user = users[index];

              String namaUser = user['nama']?.toString() ?? "";

              return Card(
                margin: const EdgeInsets.all(8),
                child: ListTile(
                  leading: CircleAvatar(
                    child: Text(
                      namaUser.isNotEmpty ? namaUser[0].toUpperCase() : "?",
                    ),
                  ),

                  title: Text(user['nama'] ?? ""),
                  subtitle: Text(user['email'] ?? ""),

                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.edit, color: Colors.blue),
                        onPressed: () {
                          showEditDialog(user);
                        },
                      ),
                      IconButton(
                        icon: const Icon(Icons.delete, color: Colors.red),
                        onPressed: () async {
                          await DBHelper().deleteUser(user['id']);
                          setState(() {});
                        },
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

// // ======================
// // DASHBOARD PAGE
// // ======================

// class DashboardPage extends StatelessWidget {
//   final String nama;
//   const DashboardPage({super.key, required this.nama});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       // ======================
//       // APP BAR
//       // ======================
//       appBar: AppBar(
//         backgroundColor: Colors.deepPurple,

//         title: const Text(
//           "MY MOM'S KOS",
//           style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
//         ),

//         iconTheme: const IconThemeData(color: Color.fromARGB(255, 185, 9, 9)),

//         actions: const [
//           Padding(
//             padding: EdgeInsets.only(right: 25),

//             child: CircleAvatar(
//               backgroundImage: AssetImage("assetimage/jempol gambar.png"),
//             ),
//           ),
//         ],
//       ),

//       // ======================
//       // DRAWER
//       // ======================
//       drawer: Drawer(
//         child: ListView(
//           children: [
//             DrawerHeader(
//               decoration: const BoxDecoration(color: Colors.deepPurple),

//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,

//                 children: const [
//                   Icon(Icons.home, color: Colors.white, size: 50),

//                   SizedBox(height: 10),

//                   Text(
//                     "KOSKU APP",
//                     style: TextStyle(
//                       color: Colors.white,
//                       fontSize: 25,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                 ],
//               ),
//             ),

//             ListTile(
//               leading: const Icon(Icons.home),
//               title: const Text("Beranda"),
//               onTap: () {},
//             ),

//             ListTile(
//               leading: const Icon(Icons.bed),
//               title: const Text("Kamar"),
//               onTap: () {},
//             ),

//             ListTile(
//               leading: const Icon(Icons.people),
//               title: const Text("Penghuni"),
//               onTap: () {},
//             ),

//             ListTile(
//               leading: const Icon(Icons.bar_chart),
//               title: const Text("Laporan"),
//               onTap: () {},
//             ),
//           ],
//         ),
//       ),

//       // ======================
//       // BODY
//       // ======================
//       body: SingleChildScrollView(
//         child: Padding(
//           padding: const EdgeInsets.all(20),

//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,

//             children: [
//               // ======================
//               // TEXT WELCOME
//               // ======================
//               Text(
//                 "Selamat Datang, $nama",
//                 style: const TextStyle(
//                   fontSize: 34,
//                   fontWeight: FontWeight.bold,
//                   color: Colors.deepPurple,
//                 ),
//               ),

//               const SizedBox(height: 10),

//               const Text(
//                 "Berikut adalah ringkasan operasional kos hari ini.",
//                 style: TextStyle(fontSize: 20, color: Colors.black54),
//               ),

//               const SizedBox(height: 25),

//               // ======================
//               // CARD
//               // ======================
//               Row(
//                 children: [
//                   // CARD 1
//                   Expanded(
//                     child: Container(
//                       padding: const EdgeInsets.all(20),

//                       decoration: BoxDecoration(
//                         color: Colors.green.shade100,
//                         borderRadius: BorderRadius.circular(15),
//                       ),

//                       child: const Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,

//                         children: [
//                           Text(
//                             "KAMAR TERISI",
//                             style: TextStyle(
//                               fontWeight: FontWeight.bold,
//                               color: Colors.green,
//                             ),
//                           ),

//                           SizedBox(height: 15),

//                           Row(
//                             children: [
//                               Text(
//                                 "24",
//                                 style: TextStyle(
//                                   fontSize: 40,
//                                   fontWeight: FontWeight.bold,
//                                 ),
//                               ),

//                               SizedBox(width: 5),

//                               Text("/ 30", style: TextStyle(fontSize: 20)),
//                             ],
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),

//                   const SizedBox(width: 15),

//                   // CARD 2
//                   Expanded(
//                     child: Container(
//                       padding: const EdgeInsets.all(20),

//                       decoration: BoxDecoration(
//                         color: Colors.green.shade100,
//                         borderRadius: BorderRadius.circular(15),
//                       ),

//                       child: const Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,

//                         children: [
//                           Text(
//                             "TOTAL PENGHUNI",
//                             style: TextStyle(
//                               fontWeight: FontWeight.bold,
//                               color: Colors.green,
//                             ),
//                           ),

//                           SizedBox(height: 15),

//                           Row(
//                             children: [
//                               Text(
//                                 "32",
//                                 style: TextStyle(
//                                   fontSize: 40,
//                                   fontWeight: FontWeight.bold,
//                                 ),
//                               ),

//                               SizedBox(width: 5),

//                               Text("Orang", style: TextStyle(fontSize: 20)),
//                             ],
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                 ],
//               ),

//               const SizedBox(height: 30),

//               // ======================
//               // AKSI CEPAT
//               // ======================
//               const Text(
//                 "AKSI CEPAT",
//                 style: TextStyle(
//                   fontWeight: FontWeight.bold,
//                   color: Colors.black54,
//                 ),
//               ),

//               const SizedBox(height: 15),

//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,

//                 children: [
//                   // BUTTON 1
//                   Expanded(
//                     child: Container(
//                       padding: const EdgeInsets.all(15),

//                       decoration: BoxDecoration(
//                         color: Colors.deepPurple,
//                         borderRadius: BorderRadius.circular(15),
//                       ),

//                       child: const Column(
//                         children: [
//                           Icon(Icons.person_add, color: Colors.white, size: 20),

//                           SizedBox(height: 10),

//                           Text(
//                             "Tambah\nPenghuni",
//                             textAlign: TextAlign.center,

//                             style: TextStyle(color: Colors.white, fontSize: 15),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),

//                   const SizedBox(width: 15),

//                   // BUTTON 2
//                   Expanded(
//                     child: Container(
//                       padding: const EdgeInsets.all(15),

//                       decoration: BoxDecoration(
//                         border: Border.all(color: Colors.green, width: 2),

//                         borderRadius: BorderRadius.circular(15),
//                       ),

//                       child: const Column(
//                         children: [
//                           Icon(Icons.bed, color: Colors.green, size: 35),

//                           SizedBox(height: 10),

//                           Text(
//                             "Kamar",
//                             style: TextStyle(color: Colors.green, fontSize: 18),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),

//                   const SizedBox(width: 15),

//                   // BUTTON 3
//                   Expanded(
//                     child: Container(
//                       padding: const EdgeInsets.all(15),

//                       decoration: BoxDecoration(
//                         color: Colors.deepPurple,
//                         borderRadius: BorderRadius.circular(15),
//                       ),

//                       child: const Column(
//                         children: [
//                           Icon(Icons.payment, color: Colors.white, size: 35),

//                           SizedBox(height: 10),

//                           Text(
//                             "Pembayaran",
//                             textAlign: TextAlign.center,

//                             style: TextStyle(color: Colors.white, fontSize: 15),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                 ],
//               ),

//               const SizedBox(height: 35),

//               // ======================
//               // PENGHUNI TERBARU
//               // ======================
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,

//                 children: const [
//                   Text(
//                     "PENGHUNI TERBARU",
//                     style: TextStyle(
//                       fontWeight: FontWeight.bold,
//                       color: Colors.black54,
//                     ),
//                   ),

//                   Text(
//                     "LIHAT SEMUA",
//                     style: TextStyle(
//                       color: Colors.deepPurple,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                 ],
//               ),

//               const SizedBox(height: 15),

//               // ======================
//               // LIST PENGHUNI
//               // ======================
//               penghuniCard(
//                 huruf: "B",
//                 nama: "Budi Santoso",
//                 kamar: "Room 102",
//                 warna: Colors.deepPurple.shade100,
//               ),

//               const SizedBox(height: 15),

//               penghuniCard(
//                 huruf: "A",
//                 nama: "Ani Wijaya",
//                 kamar: "Room 205",
//                 warna: Colors.green.shade200,
//               ),

//               const SizedBox(height: 15),

//               penghuniCard(
//                 huruf: "C",
//                 nama: "Citra Lestari",
//                 kamar: "Room 108",
//                 warna: Colors.orange.shade100,
//               ),
//             ],
//           ),
//         ),
//       ),

//       // ======================
//       // BOTTOM NAVIGATION
//       // ======================
//       bottomNavigationBar: BottomNavigationBar(
//         selectedItemColor: Colors.green,

//         items: const [
//           BottomNavigationBarItem(
//             icon: Icon(Icons.dashboard),
//             label: "Beranda",
//           ),

//           BottomNavigationBarItem(icon: Icon(Icons.bed), label: "Kamar"),

//           BottomNavigationBarItem(icon: Icon(Icons.people), label: "Penghuni"),

//           BottomNavigationBarItem(
//             icon: Icon(Icons.bar_chart),
//             label: "Laporan",
//           ),
//         ],
//       ),
//     );
//   }

//   // ======================
//   // WIDGET CARD PENGHUNI
//   // ======================

//   Widget penghuniCard({
//     required String huruf,
//     required String nama,
//     required String kamar,
//     required Color warna,
//   }) {
//     return Container(
//       padding: const EdgeInsets.all(15),

//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(15),

//         border: Border.all(color: Colors.black12),
//       ),

//       child: Row(
//         children: [
//           CircleAvatar(
//             radius: 28,
//             backgroundColor: warna,

//             child: Text(
//               huruf,
//               style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
//             ),
//           ),

//           const SizedBox(width: 15),

//           Expanded(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,

//               children: [
//                 Text(
//                   nama,
//                   style: const TextStyle(
//                     fontSize: 22,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),

//                 const SizedBox(height: 5),

//                 Text(
//                   kamar,
//                   style: const TextStyle(fontSize: 20, color: Colors.black54),
//                 ),
//               ],
//             ),
//           ),

//           const Icon(Icons.arrow_forward_ios, color: Colors.black45),
//         ],
//       ),
//     );
//   }
// }
