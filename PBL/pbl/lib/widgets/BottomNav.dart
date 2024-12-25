import 'package:flutter/material.dart';
import 'package:mobile/themes/colors.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';

class BottomNav extends StatefulWidget {
  final String role;
  final int index;

  const BottomNav({
    Key? key,
    required this.role, required this.index,
  }) : super(key: key);

  @override
  _BottomNavState createState() => _BottomNavState();
}

class _BottomNavState extends State<BottomNav> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    switch (index) {
      case 0:
        Navigator.pushReplacementNamed(
            context,
            widget.role == "mahasiswa"
                ? "/dashboard-mahasiswa"
                : "/dashboard-sdm");
        break;
      case 1:
        Navigator.pushReplacementNamed(
            context, widget.role == "mahasiswa" ? "/tasks" : "/tasks-sdm");
        break;
      case 2:
        Navigator.pushReplacementNamed(
          context,
          widget.role == 'mahasiswa' ? '/compensations' : '/tasks-submissions',
        );
        break;
      case 3:
        Navigator.pushReplacementNamed(context, '/profile');
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    final List<SalomonBottomBarItem> items = (widget.role == 'mahasiswa')
        ? [
            SalomonBottomBarItem(
              icon: Icon(Icons.dashboard),
              title: Text("Dashboard"),
              selectedColor: MyColors.primaryColor,
            ),
            SalomonBottomBarItem(
              icon: Icon(Icons.assignment),
              title: Text("Tugas"),
              selectedColor: MyColors.secondaryColor,
            ),
            SalomonBottomBarItem(
              icon: Icon(Icons.file_copy),
              title: Text("Kompensasi"),
              selectedColor: MyColors.accentColor,
            ),
            SalomonBottomBarItem(
              icon: Icon(Icons.person),
              title: Text("Profile"),
              selectedColor: MyColors.onPrimaryColor,
            ),
          ]
        : [
            SalomonBottomBarItem(
              icon: Icon(Icons.dashboard),
              title: Text("Dashboard"),
              selectedColor: MyColors.primaryColor,
            ),
            SalomonBottomBarItem(
              icon: Icon(Icons.assignment),
              title: Text("Tugas"),
              selectedColor: MyColors.secondaryColor,
            ),
            SalomonBottomBarItem(
              icon: Icon(Icons.file_copy),
              title: Text("Pengajuan"),
              selectedColor: MyColors.accentColor,
            ),
            SalomonBottomBarItem(
              icon: Icon(Icons.person),
              title: Text("Profile"),
              selectedColor: MyColors.onPrimaryColor,
            ),
          ];

    return SalomonBottomBar(
      currentIndex: widget.index,
      onTap: _onItemTapped,
      items: items,
    );
  }
}
