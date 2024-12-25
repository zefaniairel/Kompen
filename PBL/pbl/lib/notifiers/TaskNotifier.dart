import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobile/models/Task.dart';
import 'package:mobile/utils/dio_client.dart';

class TaskNotifier extends StateNotifier<List<Task?>> {
  TaskNotifier() : super([]);

  final DioClient dioClient = DioClient();

  Future<void> getTasks() async {
    try {
      final response = await dioClient.dio.get('/tasks');

      final data = response.data['data'];
      final tasks = data.map<Task>((task) => Task.fromJson(task)).toList();

      state = tasks;
    } catch (e) {
      throw Exception('Terjadi kesalahan saat memuat data tugas');
    }
  }

  Future<void> getTasksStudent() async {
    try {
      final response = await dioClient.dio.get('/tasks/student');

      final data = response.data['data'];
      print('Response data type: ${data.runtimeType}');
      print(data);
      final tasks = (data as List<dynamic>)
          .map((task) => Task.fromJson(task as Map<String, dynamic>))
          .toList();

      state = tasks;
    } catch (e) {
      throw Exception('Terjadi kesalahan saat memuat data tugas');
    }
  }

  Future<void> getTaskStudentById(int id) async {
    try {
      final response = await dioClient.dio.get('/tasks/student/$id');
      print(response.data);
      final data = response.data['data'];
      final task = Task.fromJson(data);

      state = [task];
    } catch (e) {
      print(e);
      throw Exception('Terjadi kesalahan saat memuat data tugas');
    }
  }

  Future<void> addTask(Map<String, dynamic> task) async {
    try {
      await dioClient.dio.post('/tasks', data: task);

      getTasks();
    } catch (e) {
      throw Exception('Terjadi kesalahan saat menambahkan tugas');
    }
  }

  Future<void> editTask(int id, Map<String, dynamic> task) async {
    try {
      await dioClient.dio.put('/tasks/$id', data: task);

      getTasks();
    } catch (e) {
      throw Exception('Terjadi kesalahan saat mengedit tugas');
    }
  }

  Future<void> deleteTask(int id) async {
    try {
      await dioClient.dio.delete('/tasks/$id');

      getTasks();
    } catch (e) {
      throw Exception('Terjadi kesalahan saat menghapus tugas');
    }
  }
}
