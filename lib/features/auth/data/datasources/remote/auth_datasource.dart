import 'package:apple_shop/config/di/di.dart';
import 'package:apple_shop/common/utils/api_exception.dart';
import 'package:dio/dio.dart';

abstract class IAuthDataSource {
  Future<void> register(
      String username, String password, String passwordConfirm);
  Future<String> login(String username, String password);
}

