import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobile/models/TypeTask.dart';
import 'package:mobile/utils/dio_client.dart';

class TypeTaskNotifier extends StateNotifier<List<TypeTask>?> {
  TypeTaskNotifier() : super(null);

  final DioClient dioClient = DioClient();

  Future<void> getTypeTasks() async {
    try {
      final response = await dioClient.dio.get('/type-tasks');

      final data = response.data['data'] as List;
      final typeTaskList =
          data.map((typeTask) => TypeTask.fromJson(typeTask)).toList();

      state = typeTaskList;
    } catch (e) {
      throw Exception('Terjadi kesalahan saat memuat data jenis tugas');
    }
  }
}
