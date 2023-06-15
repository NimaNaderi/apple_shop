import 'dart:convert';

import 'package:apple_shop/config/di/di.dart';
import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;

abstract class ApiClient {
  Future<ApiResponse> get(String url, Map<String, dynamic>? queryParams);

  Future<ApiResponse> post(String url, Map<String, dynamic> body);
}

class ApiResponse {
  Map<String, dynamic>? data;
  int? statusCode;

  ApiResponse({required this.data, required this.statusCode});
}

class DioClient extends ApiClient {
  final Dio _dio = locator.get();

  @override
  Future<ApiResponse> get(String url, Map<String, dynamic>? queryParams) async {
    final response = await _dio.get(url, queryParameters: queryParams);
    return Future.value(
        ApiResponse(data: response.data[0], statusCode: response.statusCode));
  }

  @override
  Future<ApiResponse> post(String url, Map<String, dynamic> body) async {
    final Response response = await _dio.post(url, data: body);
    return Future.value(
        ApiResponse(data: response.data, statusCode: response.statusCode));
  }
}

class HttpClient extends ApiClient {
  final http.Client _http = locator.get();

  @override
  Future<ApiResponse> get(String url, Map<String, dynamic>? queryParams) async {
    final response = await _http.get(
      Uri.parse('http://startflutter.ir/api/$url'),
    );
    final data = jsonDecode(response.body);
    return Future.value(
        ApiResponse(data: data[0], statusCode: response.statusCode));
  }

  @override
  Future<ApiResponse> post(String url, Map<String, dynamic> body) async {
    final response = await _http
        .post(Uri.parse('http://startflutter.ir/api/$url'), body: body);
    final data = jsonDecode(response.body);
    return Future.value(
        ApiResponse(data: data, statusCode: response.statusCode));
  }
}
