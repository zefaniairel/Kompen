import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobile/screens/ProfilePage.dart';
import 'package:mobile/screens/sdm/AddTaskPage.dart';
import 'package:mobile/screens/sdm/DashboardSDMPage.dart';
import 'package:mobile/screens/sdm/DetailPengajuanPage.dart';
import 'package:mobile/screens/sdm/DetailTaskSDMPage.dart';
import 'package:mobile/screens/sdm/EditTaskPage.dart';
import 'package:mobile/screens/sdm/TasksSdmPage.dart';
import 'package:mobile/screens/sdm/TasksSubmissionsPage.dart';
import 'package:mobile/screens/students/DashboardMHSPage.dart';
import 'package:mobile/screens/students/DetailTaskPage.dart';
import 'package:mobile/screens/LoginPage.dart';
import 'package:mobile/screens/students/RequestTasksPage.dart';
import 'package:mobile/screens/students/TasksPage.dart';
import 'package:mobile/screens/students/CompensationPage.dart';
import 'package:mobile/screens/students/DetailCompensationPage.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'KOMPEN App',
      initialRoute: '/login',
      routes: {
        "/login": (context) => LoginPage(),
        "/profile": (context) => const ProfilePage(),
        "/dashboard-mahasiswa": (context) => const DashboardMHSPage(),
        "/dashboard-sdm": (context) => const DashboardSDMPage(),
        "/tasks": (context) => TasksPage(),
        "/compensations": (context) => CompensationPage(),
        "/tasks-request": (context) => const RequestTasksPage(),
        "/detail-task": (context) => const DetailTaskPage(),
        "/detail-compensation": (context) => const DetailCompensationPage(),
        "/tasks-sdm": (context) => TasksSdmPage(),
        "/add-task": (context) => const AddTaskPage(),
        "/edit-task": (context) => const EditTaskPage(
              initialData: {
                'judul': 'Tugas 1',
                'deskripsi': 'Ini adalah deskripsi tugas pertama.',
                'bobot': 40,
                'semester': 5,
                'kuota': 30,
                'url': 'https://contoh.com/tugas1',
                'jenisTugas': '1',
                'tipeInput': 'file',
                'deadline': '2024-12-31T23:59:59',
              },
            ),
        "/detail-sdm-task": (context) => const DetailTaskSDMPage(
              initialData: {
                'judul': 'Tugas 1',
                'deskripsi': 'Ini adalah deskripsi tugas pertama.',
                'bobot': 40,
                'semester': 5,
                'kuota': 30,
                'url': 'https://contoh.com/tugas1',
                'jenisTugas': '1',
                'tipeInput': 'file',
                'deadline': '2024-12-31T23:59:59',
              },
            ),
        "/tasks-submissions": (context) => const TasksSubmissionsPage(),
        "/detail-pengajuan": (context) => DetailPengajuanPage()
      },
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        textTheme: GoogleFonts.poppinsTextTheme(),
      ),
    );
  }
}
