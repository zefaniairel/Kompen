import 'package:flutter/material.dart';
import 'package:mobile/themes/colors.dart';
import 'package:mobile/themes/typography.dart';
import 'package:mobile/widgets/BottomNav.dart';

class TasksSubmissionsPage extends StatelessWidget {
  const TasksSubmissionsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: MyColors.accentColor,
        centerTitle: true,
        title: Text(
          'Daftar Pengajuan',
          style: MyTypography.headline2.copyWith(color: Colors.white),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
        child: ListView.builder(
          itemCount: 10, // Simulasi 10 data
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, '/detail-pengajuan',
                      arguments: 1);
              },
              child: Container(
                margin: const EdgeInsets.only(bottom: 8),
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: MyColors.accentColor,
                  borderRadius: BorderRadius.circular(8),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 4,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Nama Tugas ${index + 1}',
                      style:
                          MyTypography.headline3.copyWith(color: Colors.white),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Icon(Icons.person, color: Colors.white, size: 16),
                        const SizedBox(width: 8),
                        Text(
                          'Nama Mahasiswa ${index + 1}',
                          style: MyTypography.bodyText2
                              .copyWith(color: Colors.white),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
      bottomNavigationBar: BottomNav(role: 'sdm', index: 2),
    );
  }
}
