import 'package:flutter/material.dart';
import 'package:pbl/BerandaDosenPage.dart';
import 'package:pbl/NotificationScreen.dart';
import 'package:pbl/changepw.dart';

class ProfileDosenPage extends StatefulWidget {
  const ProfileDosenPage({Key? key}) : super(key: key);

  @override
  _ProfileDosenPageState createState() => _ProfileDosenPageState();
}

class _ProfileDosenPageState extends State<ProfileDosenPage> {
  int _currentIndex = 2;
  final PageController _pageController = PageController(initialPage: 2);

  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          title: const Text('Konfirmasi'),
          content: const Text('Apakah Anda yakin ingin keluar?'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Tidak'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.pushReplacementNamed(context, '/login');
              },
              child: const Text('Ya'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _pageController,
        onPageChanged: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        children: [
          BerandaDosenPage(),
          NotificationScreen(),
          _buildProfileScreen(),
        ],
      ),
    );
  }

  Widget _buildProfileScreen() {
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 40),
            Stack(
              alignment: Alignment.center,
              children: [
                // Garis gelombang di belakang foto profil
                Container(
                  width: 150,
                  height: 150,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: LinearGradient(
                      colors: [
                        Colors.blue.shade100,
                        Colors.blue.shade300,
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.2),
                        blurRadius: 8,
                        offset: Offset(0, 4),
                      ),
                    ],
                  ),
                ),
                CircleAvatar(
                  radius: 60,
                  backgroundColor: Colors.grey.shade300,
                  backgroundImage: const AssetImage('assets/fotoprofil.PNG'),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 8,
                    offset: Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    decoration: BoxDecoration(
                      color: Colors.indigo.shade700,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Center(
                      child: Text(
                        'Hendra Pradibta, S.E., M.Sc.',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    decoration: BoxDecoration(
                      color: Colors.indigo.shade700,
                      border: Border.all(color: Colors.indigo.shade700),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Center(
                      child: Text(
                        '224176011711',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  TextButton(
                    onPressed: () async {
                      // Navigasi ke halaman Change Password
                      final result = await Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const ChangePw()),
                      );

                      // Jika result tidak null, artinya ada perubahan (misal: password diubah)
                      if (result != null && result) {
                        setState(() {
                          // Update UI atau data yang perlu diperbarui
                          // Misalnya, bisa mengambil data profil terbaru
                        });
                      }
                    },
                    child: const Text(
                      'Change Password',
                      style: TextStyle(
                        color: Colors.grey,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                _showLogoutDialog(context);
              },
              style: ElevatedButton.styleFrom(
                padding:
                    const EdgeInsets.symmetric(horizontal: 40, vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: const Text(
                'LOG OUT',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
