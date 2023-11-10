
import 'package:dio/dio.dart';
import 'package:gweiland_web3/core/exceptions.dart';
import 'package:gweiland_web3/utils/logger.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

class ApiClient {
  static const String MARKETS =
      '/coins/markets';

  final Dio dio = Dio();

  ApiClient() {
    dio.options.baseUrl = "https://api.coingecko.com/api/v3";
    dio.options.connectTimeout = const Duration(minutes: 3);
    dio.options.receiveTimeout = const Duration(minutes: 3);

    dio.interceptors.add(
      PrettyDioLogger(
        requestHeader: true,
        requestBody: true,
        responseHeader: true,
        responseBody: false,
      ),
    );
  }

  Future<Response<Map<String, dynamic>>> post(
    String path,
    dynamic data,
  ) async {
    try {
      return await dio.post(path, data: data);
    } on DioException catch (e) {
      Logger.write(e.message ?? "");
      throw ApiException(e.message ?? "");
    }
  }

  Future<Response<Map<String, dynamic>>> put(String path, dynamic data) async {
    try {
      return await dio.put(path, data: data);
    } on DioException catch (e) {
      Logger.write(e.message ?? "");
      throw ApiException(e.message ?? "");
    }
  }

  Future<Response<Map<String, dynamic>>> delete(String path) async {
    try {
      return await dio.delete(path);
    } on DioException catch (e) {
      Logger.write(e.message ?? "");
      throw ApiException(e.message ?? "");
    }
  }

  Future<Response<dynamic>> get(String path) async {
    try {
      return await dio.get(path);
    } on DioException catch (e) {
      Logger.write(e.message ?? "");
      throw ApiException(e.message ?? "");
    }
  }
}
