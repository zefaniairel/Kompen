import 'package:flutter/material.dart';
import 'package:pbl/BerandaDosenPage.dart';
import 'package:pbl/NotificationScreen.dart';
import 'package:pbl/ProfileDosenPage.dart';
import 'package:pbl/loginpage.dart';
import 'package:pbl/maindua.dart'; // Import LoginPage
import 'package:pbl/ForgotPasswordPage.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'KOMPENKU',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        fontFamily: 'Poppins',
      ),
      home: const Maindua(), // Set Maindua sebagai halaman pertama
      routes: {
        '/login': (context) => LoginPage(),
        '/main': (context) => MainScreen(),
        '/beranda': (context) => BerandaDosenPage(),
        
        '/password': (context) =>
            ForgotPasswordPage(), // Route ke ForgotPasswordPage
      },
    );
  }
}

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    SafeArea(child: KompenScreen()), // Beranda Dosen
    SafeArea(child: NotificationScreen()),
    SafeArea(child: ProfileDosenPage()),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.notifications_outlined),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            label: '',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
        onTap: _onItemTapped,
      ),
    );
  }
}
