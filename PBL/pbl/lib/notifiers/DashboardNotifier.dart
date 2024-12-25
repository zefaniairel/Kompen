import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobile/models/Dashboard.dart';
import 'package:mobile/utils/dio_client.dart';

class DashboardNotifier extends StateNotifier<Dashboard?> {
  DashboardNotifier() : super(null);

  final DioClient dioClient = DioClient();

  Future<void> getDashboardStudent() async {
    try {
      final response = await dioClient.dio.get('/dashboard-students');

      final data = response.data['data'];
      final dashboard = Dashboard.fromJson(data);

      state = dashboard;
    } catch (e) {
      throw Exception('Terjadi kesalahan saat memuat data dashboard');
    }
  }

  Future<void> getDashboardSdm() async {
    try {
      final response = await dioClient.dio.get('/dashboard-sdm');

      final data = response.data['data'];
      final dashboard = Dashboard.fromJson(data);

      state = dashboard;
    } catch (e) {
      throw Exception('Terjadi kesalahan saat memuat data dashboard');
    }
  }
}
