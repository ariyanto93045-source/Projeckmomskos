import 'package:flutter/material.dart';
import 'package:proyekaplikasikoskosan/database_helpermomkos.dart';
import 'package:proyekaplikasikoskosan/modelusermomkos.dart';

class HalamanUtama extends StatefulWidget {
  const HalamanUtama({super.key});

  @override
  State<HalamanUtama> createState() => _HalamanUtamaState();
}

class _HalamanUtamaState extends State<HalamanUtama> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Halaman Utama")),
      body: const Center(child: Text("Selamat Datang")),
    );
  }
}

// ======================
// DASHBOARD PAGE
// ======================

class DashboardPage extends StatelessWidget {
  final String nama;

  const DashboardPage({super.key, required this.nama});

  void tambahPenghuni(BuildContext context) {
    final nama = TextEditingController();
    final kamar = TextEditingController();
    final email = TextEditingController();
    final hp = TextEditingController();
    final password = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Tambah Penghuni"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nama,
                decoration: const InputDecoration(labelText: "Nama"),
              ),
              TextField(
                controller: email,
                decoration: const InputDecoration(labelText: "Email"),
              ),
              TextField(
                controller: hp,
                decoration: const InputDecoration(labelText: "No HP"),
              ),
              TextField(
                controller: password,
                decoration: const InputDecoration(labelText: "Password"),
              ),
              TextField(
                controller: kamar,
                decoration: const InputDecoration(labelText: "No Kamar"),
              ),
            ],
          ),
          actions: [
            ElevatedButton(
              onPressed: () async {
                await DBHelper().registerUser(
                  User(
                    nama: nama.text,
                    email: email.text,
                    hp: hp.text,
                    password: password.text,
                    kamar: kamar.text,
                    role: "user",
                  ),
                );

                Navigator.pop(context);
              },
              child: const Text("Simpan"),
            ),
          ],
        );
      },
    );
  }

  void tampilkanQris(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Pembayaran QRIS"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                "Scan QRIS untuk melakukan pembayaran",
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 15),
              Image.asset(
                "assetimage/qris.png",
                width: 220,
                height: 220,
                fit: BoxFit.contain,
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text("Tutup"),
            ),
          ],
        );
      },
    );
  }

  void tampilkanLaporan(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(20),
          child: FutureBuilder<List<Map<String, dynamic>>>(
            future: DBHelper().getUsers(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return const Center(child: CircularProgressIndicator());
              }

              final users = snapshot.data!;

              if (users.isEmpty) {
                return const Center(child: Text("Belum ada data penghuni"));
              }

              return ListView(
                children: [
                  const Text(
                    "Laporan Pembayaran",
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),

                  const SizedBox(height: 15),

                  ...users.map((user) {
                    return Card(
                      child: ListTile(
                        leading: const Icon(Icons.person, color: Colors.green),
                        title: Text(user['nama'] ?? ""),
                        subtitle: Text(
                          "Kamar : ${user['kamar'] ?? '-'}\nStatus : Belum Membayar",
                        ),
                      ),
                    );
                  }),
                ],
              );
            },
          ),
        );
      },
    );
  }

  void tampilkanPenghuni(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(20),
          child: FutureBuilder<List<Map<String, dynamic>>>(
            future: DBHelper().getUsers(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return const Center(child: CircularProgressIndicator());
              }

              final users = snapshot.data!;

              if (users.isEmpty) {
                return const Center(child: Text("Belum ada data penghuni"));
              }

              return ListView(
                children: [
                  const Text(
                    "Daftar Penghuni",
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),

                  const SizedBox(height: 15),

                  ...users.map((user) {
                    return Card(
                      child: ListTile(
                        leading: CircleAvatar(
                          backgroundColor: Colors.green.shade100,
                          child: Text(
                            user['nama'].toString().isNotEmpty
                                ? user['nama'][0].toUpperCase()
                                : "?",
                          ),
                        ),

                        title: Text(
                          user['nama'] ?? "",
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),

                        subtitle: Text(
                          "Email : ${user['email'] ?? '-'}\n"
                          "No HP : ${user['hp'] ?? '-'}\n"
                          "Kamar : ${user['kamar'] ?? '-'}",
                        ),
                      ),
                    );
                  }),
                ],
              );
            },
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // APP BAR
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: const Text(
          "MY MOM'S KOS",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        iconTheme: const IconThemeData(color: Color.fromARGB(255, 185, 9, 9)),
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 25),
            child: CircleAvatar(
              backgroundImage: AssetImage("assetimage/jempol gambar.png"),
            ),
          ),
        ],
      ),

      // DRAWER
      drawer: Drawer(
        child: ListView(
          children: [
            DrawerHeader(
              decoration: const BoxDecoration(color: Colors.green),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Icon(Icons.home, color: Colors.white, size: 50),
                  SizedBox(height: 10),
                  Text(
                    "MY MOM'S KOS",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            ListTile(
              leading: const Icon(Icons.home),
              title: const Text("Beranda"),
              onTap: () {},
            ),
            ListTile(
              leading: const Icon(Icons.bed),
              title: const Text("Tagihan"),
              onTap: () {},
            ),
            ListTile(
              leading: const Icon(Icons.people),
              title: const Text("Penghuni"),
              onTap: () {},
            ),
            ListTile(
              leading: const Icon(Icons.bar_chart),
              title: const Text("Laporan"),
              onTap: () {},
            ),
          ],
        ),
      ),

      // BODY
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Selamat Datang, $nama",
                style: const TextStyle(
                  fontSize: 34,
                  fontWeight: FontWeight.bold,
                  color: Colors.deepPurple,
                ),
              ),

              const SizedBox(height: 10),

              const Text(
                "Ringkasan Kos Hari ini.",
                style: TextStyle(fontSize: 20, color: Colors.black54),
              ),

              const SizedBox(height: 25),

              //  MEMBUAT KOLOM KAMAR TERISI DAN MENAMPILKAN JUMLAH YANG TERISI
              Row(
                children: [
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: Colors.green.shade100,
                        borderRadius: BorderRadius.circular(15),
                      ),

                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "KAMAR TERISI",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.green,
                            ),
                          ),
                          SizedBox(height: 15),
                          Row(
                            children: [
                              FutureBuilder<List<Map<String, dynamic>>>(
                                future: DBHelper().getUsers(),
                                builder: (context, snapshot) {
                                  if (!snapshot.hasData) {
                                    return const Text(
                                      "0",
                                      style: TextStyle(
                                        fontSize: 40,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    );
                                  }

                                  return Text(
                                    "${snapshot.data!.length}",
                                    style: const TextStyle(
                                      fontSize: 40,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  );
                                },
                              ),

                              const SizedBox(width: 5),

                              const Text(
                                "/ 20",
                                style: TextStyle(fontSize: 20),
                              ),
                            ],
                          ),

                          // Row(
                          //   children: [
                          //     Text(
                          //       "24",
                          //       style: TextStyle(
                          //         fontSize: 40,
                          //         fontWeight: FontWeight.bold,
                          //       ),
                          //     ),
                          //     SizedBox(width: 5),
                          //     Text("/ 30", style: TextStyle(fontSize: 20)),
                          //   ],
                          // ),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(width: 15),

                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: Colors.green.shade100,
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "TOTAL PENGHUNI",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.green,
                            ),
                          ),
                          SizedBox(height: 15),
                          Row(
                            children: [
                              FutureBuilder<List<Map<String, dynamic>>>(
                                future: DBHelper().getUsers(),
                                builder: (context, snapshot) {
                                  if (!snapshot.hasData) {
                                    return const Text(
                                      "0",
                                      style: TextStyle(
                                        fontSize: 40,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    );
                                  }

                                  return Text(
                                    "${snapshot.data!.length}",
                                    style: const TextStyle(
                                      fontSize: 40,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  );
                                },
                              ),

                              const SizedBox(width: 5),

                              const Text(
                                "Orang",
                                style: TextStyle(fontSize: 20),
                              ),
                            ],
                          ),

                          // Row(
                          //   children: [
                          //     Text(
                          //       "32",
                          //       style: TextStyle(
                          //         fontSize: 40,
                          //         fontWeight: FontWeight.bold,
                          //       ),
                          //     ),
                          //     SizedBox(width: 5),
                          //     Text("Orang", style: TextStyle(fontSize: 20)),
                          //   ],
                          // ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 30),

              const Text(
                "AKSI CEPAT",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.black54,
                ),
              ),

              const SizedBox(height: 15),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // TAMBAH PENGHUNI
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        tambahPenghuni(context);
                      },
                      child: Container(
                        padding: const EdgeInsets.all(15),
                        decoration: BoxDecoration(
                          color: Colors.green,
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: const Column(
                          children: [
                            Icon(
                              Icons.person_add_alt_1,
                              color: Colors.white,
                              size: 30,
                            ),
                            SizedBox(height: 10),
                            Text(
                              "Tambah\nPenghuni",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(width: 15),

                  // // TAGIHAN
                  // TAGIHAN
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: const Text("Tagihan Bulanan atau harian"),
                              content: const Text(
                                "Fitur ini digunakan untuk melihat atau membuat tagihan penghuni kos.",
                              ),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: const Text("Tutup"),
                                ),
                              ],
                            );
                          },
                        );
                      },
                      child: Container(
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: Colors.green,
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: const Column(
                          children: [
                            Icon(
                              Icons.receipt_long,
                              color: Colors.white,
                              size: 35,
                            ),
                            SizedBox(height: 10),
                            Text(
                              "Tagihan",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),

                  // Expanded(
                  //   child: Container(
                  //     padding: const EdgeInsets.all(20),
                  //     decoration: BoxDecoration(
                  //       color: Colors.green,
                  //       borderRadius: BorderRadius.circular(15),
                  //     ),
                  //     child: const Column(
                  //       children: [
                  //         Icon(Icons.bed, color: Colors.white, size: 35),
                  //         SizedBox(height: 10),
                  //         Text(
                  //           "Kamar",
                  //           style: TextStyle(color: Colors.white, fontSize: 12),
                  //         ),
                  //       ],
                  //     ),
                  //   ),
                  // ),
                  const SizedBox(width: 15),

                  // PEMBAYARAN
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        tampilkanQris(context);
                      },
                      child: Container(
                        padding: const EdgeInsets.all(19),
                        decoration: BoxDecoration(
                          color: Colors.green,
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: const Column(
                          children: [
                            Icon(
                              Icons.qr_code_2,
                              color: Colors.white,
                              size: 35,
                            ),
                            SizedBox(height: 10),
                            Text(
                              "Pembayaran",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 35),

              //  penghuni terbaru
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "PENGHUNI TERBARU",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black54,
                    ),
                  ),

                  InkWell(
                    onTap: () async {
                      // Ambil semua user dari database
                      final users = await DBHelper().getUsers();

                      // Tampilkan dialog daftar semua penghuni
                      showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: const Text("Daftar Semua Penghuni"),
                            content: SizedBox(
                              width: double.maxFinite,
                              child: ListView.builder(
                                shrinkWrap: true,
                                itemCount: users.length,
                                itemBuilder: (context, index) {
                                  return ListTile(
                                    leading: CircleAvatar(
                                      child: Text(
                                        users[index]['nama']
                                                .toString()
                                                .isNotEmpty
                                            ? users[index]['nama'][0]
                                                  .toUpperCase()
                                            : "?",
                                      ),
                                    ),
                                    title: Text(users[index]['nama']),
                                    subtitle: Text(
                                      "Kamar : ${users[index]['kamar'] ?? '-'}",
                                    ),
                                  );
                                },
                              ),
                            ),
                            actions: [
                              TextButton(
                                onPressed: () => Navigator.pop(context),
                                child: const Text("Tutup"),
                              ),
                            ],
                          );
                        },
                      );
                    },
                    child: const Text(
                      "LIHAT SEMUA",
                      style: TextStyle(
                        color: Colors.deepPurple,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),

              // Row(
              //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //   children: const [
              //     Text(
              //       "PENGHUNI TERBARU",
              //       style: TextStyle(
              //         fontWeight: FontWeight.bold,
              //         color: Colors.black54,
              //       ),
              //     ),
              //     Text(
              //       "LIHAT SEMUA",
              //       style: TextStyle(
              //         color: Colors.deepPurple,
              //         fontWeight: FontWeight.bold,
              //       ),
              //     ),
              //   ],
              // ),

              // const SizedBox(height: 15),
              FutureBuilder<List<Map<String, dynamic>>>(
                future: DBHelper().getUsers(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return const CircularProgressIndicator();
                  }

                  final users = snapshot.data!;

                  return Column(
                    children: users.map((user) {
                      String namaUser = user['nama'] ?? "";
                      String kamarUser = user['kamar'] ?? "_";

                      return Padding(
                        padding: const EdgeInsets.only(bottom: 15),
                        child: Container(
                          padding: const EdgeInsets.all(15),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(15),
                            border: Border.all(color: Colors.black12),
                          ),
                          child: Row(
                            children: [
                              CircleAvatar(
                                radius: 28,
                                backgroundColor: Colors.green.shade100,
                                child: Text(
                                  namaUser.isNotEmpty
                                      ? namaUser[0].toUpperCase()
                                      : "?",
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 22,
                                  ),
                                ),
                              ),

                              const SizedBox(width: 15),

                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      namaUser,
                                      style: const TextStyle(
                                        fontSize: 22,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const SizedBox(height: 5),
                                    Text(
                                      "Kamar : $kamarUser",
                                      style: const TextStyle(
                                        fontSize: 18,
                                        color: Colors.black54,
                                      ),
                                    ),
                                  ],
                                ),
                              ),

                              // ====================
                              // EDIT DAN HAPUS
                              // ====================
                              Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  IconButton(
                                    icon: const Icon(
                                      Icons.edit,
                                      color: Colors.blue,
                                    ),
                                    onPressed: () {
                                      String namaAwal = namaUser;
                                      String kamarAwal = kamarUser == "_"
                                          ? ""
                                          : kamarUser;

                                      final namaController =
                                          TextEditingController(text: namaAwal);
                                      final kamarController =
                                          TextEditingController(
                                            text: kamarAwal,
                                          );

                                      showDialog(
                                        context: context,
                                        builder: (_) => AlertDialog(
                                          title: const Text(
                                            "Edit Data Penghuni",
                                          ),

                                          content: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              TextField(
                                                controller: namaController,
                                                decoration:
                                                    const InputDecoration(
                                                      labelText:
                                                          "Nama Penghuni",
                                                      prefixIcon: Icon(
                                                        Icons.person,
                                                      ),
                                                      border:
                                                          OutlineInputBorder(),
                                                    ),
                                              ),

                                              const SizedBox(height: 15),

                                              TextField(
                                                controller: kamarController,
                                                decoration:
                                                    const InputDecoration(
                                                      labelText: "Nomor Kamar",
                                                      prefixIcon: Icon(
                                                        Icons.bed,
                                                      ),
                                                      border:
                                                          OutlineInputBorder(),
                                                    ),
                                              ),
                                            ],
                                          ),

                                          actions: [
                                            ElevatedButton(
                                              onPressed: () async {
                                                await DBHelper().updateUser({
                                                  "id": user['id'],
                                                  "nama": namaController.text,
                                                  "email": user['email'],
                                                  "hp": user['hp'],
                                                  "password": user['password'],
                                                  "kamar": kamarController.text,
                                                });

                                                Navigator.pop(context);

                                                Navigator.pushReplacement(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) =>
                                                        DashboardPage(
                                                          nama: nama,
                                                        ),
                                                  ),
                                                );
                                              },
                                              child: const Text("Simpan"),
                                            ),
                                          ],
                                        ),
                                      );
                                    },
                                  ),

                                  IconButton(
                                    icon: const Icon(
                                      Icons.delete,
                                      color: Colors.red,
                                    ),
                                    onPressed: () async {
                                      await DBHelper().deleteUser(user['id']);

                                      Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              DashboardPage(nama: nama),
                                        ),
                                      );

                                      if (context.mounted) {
                                        (context as Element).markNeedsBuild();
                                      }
                                    },
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      );

                      // return Padding(
                      //   padding: const EdgeInsets.only(bottom: 15),
                      //   child: penghuniCard(
                      //     huruf: namaUser.isNotEmpty
                      //         ? namaUser[0].toUpperCase()
                      //         : "?",
                      //     nama: namaUser,
                      //     kamar: kamarUser,
                      //     warna: Colors.green.shade100,
                      //   ),
                      // );
                    }).toList(),
                  );
                },
              ),
            ],
          ),
        ),
      ),

      // BOTTOM NAVIGATION DI SINI, BUKAN DI BODY
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Colors.green,
        unselectedItemColor: Colors.green,
        type: BottomNavigationBarType.fixed,

        onTap: (index) {
          if (index == 2) {
            tampilkanPenghuni(context);
          }

          if (index == 3) {
            tampilkanLaporan(context);
          }
        },

        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.dashboard),
            label: "Beranda",
          ),
          BottomNavigationBarItem(icon: Icon(Icons.receipt), label: "Tagihan"),
          BottomNavigationBarItem(icon: Icon(Icons.people), label: "Penghuni"),
          BottomNavigationBarItem(
            icon: Icon(Icons.bar_chart),
            label: "Laporan",
          ),
        ],
      ),
    );
  }

  //  widget penghuni card

  Widget penghuniCard({
    required String huruf,
    required String nama,
    required String kamar,
    required Color warna,
  }) {
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: Colors.black12),
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 28,
            backgroundColor: warna,
            child: Text(
              huruf,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
            ),
          ),

          const SizedBox(width: 15),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  nama,
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  kamar,
                  style: const TextStyle(fontSize: 20, color: Colors.black54),
                ),
              ],
            ),
          ),

          const Icon(Icons.arrow_forward_ios, color: Colors.black45),
        ],
      ),
    );
  }
}




