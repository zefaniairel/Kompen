import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobile/models/Prodi.dart';
import 'package:mobile/utils/dio_client.dart';

class ProdiNotifier extends StateNotifier<List<Prodi>?> {
  ProdiNotifier() : super(null);

  final DioClient dioClient = DioClient();

  Future<void> getProdi() async {
    try {
      final response = await dioClient.dio.get('/prodi');
      
      final data = response.data['data'] as List;
      final prodiList = data.map((prodi) => Prodi.fromJson(prodi)).toList();

      state = prodiList;
    } catch (e) {
      throw Exception('Terjadi kesalahan saat memuat data prodi');
    }
  }
}