class Prodi {
  final int id;
  final String nama;
  final String createdAt;
  final String? updatedAt;

  Prodi({
    required this.id,
    required this.nama,
    required this.createdAt,
    this.updatedAt,
  });

  factory Prodi.fromJson(Map<String, dynamic> json) {
    return Prodi(
      id: json['id'],
      nama: json['nama'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'] ?? '',
    );
  }
}
