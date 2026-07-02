import 'dart:async';

import 'package:flutter/material.dart';
import 'package:proyekaplikasikoskosan/proyekaplikasikoskosan.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  String greeting = "";

  void getGreeting() {
    final hour = DateTime.now().hour;

    if (hour >= 5 && hour < 12) {
      greeting = "☀️ Selamat Pagi";
    } else if (hour >= 12 && hour < 18) {
      greeting = "🌤️ Selamat Siang";
    } else {
      greeting = "🌙 Selamat Malam";
    }
  }

  @override
  void initState() {
    super.initState();

    getGreeting();

    Timer(const Duration(seconds: 7), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const Tugas6()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF0F9D58), Color(0xFF1B5E20)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(25),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Image(
                  image: AssetImage("assetimage/Logo Moms Kos Green.png"),
                  width: 130,
                  height: 130,
                ),

                const SizedBox(height: 20),

                // SALAM OTOMATIS
                Text(
                  greeting,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),

                const SizedBox(height: 10),

                const Text(
                  "Usaha Lancar, Tempat Tinggal Nyaman",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 18,
                    fontStyle: FontStyle.italic,
                    color: Colors.white,
                  ),
                ),

                const SizedBox(height: 15),

                const Text(
                  "By Ariyanto",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 14,
                    fontStyle: FontStyle.italic,
                    color: Colors.white,
                  ),
                ),

                const SizedBox(height: 40),

                TweenAnimationBuilder<double>(
                  tween: Tween<double>(begin: 0, end: 1),
                  duration: const Duration(seconds: 2),
                  builder: (context, value, child) {
                    return Transform.rotate(angle: value * 6.28, child: child);
                  },
                  onEnd: () {
                    setState(() {});
                  },
                  child: const Icon(
                    Icons.directions_bike,
                    color: Colors.white,
                    size: 45,
                  ),
                ),

                const SizedBox(height: 30),

                const CircularProgressIndicator(color: Colors.white),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// import 'dart:async';

// import 'package:flutter/material.dart';
// import 'package:proyekaplikasikoskosan/proyekaplikasikoskosan.dart';

// class SplashScreen extends StatefulWidget {
//   const SplashScreen({super.key});

//   @override
//   State<SplashScreen> createState() => _SplashScreenState();
// }

// class _SplashScreenState extends State<SplashScreen> {
//   @override
//   void initState() {
//     super.initState();

//     Timer(const Duration(seconds: 5), () {
//       Navigator.pushReplacement(
//         context,
//         MaterialPageRoute(builder: (_) => const Tugas6()),
//       );
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.deepPurple,
//       body: Center(
//         child: Padding(
//           padding: const EdgeInsets.all(25),

//           //  LOGO KOS KOSAN
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               Image(
//                 image: AssetImage("assetimage/Logo Moms Kos.png"),
//                 width: 130,
//                 height: 130,
//               ),
//               const SizedBox(height: 20),

//               // SELAMAT DATANG
//               const Text(
//                 "Selamat Datang",
//                 textAlign: TextAlign.center,
//                 style: TextStyle(
//                   fontSize: 30,
//                   fontWeight: FontWeight.bold,
//                   color: Colors.white,
//                 ),
//               ),

//               //  JARGON
//               const SizedBox(height: 10),
//               const Text(
//                 "Usaha Lancar, Tempat Tinggal Nyaman",
//                 textAlign: TextAlign.center,
//                 style: TextStyle(
//                   fontSize: 18,
//                   fontStyle: FontStyle.italic,
//                   color: Colors.white,
//                 ),
//               ),

//               //  DIBUAT OLEH
//               const SizedBox(height: 15),
//               const Text(
//                 "By Ariyanto",
//                 textAlign: TextAlign.center,
//                 style: TextStyle(
//                   fontSize: 14,
//                   fontStyle: FontStyle.italic,
//                   color: Colors.white,
//                 ),
//               ),

//               const SizedBox(height: 40),

//               //  gambar sepeda muter muter
//               TweenAnimationBuilder<double>(
//                 tween: Tween<double>(begin: 0, end: 1),
//                 duration: const Duration(seconds: 2),
//                 builder: (context, value, child) {
//                   return Transform.rotate(angle: value * 6.28, child: child);
//                 },
//                 onEnd: () {
//                   setState(() {});
//                 },
//                 child: const Icon(
//                   Icons.directions_bike,
//                   color: Colors.white,
//                   size: 45,
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
