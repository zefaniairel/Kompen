class Dashboard {
  final int totalTasks;
  final int totalRequests;
  final int totalCompensations;
  final int totalSubmissions;
  final List<Progress> progress;

  Dashboard({
    required this.totalTasks,
    required this.totalRequests,
    required this.totalCompensations,
    required this.totalSubmissions,
    required this.progress,
  });

  factory Dashboard.fromJson(Map<String, dynamic> json) {
    var progressList = json['progress'] as List? ?? [];
    List<Progress> progress = progressList
        .map((progressJson) => Progress.fromJson(progressJson))
        .toList();

    return Dashboard(
      totalTasks: json['total_tasks'] ?? 0,
      totalRequests: json['total_requests'] ?? 0,
      totalCompensations: json['total_compensations'] ?? 0,
      totalSubmissions: json['total_submissions'] ?? 0,
      progress: progress,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'total_tasks': totalTasks,
      'total_requests': totalRequests,
      'total_compensations': totalCompensations,
      'total_submissions': totalSubmissions,
      'progress': progress.map((item) => item.toJson()).toList(),
    };
  }
}

class Progress {
  final int id;
  final String judul;
  final String dosen;
  final String? status;
  final int? progress;
  final String tipe;
  final String? file;
  final String? url;

  Progress({
    required this.id,
    required this.judul,
    required this.dosen,
    this.status,
    this.progress,
    required this.tipe,
    this.file,
    this.url,
  });

  factory Progress.fromJson(Map<String, dynamic> json) {
    return Progress(
      id: json['id'] ?? 0,
      judul: json['judul'] ?? '',
      dosen: json['dosen'] ?? '',
      status: json['status'],
      progress: json['progress'],
      tipe: json['tipe'] ?? '',
      file: json['file'],
      url: json['url'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'judul': judul,
      'dosen': dosen,
      'status': status,
      'progress': progress,
      'tipe': tipe,
      'file': file,
      'url': url,
    };
  }
}