// import 'package:proyekaplikasikoskosan/database_helpermomkos.dart';
// import 'package:proyekaplikasikoskosan/modelusermomkos.dart';

// class HalamanUtama extends StatefulWidget {
//   const HalamanUtama({super.key});

//   @override
//   State<HalamanUtama> createState() => _HalamanUtamaState();
// }

// class _HalamanUtamaState extends State<HalamanUtama> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text("Halaman Utama")),
//       body: const Center(child: Text("Selamat Datang")),
//     );
//   }
// }

// // ======================
// // DASHBOARD PAGE
// // ======================

// class DashboardPage extends StatelessWidget {
//   final String nama;
//   const DashboardPage({super.key, required this.nama});

//   // untuk memanggi tambah penghuni dalam class

//   void tambahPenghuni(BuildContext context) {
//     final nama = TextEditingController();
//     final kamar = TextEditingController();
//     final email = TextEditingController();
//     final hp = TextEditingController();
//     final password = TextEditingController();

//     showDialog(
//       context: context,
//       builder: (context) {
//         return AlertDialog(
//           title: const Text("Tambah Penghuni"),

//           content: Column(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               TextField(
//                 controller: email,
//                 decoration: const InputDecoration(labelText: "Email"),
//               ),

//               TextField(
//                 controller: hp,
//                 decoration: const InputDecoration(labelText: "No hp"),
//               ),
//               TextField(
//                 controller: kamar,
//                 decoration: const InputDecoration(labelText: "No kamar"),
//               ),
//             ],
//           ),

