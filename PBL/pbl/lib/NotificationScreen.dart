import 'package:flutter/material.dart';
import 'NotificationDetailPage.dart';

class NotificationData {
  final String title;
  final String name;
  final String message;
  final String chatMessage;
  String status; // "pending", "accepted", "rejected"
  final String competence; // untuk pengajuan
  final String taskDescription; // untuk pengumpulan
  final String deadline; // untuk pengumpulan
  final String submittedFile; // untuk pengumpulan

  NotificationData({
    required this.title,
    required this.name,
    required this.message,
    required this.chatMessage,
    this.status = 'pending',
    this.competence = '', // default
    this.taskDescription = '', // default
    this.deadline = '', // default
    this.submittedFile = '', // default
  });
}

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({Key? key}) : super(key: key);

  @override
  _NotificationScreenState createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  List<NotificationData> pengajuanNotifications = [
    NotificationData(
      title: 'Pengajuan Kompen',
      name: 'Irwil',
      message: 'Mengajukan tugas kompen!',
      chatMessage: 'Chat box: saya req tanggal 5',
      competence: '',
    ),
    NotificationData(
      title: 'Pengajuan Kompen',
      name: 'Liri',
      message: 'Mengajukan tugas kompen!',
      chatMessage: 'Chat box: - ',
      competence: '',
    ),
    NotificationData(
      title: 'Pengajuan Kompen',
      name: 'Bela',
      message: 'Mengajukan tugas kompen!',
      chatMessage: 'Chat box: Saya suka tugas ini',
      competence: 'saya bisa excel',
    ),
    // Tambahkan pengajuan lain jika perlu
  ];

  List<NotificationData> pengumpulanNotifications = [
    NotificationData(
      title: 'Pengumpulan Tugas',
      name: 'Dita Karang',
      message: 'Mengumpulkan tugas!',
      chatMessage: 'Chat box: saya sudah mengerjakan tugas',
      taskDescription: 'Deskripsi tugas A',
      deadline: 'Tanggal 10',
      submittedFile: 'TugasSatu.pdf',
    ),
    NotificationData(
      title: 'Pengumpulan Tugas',
      name: 'Jefri N',
      message: 'Mengumpulkan tugas!',
      chatMessage: 'Chat box: saya sudah mengerjakan tugas',
      taskDescription: 'Deskripsi tugas A',
      deadline: 'Tanggal 10',
      submittedFile: 'PengumpulanTugas.excel',
    ),
    // Tambahkan pengumpulan lain jika perlu
  ];

  void _updateNotificationStatus(
      NotificationData notification, String newStatus) {
    setState(() {
      notification.status = newStatus;
      // Hapus notifikasi setelah status diperbarui
      if (newStatus == 'accepted' || newStatus == 'rejected') {
        if (pengajuanNotifications.contains(notification)) {
          pengajuanNotifications.remove(notification);
        } else {
          pengumpulanNotifications.remove(notification);
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Notifikasi'),
          bottom: const TabBar(
            tabs: [
              Tab(text: 'Pengajuan'),
              Tab(text: 'Pengumpulan'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            // Tab untuk Pengajuan
            ListView.builder(
              itemCount: pengajuanNotifications.length,
              itemBuilder: (context, index) {
                final notification = pengajuanNotifications[index];
                return _buildNotificationCard(
                  context: context,
                  notification: notification,
                );
              },
            ),
            // Tab untuk Pengumpulan
            ListView.builder(
              itemCount: pengumpulanNotifications.length,
              itemBuilder: (context, index) {
                final notification = pengumpulanNotifications[index];
                return _buildNotificationCard(
                  context: context,
                  notification: notification,
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNotificationCard({
    required BuildContext context,
    required NotificationData notification,
  }) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => NotificationDetailPage(
              notification: notification,
              onUpdateStatus: _updateNotificationStatus,
            ),
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        decoration: BoxDecoration(
          color: const Color.fromARGB(255, 152, 152, 225),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.grey.shade300, width: 1),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 6,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          notification.title,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          notification.name,
                          style: const TextStyle(
                            fontSize: 16,
                            color: Colors.black54,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Text(
                notification.message,
                style: const TextStyle(
                  fontSize: 14,
                  color: Colors.black,
                ),
              ),
              if (notification.chatMessage.isNotEmpty) ...[
                const SizedBox(height: 4),
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.8),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.grey.shade200, width: 1),
                  ),
                  child: Text(
                    notification.chatMessage,
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.black54,
                    ),
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
