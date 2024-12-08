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
                  TableRow(
                    children: [
                      const Padding(
                        padding: EdgeInsets.all(12.0),
                        child: Text(
                          'Bukti Progress',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16
                          ),
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
                          child: notification.progressImage.isNotEmpty
                              ? Image.network(
                                  notification.progressImage,
                                  fit: BoxFit.cover,
                                )
                              : const Center(
                                  child: Icon(Icons.image,
                                      size: 50, color: Colors.grey),
                                ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
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
              const SizedBox(height: 20),
              Text(
                'Status: ${notification.status}',
                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  if (notification.status == 'pending') ...[
                    _buildActionButton(
                      context,
                      'Terima',
                      Colors.green,
                      () {
                        _showConfirmationDialog(
                          context,
                          'Anda menerima progress ini. Progress akan bertambah 50%.',
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
                          'Anda menolak progress ini. Mahasiswa perlu memperbaiki dan mengirim ulang.',
                          () {
                            onUpdateStatus(notification, 'rejected');
                          },
                        );
                      },
                    ),
                  ] else ...[
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