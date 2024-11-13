// Task class dan TaskCard class tetap sama seperti sebelumnya
class Task {
  final String title;
  final String description;
  final String firstDeadline;
  final String lastDeadline;
  final String progress;
  final int jumlahMahasiswa;
  final int nilaiJam;
  final String tagKompetensi;
  final String namaKompen;
  final String? fileName;
  final bool isOpen; // Tambahkan field baru

  Task({
    required this.title,
    required this.description,
    required this.firstDeadline,
    required this.lastDeadline,
    required this.progress,
    required this.jumlahMahasiswa,
    required this.nilaiJam,
    required this.tagKompetensi,
    required this.namaKompen,
    this.fileName,
    this.isOpen = true, // Default value true (terbuka)
  });
}
