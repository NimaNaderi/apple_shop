import 'package:apple_shop/common/params/auth_params/register_params.dart';
import 'package:apple_shop/common/params/params.dart';
import 'package:apple_shop/common/usecase/usecase.dart';
import 'package:apple_shop/config/di/di.dart';
import 'package:apple_shop/features/auth/domain/repositories/auth_repository.dart';
import 'package:dartz/dartz.dart';

class RegisterUseCase extends UseCase<String> {
  final IAuthRepository _authRepository = locator.get();

  @override
  Future<Either<String, String>> call(Params? params) async {
    final registerParams = params as RegisterParams;
    return await _authRepository.register(
      registerParams.username,
      registerParams.password,
      registerParams.confirmPassword,
    );
  }
}
