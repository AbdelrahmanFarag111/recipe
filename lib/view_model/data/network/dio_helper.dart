import 'package:dio/dio.dart';
import 'package:recipe/view_model/data/network/end%20pionts.dart';


class DioHelper {
  static final Dio _dio = Dio(
    BaseOptions(
      baseUrl: EndPoints.baseUrl,
      receiveDataWhenStatusError: true,
      headers: {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
      },
    ),
  );

  static Future<Response> postLogin({
    required String path,
    Map<String, dynamic>? body,
    Map<String, dynamic>? queryParameters,
    bool? withToken = false,
  }) async {
    try {
      if (withToken!) {
        _dio.options.headers.addAll({
          'x-api-key': EndPoints.apiKey,
        });
      }
      Response response = await _dio.post(
        path,
        data: body,
        queryParameters: queryParameters,
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }

  static Future<Response> post({
    required String path,
    Map<String, dynamic>? body,
    Map<String, dynamic>? queryParameters,
    bool? withToken = false,
  }) async {
    try {
      if (withToken!) {
        _dio.options.headers.addAll({
          'Authorization': 'apiKey ${EndPoints.apiKey}',
        });
      }
      Response response = await _dio.post(
        path,
        data: body,
        queryParameters: queryParameters,
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }

  static Future<Response> get({
    required String path,
    Map<String, dynamic>? body,
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      Response response = await _dio.get(
        path,
        data: body,
        queryParameters: queryParameters,
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }

  static Future<Response> put({
    required String path,
    Map<String, dynamic>? body,
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      Response response = await _dio.put(
        path,
        data: body,
        queryParameters: queryParameters,
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }

  static Future<Response> patch({
    required String path,
    Map<String, dynamic>? body,
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      Response response = await _dio.patch(
        path,
        data: body,
        queryParameters: queryParameters,
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }

  static Future<Response> delete({
    required String path,
    Map<String, dynamic>? body,
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      Response response = await _dio.delete(
        path,
        data: body,
        queryParameters: queryParameters,
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }
}
