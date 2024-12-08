import 'package:flutter/material.dart';
import 'package:pbl/NotificationDetailPage.dart';
import 'NotificationData.dart';

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
      chatMessage: 'saya req tanggal 5',
      competence: '',
    ),
    NotificationData(
      title: 'Pengajuan Kompen',
      name: 'Liri',
      message: 'Mengajukan tugas kompen!',
      chatMessage: ' - ',
      competence: 'Saya ahli dalam bidang excel, saya juga bisa coding 24/7',
    ),
    NotificationData(
      title: 'Pengajuan Kompen',
      name: 'Bela',
      message: 'Mengajukan tugas kompen!',
      chatMessage: 'Saya berharap dapat diterima untuk mendapatkan tugas kompen ini',
      competence: 'saya bisa excel',
    ),
  ];

  List<NotificationData> pengumpulanNotifications = [
    NotificationData(
      title: 'Pengumpulan Tugas',
      name: 'Dita Karang',
      message: 'Mengumpulkan tugas!',
      chatMessage: 'saya sudah mengerjakan tugas',
      taskDescription: 'Deskripsi tugas A',
      deadline: 'Tanggal 10',
      submittedFile: 'TugasSatu.pdf',
    ),
    NotificationData(
      title: 'Pengumpulan Tugas',
      name: 'Jefri N',
      message: 'Mengumpulkan tugas!',
      chatMessage: 'saya sudah mengerjakan tugas',
      taskDescription: 'Deskripsi tugas A',
      deadline: 'Tanggal 10',
      submittedFile: 'PengumpulanTugas.excel',
    ),
  ];

  List<NotificationData> progressNotifications = [
    NotificationData(
      title: 'Progress Tugas',
      name: 'Jaehyun Kim',
      message: 'Mengirim progress tugas ke-1',
      progressNumber: 1,
      progressImage: 'progress1.jpg',
      currentProgress: 0,
    ),
    NotificationData(
      title: 'Progress Tugas',
      name: 'Yeonjun',
      message: 'Mengirim progress tugas ke-2',
      progressNumber: 2,
      progressImage: 'progress2.jpg',
      currentProgress: 50,
    ),
  ];

  void _updateNotificationStatus(NotificationData notification, String newStatus) {
    setState(() {
      notification.status = newStatus;

      // Khusus untuk progress notification
      if (notification.title == 'Progress Tugas' && newStatus == 'accepted') {
        // Hitung progress baru (50% untuk setiap progress yang diterima)
        int newProgress = notification.currentProgress + 50;

        // Update progress di list
        int index = progressNotifications.indexOf(notification);
        if (index != -1) {
          progressNotifications[index] = NotificationData(
            title: notification.title,
            name: notification.name,
            message: notification.message,
            status: newStatus,
            progressNumber: notification.progressNumber,
            progressImage: notification.progressImage,
            currentProgress: newProgress,
          );
        }
      }

      // Hanya hapus notifikasi untuk pengajuan dan pengumpulan
      if (newStatus == 'accepted' || newStatus == 'rejected') {
        if (pengajuanNotifications.contains(notification)) {
          pengajuanNotifications.remove(notification);
          Navigator.of(context).pop();
        } else if (pengumpulanNotifications.contains(notification)) {
          pengumpulanNotifications.remove(notification);
          Navigator.of(context).pop();
        } else if (notification.title == 'Progress Tugas') {
          // Untuk progress, hanya kembali ke halaman sebelumnya tanpa menghapus notifikasi
          Navigator.of(context).pop();
          // Tampilkan snackbar untuk memberi tahu status
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                newStatus == 'accepted' 
                  ? 'Progress diterima! Progress saat ini: ${notification.currentProgress + 50}%'
                  : 'Progress ditolak. Silakan perbaiki dan kirim ulang.',
              ),
              backgroundColor: newStatus == 'accepted' ? Colors.green : Colors.red,
            ),
          );
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: const Text('Notifikasi'),
          bottom: const TabBar(
            tabs: [
              Tab(text: 'Pengajuan'),
              Tab(text: 'Progress'),
              Tab(text: 'Pengumpulan'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
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
            ListView.builder(
              itemCount: progressNotifications.length,
              itemBuilder: (context, index) {
                final notification = progressNotifications[index];
                return _buildProgressCard(
                  context: context,
                  notification: notification,
                );
              },
            ),
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

  Widget _buildProgressCard({
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
          color: Colors.blue.shade50,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.blue.shade200, width: 1),
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
                          notification.name,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.blueAccent,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Column(
                    children: [
                      Icon(
                        notification.status == 'pending'
                            ? Icons.access_time
                            : notification.status == 'accepted'
                                ? Icons.check_circle
                                : Icons.cancel,
                        color: notification.status == 'pending'
                            ? Colors.orange
                            : notification.status == 'accepted'
                                ? Colors.green
                                : Colors.red,
                      ),
                      Text(
                        '${notification.currentProgress}%',
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.blue,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 8),
              if (notification.progressImage.isNotEmpty) ...[
                Container(
                  height: 100,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey.shade300),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Center(
                    child: Icon(
                      Icons.image,
                      size: 50,
                      color: Colors.grey,
                    ),
                  ),
                ),
              ],
              const SizedBox(height: 8),
              LinearProgressIndicator(
                value: notification.currentProgress / 100,
                backgroundColor: Colors.grey[300],
                valueColor: const AlwaysStoppedAnimation<Color>(Colors.blue),
                minHeight: 10,
              ),
            ],
          ),
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
          color: Colors.blue.shade50,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.blue.shade200, width: 1),
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
                            color: Colors.blueAccent,
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
                  Icon(
                    notification.status == 'pending'
                        ? Icons.access_time
                        : notification.status == 'accepted'
                            ? Icons.check_circle
                            : Icons.cancel,
                    color: notification.status == 'pending'
                        ? Colors.orange
                        : notification.status == 'accepted'
                            ? Colors.green
                            : Colors.red,
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Text(
                notification.message,
                style: const TextStyle(
                  fontSize: 14,
                  color: Colors.black87,
                ),
              ),
              if (notification.chatMessage.isNotEmpty) ...[
                const SizedBox(height: 8),
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.8),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.grey.shade200, width: 1),
                  ),
                  child: Text(
                    notification.chatMessage,
                    style: const TextStyle(
                      fontSize: 12,
                      color: Colors.black54,
                    ),
                  ),
                ),
              ],
              if (notification.competence.isNotEmpty) ...[
                const SizedBox(height: 8),
                Text(
                  'Kompetensi: ${notification.competence}',
                  style: const TextStyle(
                    fontSize: 12,
                    color: Colors.blueGrey,
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