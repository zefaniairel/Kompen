import 'package:flutter/material.dart';
import 'package:mobile/themes/colors.dart';
import 'package:mobile/themes/typography.dart';
import 'package:mobile/widgets/BottomNav.dart';

class TasksSdmPage extends StatelessWidget {
  TasksSdmPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: MyColors.accentColor,
        centerTitle: true,
        title: Text('Daftar Tugas',
            style: MyTypography.headline2.copyWith(color: Colors.white)),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
        child: ListView.builder(
          itemCount: 10,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, '/detail-sdm-task',
                      arguments: 1);
              },
              child: Container(
                margin: EdgeInsets.only(bottom: 8),
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: MyColors.accentColor,
                  borderRadius: BorderRadius.circular(8),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 4,
                      offset: Offset(0, 2),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: MyColors.primaryColor,
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        'Mata Kuliah',
                        style:
                            MyTypography.caption.copyWith(color: Colors.white),
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      'Tugas 1 Nih',
                      style:
                          MyTypography.headline3.copyWith(color: Colors.white),
                    ),
                    SizedBox(height: 8),
                    Text(
                      '07:30 12 Desember 2024',
                      style:
                          MyTypography.bodyText1.copyWith(color: Colors.white),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
      bottomNavigationBar: BottomNav(role: 'sdm', index: 1),
    );
  }
}
