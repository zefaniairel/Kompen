import 'package:dio/dio.dart';
import 'package:mobile/utils/const.dart';
import 'package:mobile/utils/shared_pref.dart';

class DioClient {
  final Dio _dio;
  Sharedprefs prefs = Sharedprefs();

  DioClient() : _dio = Dio(BaseOptions(baseUrl: apiUrl)) {
    _dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) async {
        final token = await prefs.getToken();
        if (token != null) {
          options.headers['Authorization'] = 'Bearer $token';
        }
        return handler.next(options);
      },
      onError: (DioException e, handler) {
        if (e.response?.statusCode == 401) {
          prefs.clearToken();
        }
        return handler.next(e);
      },
    ));
  }

  Dio get dio => _dio;
}