//           actions: [
//             ElevatedButton(
//               onPressed: () async {
//                 await DBHelper().registerUser(
//                   User(
//                     nama: nama.text,
//                     email: email.text,
//                     hp: hp.text,
//                     password: password.text,
//                     kamar: kamar.text,
//                   ),
//                 );

//                 Navigator.pop(context);
//               },
//               child: const Text("Simpan"),
//             ),
//           ],
//         );
//       },
//     );
//   }

//   // void tambahPenghuni(BuildContext context) {
//   //   final nama = TextEditingController();
//   //   final email = TextEditingController();
//   //   final hp = TextEditingController();
//   //   final password = TextEditingController();

//   //   // void tambahPenghuni(BuildContext context) {
//   //   showDialog(
//   //     context: context,
//   //     builder: (context) {
//   //       return AlertDialog(
//   //         title: const Text("Tambah Penghuni"),
//   //         content: Column(
//   //           mainAxisSize: MainAxisSize.min,
//   //           children: [
//   //             TextField(
//   //               controller: nama,
//   //               decoration: const InputDecoration(labelText: "Nama"),
//   //             ),

//   //             TextField(
//   //               controller: email,
//   //               decoration: const InputDecoration(labelText: "Email"),
//   //             ),

//   //             TextField(
//   //               controller: hp,
//   //               decoration: const InputDecoration(labelText: "No HP"),
//   //             ),

