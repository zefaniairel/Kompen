import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobile/models/Competence.dart';
import 'package:mobile/utils/dio_client.dart';

class CompetenceNotifier extends StateNotifier<List<Competence>?> {
  CompetenceNotifier() : super(null);

  final DioClient dioClient = DioClient();

  Future<void> getCompetences() async {
    try {
      final response = await dioClient.dio.get('/competences');
      
      final data = response.data['data'] as List;
      final competences = data.map((competence) => Competence.fromJson(competence)).toList();

      state = competences;
    } catch (e) {
      throw Exception('Terjadi kesalahan saat memuat data kompetensi');
    }
  }
}