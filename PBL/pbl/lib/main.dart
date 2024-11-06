import 'package:flutter/material.dart';
import 'package:pbl/BerandaDosenPage.dart';
import 'package:pbl/ForgotPasswordPage.dart';
import 'package:pbl/ProfileDosenPage.dart';
import 'package:pbl/NotificationScreen.dart';
import 'package:pbl/TambahTugasPage.dart';
import 'package:pbl/changepw.dart';
import 'package:pbl/loginpage.dart';
import 'package:pbl/maindua.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'KOMPEN App',
      initialRoute: '/login', // Mulai dari login
      routes: {
        '/': (context) => const MainScreen(),
        '/login': (context) => const LoginPage(),
        // '/maindua': (context) => const Maindua(),
        '/forgot-password': (context) => const ForgotPasswordPage(),
        '/tambahtugas': (context) => TambahTugasPage(),
        '/beranda': (context) => const MainScreen(), // Panggil MainScreen
        '/profile': (context) => const ProfileDosenPage(),
        '/notifications': (context) => NotificationScreen(),
        '/changepw': (context) => const ChangePw(),
      },
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
    );
  }
}

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;
  final PageController _pageController = PageController();

  final List<Widget> _pages = [
    BerandaDosenPage(),
    NotificationScreen(),
    const ProfileDosenPage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    _pageController.jumpToPage(index); // Menyinkronkan PageView dengan navbar
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _pageController,
        physics:
            const NeverScrollableScrollPhysics(), // Nonaktifkan geser manual
        children: _pages,
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        type: BottomNavigationBarType.fixed,
        onTap: _onItemTapped,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Beranda',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.notifications),
            label: 'Notifikasi',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profil',
          ),
        ],
      ),
    );
  }
}