//   //             TextField(
//   //               controller: password,
//   //               decoration: const InputDecoration(labelText: "Password"),
//   //             ),
//   //           ],
//   //         ),

//   //         actions: [
//   //           ElevatedButton(
//   //             onPressed: () async {
//   //               User user = User(
//   //                 nama: nama.text,
//   //                 email: email.text,
//   //                 hp: hp.text,
//   //                 password: password.text,
//   //               );

//   //               await DBHelper().registerUser(user);

//   //               Navigator.pop(context);
//   //             },
//   //             child: const Text("Simpan"),
//   //           ),
//   //         ],
//   //       );
//   //     },
//   //   );
//   // }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       // ======================
//       // APP BAR
//       // ======================
//       appBar: AppBar(
//         backgroundColor: Colors.green,

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
//               decoration: const BoxDecoration(color: Colors.green),

//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,

//                 children: const [
//                   Icon(Icons.home, color: Colors.white, size: 50),

//                   SizedBox(height: 10),

//                   Text(
//                     "MY MOM'S KOS",
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
//         bottomNavigationBar: BottomNavigationBar(
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
//                 "Ringkasan Kos Hari ini.",
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
//                     child: InkWell(
//                       onTap: () {
//                         tambahPenghuni(context);
//                       },
//                       child: Container(
//                         padding: const EdgeInsets.all(15),

