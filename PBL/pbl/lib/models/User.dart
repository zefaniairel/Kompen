class User {
  final int id;
  final String username;
  final String nama;
  final String role;
  final String? fotoProfile;
  final int? semester;
  final int? idKompetensi;
  final int? idProdi;
  final int? alfa;
  final int? compensation;

  User({
    required this.id,
    required this.username,
    required this.nama,
    required this.role,
    this.fotoProfile,
    this.semester,
    this.idKompetensi,
    this.idProdi,
    this.alfa,
    this.compensation,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      username: json['username'],
      nama: json['nama'],
      role: json['role'],
      fotoProfile: json['foto_profile'],
      semester: json['semester'],
      idKompetensi: json['id_kompetensi'],
      idProdi: json['id_prodi'],
      alfa: json['alfa'],
      compensation: json['compensation'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'username': username,
      'nama': nama,
      'role': role,
      'foto_profile': fotoProfile,
      'semester': semester,
      'id_kompetensi': idKompetensi,
      'id_prodi': idProdi,
      'alfa': alfa,
      'compensation': compensation,
    };
  }
}
