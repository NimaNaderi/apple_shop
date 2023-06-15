import 'package:apple_shop/features/auth/data/datasources/remote/auth_datasource.dart';
import 'package:apple_shop/config/di/di.dart';
import 'package:apple_shop/common/utils/api_exception.dart';
import 'package:apple_shop/features/auth/data/utils/auth_manager.dart';
import 'package:dartz/dartz.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../domain/repositories/auth_repository.dart';

class AuthenticationRepository extends IAuthRepository {
  final IAuthDataSource _datasource = locator.get();

  @override
  Future<Either<String, String>> register(
      String username, String password, String passwordConfirm) async {
    try {
      await _datasource.register(username, password, passwordConfirm);
      return right('ثبت نام با موفقیت انجام شد');
    } on ApiException catch (e) {
      return left(e.message ?? 'خطای نامشخص');
    }
  }

  @override
  Future<Either<String, String>> login(String username, String password) async {
    try {
      String accessToken = await _datasource.login(username, password);

      if (accessToken.isNotEmpty) {
        AuthManager.saveToken(accessToken);
        return right('شما وارد شدید');
      } else {
        return left('خطایی در ورود پیش آمده');
      }
    } on ApiException catch (e) {
      return left('${e.message}');
    }
  }
}
