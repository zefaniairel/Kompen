class Competence {
  final int id;
  final String nama;
  final String createdAt;
  final String? updatedAt;

  Competence({
    required this.id,
    required this.nama,
    required this.createdAt,
    this.updatedAt,
  });

  factory Competence.fromJson(Map<String, dynamic> json) {
    return Competence(
      id: json['id'],
      nama: json['nama'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'] ?? '',
    );
  }
}
