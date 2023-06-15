import 'package:apple_shop/config/clients/api_client.dart';
import 'package:dio/dio.dart';

import '../../../../../config/di/di.dart';
import '../../../../../common/utils/api_exception.dart';
import 'auth_datasource.dart';

class AuthenticationRemote implements IAuthDataSource {
  // final Dio _dio = locator.get();
  final ApiClient _apiClient = locator.get();

  @override
  Future<void> register(
      String username, String password, String passwordConfirm) async {
    try {
      await _apiClient.post(
        'collections/users/records',
        {
          'username': username,
          'password': password,
          'passwordConfirm': passwordConfirm
        },
      );

    } on DioError catch (e) {
      throw ApiException(e.response?.data['data']['username']['message'],
          e.response?.statusCode);
    } catch (e) {
      throw ApiException('unknown error', 0);
    }
  }

  @override
  Future<String> login(String username, String password) async {
    try {

     final response = await _apiClient.post('collections/users/auth-with-password',
          {'identity': username, 'password': password});

      if (response.statusCode == 200) {
        return response.data?['token'];
      }
    } on DioError catch (e) {
      throw ApiException(e.response?.data['message'], e.response?.statusCode);
    } catch (e) {
      throw ApiException('unknown error', 0);
    }
    return '';
  }
}
