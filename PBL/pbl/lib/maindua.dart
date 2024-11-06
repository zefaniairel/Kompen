import 'package:flutter/material.dart';

void main() => runApp(const Maindua());

class Maindua extends StatelessWidget {
  const Maindua({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'KOMPEN App',
      home: Scaffold(
        body: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color(0xFF1F2739),
                Color(0xFF2A324B),
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: Stack(
            children: <Widget>[
              // Top Left Curve
              Positioned(
                top: -100,
                left: -100,
                child: Container(
                  width: 250,
                  height: 250,
                  decoration: BoxDecoration(
                    color: const Color(0xFF2A324B),
                    borderRadius: BorderRadius.circular(200),
                  ),
                ),
              ),
              // Bottom Right Curve
              Positioned(
                bottom: -100,
                right: -100,
                child: Container(
                  width: 250,
                  height: 250,
                  decoration: BoxDecoration(
                    color: const Color(0xFF1F2739),
                    borderRadius: BorderRadius.circular(200),
                  ),
                ),
              ),
              // Centered Text and Button
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    const Text(
                      'KOMPEN',
                      style: TextStyle(
                        fontSize: 60,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      'Jurusan Teknologi Informasi',
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.white70,
                      ),
                    ),
                    const SizedBox(height: 30), // Spasi antara teks dan tombol
                    ElevatedButton(
                      onPressed: () {
                        // Tambahkan logika untuk menavigasi ke halaman berikutnya
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color.fromARGB(
                            255, 255, 255, 255), // Warna latar tombol
                        padding: const EdgeInsets.symmetric(
                          horizontal: 32,
                          vertical: 12,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: const Text(
                        'STARTED',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Color.fromARGB(255, 0, 0, 0),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