//                         decoration: BoxDecoration(
//                           color: Colors.deepPurple,
//                           borderRadius: BorderRadius.circular(15),
//                         ),

//                         child: const Column(
//                           children: [
//                             Icon(
//                               Icons.person_add,
//                               color: Colors.white,
//                               size: 20,
//                             ),
//                             SizedBox(height: 10),
//                             Text(
//                               "Tambah\nPenghuni",
//                               textAlign: TextAlign.center,
//                             ),
//                           ],
//                         ),
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
//   child: InkWell(
//     onTap: () {
//       showDialog(
//         context: context,
//         builder: (context) => AlertDialog(
//           title: const Text("Pembayaran QRIS"),
//           content: Column(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               const Text(
//                 "Scan QRIS untuk melakukan pembayaran",
//                 textAlign: TextAlign.center,
//               ),

//               const SizedBox(height: 15),

//               Image.asset(
//                 "assetimage/qris.png",
//                 width: 220,
//                 height: 220,
//                 fit: BoxFit.contain,
//               ),
//             ],
//           ),
//           actions: [
//             TextButton(
//               onPressed: () {
//                 Navigator.pop(context);
//               },
//               child: const Text("Tutup"),
//             ),
//           ],
//         ),
//       );
//     },
//     child: Container(
//       padding: const EdgeInsets.all(15),
//       decoration: BoxDecoration(
//         color: Colors.deepPurple,
//         borderRadius: BorderRadius.circular(15),
//       ),
//       child: const Column(
//         children: [
//           Icon(
//             Icons.payment,
//             color: Colors.white,
//             size: 35,
//           ),

