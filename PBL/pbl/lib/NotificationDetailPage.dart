import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart' as launcher;
import 'package:path/path.dart' as path;
import 'NotificationData.dart';

class NotificationDetailPage extends StatelessWidget {
  final NotificationData notification;
  final Function(NotificationData, String) onUpdateStatus;

  const NotificationDetailPage({
    Key? key,
    required this.notification,
    required this.onUpdateStatus,
  }) : super(key: key);

  IconData _getFileIcon(String fileName) {
    String extension = path.extension(fileName).toLowerCase();
    switch (extension) {
      case '.pdf':
        return Icons.picture_as_pdf;
      case '.doc':
      case '.docx':
        return Icons.description;
      case '.xls':
      case '.xlsx':
        return Icons.table_chart;
      case '.jpg':
      case '.jpeg':
      case '.png':
        return Icons.image;
      default:
        return Icons.insert_drive_file;
    }
  }

  void _handleFileAction(BuildContext context, String fileName) {
    if (fileName.isEmpty) return;

    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (BuildContext bc) {
        return Container(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text(
                'File: $fileName',
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),
              ListTile(
                leading: const Icon(Icons.remove_red_eye),
                title: const Text('Preview File'),
                onTap: () {
                  Navigator.pop(context);
                  _previewFile(context, fileName);
                },
              ),
              ListTile(
                leading: const Icon(Icons.download),
                title: const Text('Download File'),
                onTap: () {
                  Navigator.pop(context);
                  _downloadFile(context, fileName);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  Future<void> _previewFile(BuildContext context, String fileName) async {
    String previewUrl = "https://your-server.com/preview/$fileName";
    final Uri url = Uri.parse(previewUrl);

    try {
      if (await launcher.canLaunchUrl(url)) {
        await launcher.launchUrl(url,
            mode: launcher.LaunchMode.externalApplication);
      } else {
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
                content: Text('Tidak dapat membuka file'),
                backgroundColor: Colors.red),
          );
        }
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              content: Text('Error: ${e.toString()}'),
              backgroundColor: Colors.red),
        );
      }
    }
  }

