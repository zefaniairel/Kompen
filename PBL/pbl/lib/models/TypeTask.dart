class TypeTask {
  final int id;
  final String nama;
  final String createdAt;
  final String? updatedAt;

  TypeTask({
    required this.id,
    required this.nama,
    required this.createdAt,
    this.updatedAt,
  });

  factory TypeTask.fromJson(Map<String, dynamic> json) {
    return TypeTask(
      id: json['id'],
      nama: json['nama'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'] ?? '',
    );
  }
}
