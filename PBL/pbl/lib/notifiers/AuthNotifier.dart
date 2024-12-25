import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobile/models/User.dart';
import 'package:mobile/utils/dio_client.dart';
import 'package:mobile/utils/shared_pref.dart';
import 'package:dio/dio.dart';

class AuthNotifier extends StateNotifier<User?> {
  AuthNotifier() : super(null);

  final DioClient dioClient = DioClient();
  final Sharedprefs prefs = Sharedprefs();

  Future<String> login(String username, String password) async {
    try {
      final response = await dioClient.dio.post('/login', data: {
        'username': username,
        'password': password,
      });

      final data = response.data['data'];
      final user = User.fromJson(data['user']);
      final token = data['token'];
      final role = user.role;

      await prefs.saveToken(token);
      state = user;

      return role == "mahasiswa" ? 'mahasiswa' : 'sdm';
    } catch (e) {
      if (e is DioException) {
        final errorMessage =
            e.response?.data['message'] ?? 'Terjadi kesalahan saat login';
        throw Exception(errorMessage);
      } else {
        throw Exception('Terjadi kesalahan tidak terduga');
      }
    }
  }

  Future<void> logout() async {
    final response = await dioClient.dio.post('/logout');

    final status = response.data['status'];
    if (status) {
      await prefs.clearToken();
      state = null;
    } else {
      throw Exception('Terjadi kesalahan saat logout');
    }
  }

  Future<void> me() async {
    try {
      final response = await dioClient.dio.get('/profile');
      final data = response.data['data'];
      final user = User.fromJson(data);

      state = user;
    } catch (e) {
      throw Exception('Terjadi kesalahan saat memuat data user');
    }
  }

  Future<void> updateProfile({
    required String nama,
    required String username,
    required int prodiId,
    required int kompetensiId,
    required int semester,
    required int alfa,
    required int compensation,
    String? password,
    String? fotoProfile,
  }) async {
    try {
      final data = {
        'nama': nama,
        'username': username,
        'prodi_id': prodiId,
        'kompetensi': kompetensiId,
        'semester': semester,
        'alfa': alfa,
        'compensation': compensation,
        'password': password,
        'foto_profile': fotoProfile,
      };

      final response = await dioClient.dio.put('/update-profile', data: data);

      final updatedUserData = response.data['data'];
      print(data);
      final updatedUser = User.fromJson(updatedUserData);

      state = updatedUser;
    } catch (e) {
      print(e);
      throw Exception('Terjadi kesalahan saat memperbarui profil');
    }
  }
}
