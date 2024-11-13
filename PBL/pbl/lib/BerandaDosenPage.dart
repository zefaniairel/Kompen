import 'Task.dart';
import 'package:pbl/widgets/task_card.dart';
import 'package:flutter/material.dart';
import 'package:pbl/EditTaskPage.dart';
import 'package:pbl/TambahTugasPage.dart';

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
      // Set BerandaDosenPage sebagai home
      home: BerandaDosenPage(),
    );
  }
}

class BerandaDosenPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return KompenScreen();
  }
}

class KompenScreen extends StatefulWidget {
  @override
  _KompenScreenState createState() => _KompenScreenState();
}

class _KompenScreenState extends State<KompenScreen> {
  List<Task> tasks = [
    Task(
      title: 'Jenis Tugas : Penelitian',
      description: 'Kompen Praktikum',
      firstDeadline: '22/10/2024',
      lastDeadline: '23/10/2024',
      progress: '1/2',
      jumlahMahasiswa: 2,
      nilaiJam: 0,
      tagKompetensi: '',
      namaKompen: '',
      isOpen: true,
    ),
    Task(
      title: 'Jenis Tugas : Teknis',
      description: 'Tugas fotocopy 100 lembar',
      firstDeadline: '12/10/2024',
      lastDeadline: '12/10/2024',
      progress: '0/2',
      jumlahMahasiswa: 2,
      nilaiJam: 0,
      tagKompetensi: '',
      namaKompen: '',
      isOpen: false,
    ),
    Task(
      title: 'Jenis Tugas : Pengabdian',
      description: 'Panitia seminar nasional',
      firstDeadline: '15/10/2024',
      lastDeadline: '15/10/2024',
      progress: '0/1',
      jumlahMahasiswa: 1,
      nilaiJam: 0,
      tagKompetensi: '',
      namaKompen: '',
      isOpen: false,
    ),
  ];

  void addTask(Task task) {
    setState(() {
      tasks.add(task);
    });
  }

  void editTask(int index, Task updatedTask) {
    setState(() {
      tasks[index] = updatedTask;
    });
  }

  void deleteTask(int index) {
    setState(() {
      tasks.removeAt(index);
    });
  }

  Future<void> _showTaskOptions(BuildContext context, int index) async {
    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Opsi Tugas'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: Icon(Icons.edit),
                title: Text('Edit'),
                onTap: () async {
                  Navigator.pop(context); // Tutup dialog
                  final editedTask = await Navigator.push<Task>(
                    context,
                    MaterialPageRoute(
                      builder: (context) => EditTaskPage(task: tasks[index]),
                    ),
                  );
                  if (editedTask != null) {
                    editTask(index, editedTask);
                  }
                },
              ),
              ListTile(
                leading: Icon(Icons.delete),
                title: Text('Hapus'),
                onTap: () {
                  Navigator.pop(context);
                  _showDeleteConfirmation(context, index);
                },
              ),
            ],
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Batal'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> _showDeleteConfirmation(BuildContext context, int index) async {
    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Konfirmasi Hapus'),
          content: Text('Apakah Anda yakin ingin menghapus tugas ini?'),
          actions: <Widget>[
            TextButton(
              child: Text('Batal'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Hapus'),
              onPressed: () {
                deleteTask(index);
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Row(
          children: [
            Container(
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.blue.shade100,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(
                Icons.school,
                color: Colors.blue.shade900,
              ),
            ),
            SizedBox(width: 12),
            Text(
              'KOMPEN',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 30,
                color: Colors.black,
              ),
            ),
          ],
        ),
        backgroundColor: const Color.fromARGB(255, 255, 255, 255),
        elevation: 0,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFFB0B0E3), Color(0xFF9090D0)],
          ),
        ),
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Daftar Tugas',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Row(
                      children: [
                        Icon(Icons.assignment, color: Colors.white, size: 16),
                        SizedBox(width: 4),
                        Text(
                          '${tasks.length} Tugas',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView.builder(
                padding: EdgeInsets.symmetric(horizontal: 16),
                itemCount: tasks.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: EdgeInsets.only(bottom: 12),
                    child: TaskCard(
                      task: tasks[index],
                      onTap: () => _showTaskOptions(context, index),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 8,
              offset: Offset(0, 4),
            ),
          ],
          gradient: LinearGradient(
            colors: [Color(0xFFFFEAA4), Color(0xFFFFD74A)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(16),
        ),
        child: FloatingActionButton(
          onPressed: () async {
            final result = await Navigator.push<Task>(
              context,
              MaterialPageRoute(
                builder: (context) => TambahTugasPage(),
              ),
            );
            if (result != null) {
              addTask(result);
            }
          },
          backgroundColor: Colors.transparent,
          elevation: 0,
          child: Icon(Icons.add, color: Colors.black87),
        ),
        // ),
      ),
    );
  }
}
