import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobile/models/Compensation.dart';
import 'package:mobile/providers/CompensationProvider.dart';
import 'package:mobile/themes/colors.dart';
import 'package:mobile/themes/typography.dart';
import 'package:url_launcher/url_launcher.dart';

class DetailCompensationPage extends ConsumerWidget {
  const DetailCompensationPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final compensationId = ModalRoute.of(context)?.settings.arguments as int?;

    if (compensationId == null) {
      return Scaffold(
        body: Center(
          child: Text('ID Kompensasi tidak ditemukan'),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: MyColors.accentColor,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          'Detail Compensation',
          style: MyTypography.headline2.copyWith(color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: FutureBuilder<Compensation?>(
        future: ref.read(compensationProvider.notifier).getCompensationById(compensationId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          if (!snapshot.hasData) {
            return Center(child: Text('Data tidak ditemukan'));
          }

          final compensation = snapshot.data!;

          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(16.0),
                    margin: const EdgeInsets.only(bottom: 16.0),
                    decoration: BoxDecoration(
                      color: MyColors.surfaceColor,
                      borderRadius: BorderRadius.circular(8),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.2),
                          spreadRadius: 1,
                          blurRadius: 4,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Dosen: ${compensation.dosen}',
                          style: MyTypography.bodyText1,
                        ),
                        SizedBox(height: 8),
                        Text(
                          'Mahasiswa: ${compensation.mahasiswa}',
                          style: MyTypography.bodyText1,
                        ),
                        SizedBox(height: 8),
                        Text(
                          'Judul Tugas: ${compensation.judulTugas}',
                          style: MyTypography.bodyText1,
                        ),
                        SizedBox(height: 8),
                        Text(
                          'Bobot: ${compensation.bobot}',
                          style: MyTypography.bodyText1,
                        ),
                        SizedBox(height: 8),
                        Text(
                          'Periode: ${compensation.periode}',
                          style: MyTypography.bodyText1,
                        ),
                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap: () async {
                      final fileUrl = compensation.file;
                      final Uri url = Uri.parse(fileUrl);
                      if (await canLaunchUrl(url)) {
                        await launchUrl(url, mode: LaunchMode.externalApplication);
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Could not launch URL')),
                        );
                      }
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
                      decoration: BoxDecoration(
                        color: MyColors.accentColor,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Center(
                        child: Text(
                          'Download File',
                          style: MyTypography.bodyText1.copyWith(color: MyColors.surfaceColor),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
