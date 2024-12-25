class Task {
  final int id;
  final String dosen;
  final String judul;
  final String deskripsi;
  final int bobot;
  final String periode;
  final int semester;
  final String jenis;
  final int idJenis;
  final String? status;
  final String? file;
  final String? url;
  final int? progress;
  final String tipe;
  final String deadline;

  Task({
    required this.id,
    required this.dosen,
    required this.judul,
    required this.deskripsi,
    required this.bobot,
    required this.periode,
    required this.semester,
    required this.jenis,
    required this.idJenis,
    this.status,
    this.file,
    this.url,
    this.progress,
    required this.tipe,
    required this.deadline,
  });

  factory Task.fromJson(Map<String, dynamic> json) {
    return Task(
      id: json['id'] ?? 0,
      dosen: json['dosen'] ?? '',
      judul: json['judul'] ?? '',
      deskripsi: json['deskripsi'] ?? '',
      bobot: json['bobot'] ?? 0,
      periode: json['periode'] ?? '',
      semester: json['semester'] ?? 0,
      jenis: json['jenis'] ?? '',
      idJenis: json['id_jenis'] ?? 0,
      status: json['status'],
      file: json['file'],
      url: json['url'],
      progress: json['progress'],
      tipe: json['tipe'] ?? '',
      deadline: json['deadline'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'dosen': dosen,
      'judul': judul,
      'deskripsi': deskripsi,
      'bobot': bobot,
      'periode': periode,
      'semester': semester,
      'jenis': jenis,
      'id_jenis': idJenis,
      'status': status,
      'file': file,
      'url': url,
      'progress': progress,
      'tipe': tipe,
      'deadline': deadline,
    };
  }
}
