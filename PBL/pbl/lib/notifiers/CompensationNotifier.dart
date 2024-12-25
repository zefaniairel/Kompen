import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobile/models/Compensation.dart';
import 'package:mobile/utils/dio_client.dart';

class CompensationNotifier extends StateNotifier<List<Compensation>> {
  CompensationNotifier() : super([]);

  final DioClient dioClient = DioClient();

  Future<void> getCompensations() async {
    try {
      final response = await dioClient.dio.get('/compensations');
      final data = response.data['data'] as List<dynamic>;
      final compensations = data
          .map<Compensation>((json) => Compensation.fromJson(json))
          .toList();
      state = compensations;
    } catch (e) {
      throw Exception('Terjadi kesalahan saat memuat data kompensasi');
    }
  }

  Future<Compensation?> getCompensationById(int id) async {
    try {
      final response = await dioClient.dio.get('/compensations/$id');
      final data = response.data['data'];
      print(data);
      return Compensation.fromJson(data);
    } catch (e) {
      print(e);
      throw Exception(
          'Terjadi kesalahan saat memuat data kompensasi dengan ID $id');
    }
  }
}
