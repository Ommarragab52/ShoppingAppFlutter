import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

class DioFactory {
  static Dio? _dio;

  //private constructor
  DioFactory._();

  static Dio getDio() {
    if (_dio == null) {
      _dio = Dio();
      addDioOptions();
      addDioInterceptor();
      return _dio!;
    } else {
      return _dio!;
    }
  }

  static void addDioOptions() {
    Duration timeOut = const Duration(seconds: 30);
    _dio!.options.connectTimeout = timeOut;
    _dio!.options.receiveTimeout = timeOut;
    _dio!.options.headers.addAll({'lang': 'en'});
    _dio!.options.contentType = Headers.jsonContentType;
  }

  static void addDioInterceptor() {
    _dio!.interceptors.add(
      PrettyDioLogger(
        error: true,
        requestHeader: true,
        request: true,
        requestBody: true,
        responseBody: true,
      ),
    );
  }

  static void addTokenToHeader(String token) {
    _dio!.options.headers.addAll({'Authorization': token});
  }
}
