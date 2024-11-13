import 'package:flutter/material.dart';

void main() => runApp(const Mainsatu());

class Mainsatu extends StatelessWidget {
  const Mainsatu({super.key}); // Perbaiki di sini

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'KOMPENKU',
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
              // Centered Text
              const Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      'KOMPEN',
                      style: TextStyle(
                        fontSize: 60,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      'Jurusan Teknologi Informasi',
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.white70,
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
