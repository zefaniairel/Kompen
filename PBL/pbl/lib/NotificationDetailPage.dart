import 'package:flutter/material.dart';
import 'package:pbl/NotificationScreen.dart';

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
              // Menggunakan Table untuk menampilkan detail
              Table(
                border: TableBorder.all(
                  color: const Color.fromARGB(255, 10, 7, 7),
                  width: 1,
                  borderRadius: BorderRadius.circular(8),
                ),
                children: [
                  _buildTableRow('Nama', notification.name),
                  _buildTableRow('Pesan', notification.message),
                  _buildTableRow('Kompetensi', notification.competence),
                  _buildTableRow('Chat', notification.chatMessage),
                  if (notification.competence.isNotEmpty)
                    _buildTableRow('Kompetensi', notification.competence),
                  if (notification.taskDescription.isNotEmpty)
                    _buildTableRow(
                        'Deskripsi Tugas', notification.taskDescription),
                  if (notification.deadline.isNotEmpty)
                    _buildTableRow('Deadline', notification.deadline),
                  if (notification.submittedFile.isNotEmpty)
                    _buildTableRow(
                        'Tugas yang Dikirim', notification.submittedFile),
                ],
              ),
              const SizedBox(height: 20),
              Text(
                'Status: ${notification.status}',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _buildActionButton(
                    context,
                    'Terima',
                    Colors.green,
                    () {
                      _showConfirmationDialog(
                        context,
                        'Anda menerima notifikasi ini.',
                        () {
                          onUpdateStatus(notification, 'accepted');
                          Navigator.popUntil(context, (route) => route.isFirst);
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
                        'Anda menolak notifikasi ini.',
                        () {
                          onUpdateStatus(notification, 'rejected');
                          Navigator.popUntil(context, (route) => route.isFirst);
                        },
                      );
                    },
                  ),
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
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(12.0),
          child: Text(
            content,
            style: TextStyle(fontSize: 16),
          ),
        ),
      ],
    );
  }

  ElevatedButton _buildActionButton(
      BuildContext context, String label, Color color, VoidCallback onPressed) {
    return ElevatedButton(
      onPressed: onPressed,
      child: Text(label),
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        textStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
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
          title: Text('Konfirmasi'),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Batal'),
            ),
            TextButton(
              onPressed: onConfirm,
              child: Text('Konfirmasi'),
            ),
          ],
        );
      },
    );
  }
}
