import 'package:flutter/material.dart';
import 'package:mobile/themes/colors.dart';
import 'package:mobile/themes/typography.dart';

class DetailTaskSDMPage extends StatelessWidget {
  final Map<String, dynamic> initialData;

  const DetailTaskSDMPage({Key? key, required this.initialData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: MyColors.accentColor,
        centerTitle: true,
        title: Text(
          'Detail Tugas',
          style: MyTypography.headline2.copyWith(color: Colors.white),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              // Card Detail Task
              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                elevation: 4,
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildDetailRow('Judul Tugas', initialData['judul'] ?? 'N/A'),
                      _buildDetailRow('Deskripsi Tugas', initialData['deskripsi'] ?? 'N/A'),
                      _buildDetailRow('Bobot', initialData['bobot']?.toString() ?? '0'),
                      _buildDetailRow('Semester', initialData['semester']?.toString() ?? 'N/A'),
                      _buildDetailRow('Kuota', initialData['kuota']?.toString() ?? 'N/A'),
                      _buildDetailRow('URL', initialData['url'] ?? 'N/A'),
                      _buildDetailRow('Jenis Tugas', _getJenisTugasName(initialData['jenisTugas'])),
                      _buildDetailRow('Tipe Input', initialData['tipeInput'] ?? 'N/A'),
                      _buildDetailRow('Deadline', initialData['deadline'] ?? 'N/A'),
                    ],
                  ),
                ),
              ),

              // Space between cards
              const SizedBox(height: 16),
              Text(
                'Daftar Mahasiswa yang Mengajukan',
                textAlign: TextAlign.left,
                style: MyTypography.headline3,
              ),
              const SizedBox(height: 16),

              // Card for Data Requests
              ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: 5, // Hardcoded for now, should be dynamic based on your data
                itemBuilder: (context, index) {
                  return Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    elevation: 4,
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Nama Mahasiswa ${index + 1}',
                            style: MyTypography.bodyText2.copyWith(fontWeight: FontWeight.bold),
                          ),
                          Text(
                            'Kompetensi: Coding Python',
                            style: MyTypography.bodyText2.copyWith(color: Colors.grey[800]),
                          ),
                          const SizedBox(height: 16),
                          Row(
                            children: [
                              Expanded(
                                child: GestureDetector(
                                  onTap: () {
                                    // Action for Terima
                                  },
                                  child: Container(
                                    padding: EdgeInsets.symmetric(vertical: 14),
                                    decoration: BoxDecoration(
                                      color: Colors.green,
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: Center(
                                      child: Text(
                                        'Terima',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 8),
                              Expanded(
                                child: GestureDetector(
                                  onTap: () {
                                    // Action for Tolak
                                  },
                                  child: Container(
                                    padding: EdgeInsets.symmetric(vertical: 14),
                                    decoration: BoxDecoration(
                                      color: Colors.red,
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: Center(
                                      child: Text(
                                        'Tolak',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Text(
            '$label: ',
            style: MyTypography.bodyText2.copyWith(fontWeight: FontWeight.bold),
          ),
          Expanded(
            child: Text(
              value,
              style: MyTypography.bodyText2.copyWith(color: Colors.grey[800]),
            ),
          ),
        ],
      ),
    );
  }

  String _getJenisTugasName(String? id) {
    switch (id) {
      case '1':
        return 'Halo';
      case '2':
        return 'Project';
      case '3':
        return 'Ujian';
      default:
        return 'N/A';
    }
  }
}