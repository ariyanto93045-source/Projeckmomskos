import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

// ======================
// MAIN APP
// ======================

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: const DashboardPage());
  }
}

// ======================
// DASHBOARD PAGE
// ======================

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // ======================
      // APP BAR
      // ======================
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,

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

      // ======================
      // DRAWER
      // ======================
      drawer: Drawer(
        child: ListView(
          children: [
            DrawerHeader(
              decoration: const BoxDecoration(color: Colors.deepPurple),

              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,

                children: const [
                  Icon(Icons.home, color: Colors.white, size: 50),

                  SizedBox(height: 10),

                  Text(
                    "KOSKU APP",
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
              title: const Text("Kamar"),
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

      // ======================
      // BODY
      // ======================
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),

          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,

            children: [
              // ======================
              // TEXT WELCOME
              // ======================
              const Text(
                "Selamat Datang, Admin!",
                style: TextStyle(
                  fontSize: 34,
                  fontWeight: FontWeight.bold,
                  color: Colors.deepPurple,
                ),
              ),

              const SizedBox(height: 10),

              const Text(
                "Berikut adalah ringkasan operasional kos hari ini.",
                style: TextStyle(fontSize: 20, color: Colors.black54),
              ),

              const SizedBox(height: 25),

              // ======================
              // CARD
              // ======================
              Row(
                children: [
                  // CARD 1
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.all(20),

                      decoration: BoxDecoration(
                        color: Colors.green.shade100,
                        borderRadius: BorderRadius.circular(15),
                      ),

                      child: const Column(
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
                              Text(
                                "24",
                                style: TextStyle(
                                  fontSize: 40,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),

                              SizedBox(width: 5),

                              Text("/ 30", style: TextStyle(fontSize: 20)),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(width: 15),

                  // CARD 2
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.all(20),

                      decoration: BoxDecoration(
                        color: Colors.green.shade100,
                        borderRadius: BorderRadius.circular(15),
                      ),

                      child: const Column(
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
                              Text(
                                "32",
                                style: TextStyle(
                                  fontSize: 40,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),

                              SizedBox(width: 5),

                              Text("Orang", style: TextStyle(fontSize: 20)),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 30),

              // ======================
              // AKSI CEPAT
              // ======================
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
                  // BUTTON 1
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.all(15),

                      decoration: BoxDecoration(
                        color: Colors.deepPurple,
                        borderRadius: BorderRadius.circular(15),
                      ),

                      child: const Column(
                        children: [
                          Icon(Icons.person_add, color: Colors.white, size: 35),

                          SizedBox(height: 10),

                          Text(
                            "Tambah\nPenghuni",
                            textAlign: TextAlign.center,

                            style: TextStyle(color: Colors.white, fontSize: 18),
                          ),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(width: 15),

                  // BUTTON 2
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.all(15),

                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.green, width: 2),

                        borderRadius: BorderRadius.circular(15),
                      ),

                      child: const Column(
                        children: [
                          Icon(Icons.bed, color: Colors.green, size: 35),

                          SizedBox(height: 10),

                          Text(
                            "Kamar",
                            style: TextStyle(color: Colors.green, fontSize: 18),
                          ),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(width: 15),

                  // BUTTON 3
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.all(15),

                      decoration: BoxDecoration(
                        color: Colors.deepPurple,
                        borderRadius: BorderRadius.circular(15),
                      ),

                      child: const Column(
                        children: [
                          Icon(Icons.payment, color: Colors.white, size: 35),

                          SizedBox(height: 10),

                          Text(
                            "Pembayaran",
                            textAlign: TextAlign.center,

                            style: TextStyle(color: Colors.white, fontSize: 18),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 35),

              // ======================
              // PENGHUNI TERBARU
              // ======================
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,

                children: const [
                  Text(
                    "PENGHUNI TERBARU",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black54,
                    ),
                  ),

                  Text(
                    "LIHAT SEMUA",
                    style: TextStyle(
                      color: Colors.deepPurple,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 15),

              // ======================
              // LIST PENGHUNI
              // ======================
              penghuniCard(
                huruf: "B",
                nama: "Budi Santoso",
                kamar: "Room 102",
                warna: Colors.deepPurple.shade100,
              ),

              const SizedBox(height: 15),

              penghuniCard(
                huruf: "A",
                nama: "Ani Wijaya",
                kamar: "Room 205",
                warna: Colors.green.shade200,
              ),

              const SizedBox(height: 15),

              penghuniCard(
                huruf: "C",
                nama: "Citra Lestari",
                kamar: "Room 108",
                warna: Colors.orange.shade100,
              ),
            ],
          ),
        ),
      ),

      // ======================
      // BOTTOM NAVIGATION
      // ======================
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Colors.green,

        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.dashboard),
            label: "Beranda",
          ),

          BottomNavigationBarItem(icon: Icon(Icons.bed), label: "Kamar"),

          BottomNavigationBarItem(icon: Icon(Icons.people), label: "Penghuni"),

          BottomNavigationBarItem(
            icon: Icon(Icons.bar_chart),
            label: "Laporan",
          ),
        ],
      ),
    );
  }

  // ======================
  // WIDGET CARD PENGHUNI
  // ======================

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