  Future<void> _downloadFile(BuildContext context, String fileName) async {
    String downloadUrl = "https://your-server.com/download/$fileName";
    final Uri url = Uri.parse(downloadUrl);

    try {
      if (await launcher.canLaunchUrl(url)) {
        await launcher.launchUrl(url,
            mode: launcher.LaunchMode.externalApplication);
      } else {
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
                content: Text('Tidak dapat mengunduh file'),
                backgroundColor: Colors.red),
          );
        }
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              content: Text('Error: ${e.toString()}'),
              backgroundColor: Colors.red),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(notification.title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Table(
                border: TableBorder.all(
                  color: const Color.fromARGB(255, 10, 7, 7),
                  width: 1,
                  borderRadius: BorderRadius.circular(8),
                ),
                children: [
                  _buildTableRow('Nama', notification.name),
                  if (notification.title == 'Progress Tugas') ...[
                    _buildTableRow('Nama Tugas', notification.taskName),
                    _buildTableRow(
                        'Progress ke-', notification.progressNumber.toString()),
                    _buildTableRow('Progress Saat Ini',
                        '${notification.currentProgress}%'),
                    _buildTableRow(
                        'Deskripsi Tugas', notification.taskDescription),
                    if (notification.progressImage.isNotEmpty)
                      TableRow(
                        children: [
                          const Padding(
                            padding: EdgeInsets.all(12.0),
                            child: Text(
                              'Foto Progress',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 16),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Container(
                              height: 200,
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: const Center(
                                child: Icon(Icons.image,
                                    size: 50, color: Colors.grey),
                              ),
                            ),
                          ),
                        ],
                      ),
                  ] else if (notification.title == 'Pengajuan Kompen') ...[
                    _buildTableRow('Pesan', notification.message),
                    if (notification.chatMessage.isNotEmpty)
                      _buildTableRow('Chat', notification.chatMessage),
                    if (notification.competence.isNotEmpty)
                      _buildTableRow('Kompetensi', notification.competence),
                  ] else if (notification.title == 'Pengumpulan Tugas') ...[
                    _buildTableRow('Pesan', notification.message),
                    if (notification.chatMessage.isNotEmpty)
                      _buildTableRow('Chat', notification.chatMessage),
                    if (notification.taskDescription.isNotEmpty)
                      _buildTableRow(
                          'Deskripsi Tugas', notification.taskDescription),
                    if (notification.deadline.isNotEmpty)
                      _buildTableRow('Deadline', notification.deadline),
                    if (notification.submittedFile.isNotEmpty)
                      TableRow(
                        children: [
                          const Padding(
                            padding: EdgeInsets.all(12.0),
                            child: Text(
                              'Tugas yang Dikirim',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 16),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: InkWell(
                              onTap: () => _handleFileAction(
                                  context, notification.submittedFile),
                              child: Row(
                                children: [
                                  Icon(_getFileIcon(notification.submittedFile),
                                      color: Colors.blue),
                                  const SizedBox(width: 8),
                                  Expanded(
                                    child: Text(
                                      notification.submittedFile,
                                      style: const TextStyle(
                                        fontSize: 16,
                                        color: Colors.blue,
                                        decoration: TextDecoration.underline,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                  ],
                ],
              ),
              if (notification.title == 'Progress Tugas') ...[
                const SizedBox(height: 20),
                const Text(
                  'Progress Overview:',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                LinearProgressIndicator(
                  value: notification.currentProgress / 100,
                  backgroundColor: Colors.grey[300],
                  valueColor: const AlwaysStoppedAnimation<Color>(Colors.blue),
                  minHeight: 20,
                ),
                const SizedBox(height: 5),
                Text(
                  '${notification.currentProgress}% Completed',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue,
                  ),
                ),
              ],
              const SizedBox(height: 20),
              Text(
                'Status: ${notification.status}',
                style:
                    const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  if (notification.title != 'Progress Tugas' ||
                      (notification.title == 'Progress Tugas' &&
                          notification.status == 'pending')) ...[
                    _buildActionButton(
                      context,
                      'Terima',
                      Colors.green,
                      () {
                        _showConfirmationDialog(
                          context,
                          notification.title == 'Progress Tugas'
                              ? 'Anda menerima progress ini. Progress akan bertambah 25%.'
                              : 'Anda menerima notifikasi ini.',
                          () {
                            onUpdateStatus(notification, 'accepted');
                          },
                        );
                      },
                    ),
                    _buildActionButton(
                      context,
                      'Tolak',
                      const Color.fromARGB(255, 251, 87, 76),
                      () {
                        _showConfirmationDialog(
                          context,
                          notification.title == 'Progress Tugas'
                              ? 'Anda menolak progress ini. Mahasiswa perlu memperbaiki dan mengirim ulang.'
                              : 'Anda menolak notifikasi ini.',
                          () {
                            onUpdateStatus(notification, 'rejected');
                          },
                        );
                      },
                    ),
                  ] else if (notification.title == 'Progress Tugas') ...[
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: notification.status == 'accepted'
                              ? Colors.green.shade100
                              : Colors.red.shade100,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          notification.status == 'accepted'
                              ? 'Progress ini telah diterima'
                              : 'Progress ini telah ditolak',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: notification.status == 'accepted'
                                ? Colors.green
                                : Colors.red,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  TableRow _buildTableRow(String title, String content) {
    return TableRow(
      children: [
        Padding(
          padding: const EdgeInsets.all(12.0),
          child: Text(
            title,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(12.0),
          child: Text(
            content,
            style: const TextStyle(fontSize: 16),
          ),
        ),
      ],
    );
  }

  ElevatedButton _buildActionButton(
      BuildContext context, String label, Color color, VoidCallback onPressed) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      child: Text(label),
    );
  }

  void _showConfirmationDialog(
    BuildContext context,
    String message,
    VoidCallback onConfirm,
  ) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Konfirmasi'),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Batal'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                onConfirm();
              },
              child: const Text('Konfirmasi'),
            ),
          ],
        );
      },
    );
  }
}
