class Compensation {
  final int id;
  final String dosen;
  final String mahasiswa;
  final String judulTugas;
  final int bobot;
  final int? periode;
  final String file;

  Compensation({
    required this.id,
    required this.dosen,
    required this.mahasiswa,
    required this.judulTugas,
    required this.bobot,
    this.periode,
    required this.file,
  });

  factory Compensation.fromJson(Map<String, dynamic> json) {
    return Compensation(
      id: json['id'] as int,
      dosen: json['dosen'] as String,
      mahasiswa: json['mahasiswa'] as String,
      judulTugas: json['judul_tugas'] as String,
      bobot: json['bobot'] as int,
      periode: json['periode'] ?? 0,
      file: json['file'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'dosen': dosen,
      'mahasiswa': mahasiswa,
      'judul_tugas': judulTugas,
      'bobot': bobot,
      'periode': periode,
      'file': file,
    };
  }
}