//           SizedBox(height: 10),

//           Text(
//             "Pembayaran",
//             textAlign: TextAlign.center,
//             style: TextStyle(
//               color: Colors.white,
//               fontSize: 15,
//             ),
//           ),
//         ],
//       ),
//     ),
//   ),
// ),
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
//               // ====================
//               FutureBuilder<List<Map<String, dynamic>>>(
//                 future: DBHelper().getUsers(),
//                 builder: (context, snapshot) {
//                   if (!snapshot.hasData) {
//                     return const CircularProgressIndicator();
//                   }

//                   final users = snapshot.data!;

//                   return Column(
//                     children: users.map((user) {
//                       String nama = user['nama'] ?? "";

//                       return Padding(
//                         padding: const EdgeInsets.only(bottom: 15),
//                         child: penghuniCard(
//                           huruf: nama.isNotEmpty ? nama[0].toUpperCase() : "?",
//                           nama: nama,
//                           kamar: user['kamar'] ?? "_",
//                           warna: Colors.green.shade100,
//                         ),
//                       );
//                     }).toList(),
//                   );
//                 },
//               ),
//               //
//               //
//               //
//               //
//               //              // penghuniCard(
//               //   huruf: "B",
//               //   nama: "Budi Santoso",
//               //   kamar: "Room 102",
//               //   warna: Colors.deepPurple.shade100,
//               // ),

//               // const SizedBox(height: 15),

//               // penghuniCard(
//               //   huruf: "A",
//               //   nama: "Ani Wijaya",
//               //   kamar: "Room 205",
//               //   warna: Colors.green.shade200,
//               // ),

//               // const SizedBox(height: 15),

//               // penghuniCard(
//               //   huruf: "C",
//               //   nama: "Citra Lestari",
//               //   kamar: "Room 108",
//               //   warna: Colors.orange.shade100,
//               // ),
//             ],
//           ),
//             ],
//       ),
//     )
      
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
