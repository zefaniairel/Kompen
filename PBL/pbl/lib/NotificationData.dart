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
  final String taskName; // nama tugas kompen untuk progress
  final int progressNumber; // 1-4 untuk menandai progress ke berapa
  final String progressImage; // untuk menyimpan foto progress
  final int currentProgress; // persentase progress saat ini

  NotificationData({
    required this.title,
    required this.name,
    required this.message,
    this.chatMessage = '',
    this.status = 'pending',
    this.competence = '',
    this.taskDescription = '',
    this.deadline = '',
    this.submittedFile = '',
    this.taskName = '',
    this.progressNumber = 0,
    this.progressImage = '',
    this.currentProgress = 0,
  });
}