import 'package:apple_shop/common/params/auth_params/login_params.dart';
import 'package:apple_shop/common/params/auth_params/register_params.dart';
import 'package:apple_shop/config/di/di.dart';
import 'package:apple_shop/features/auth/domain/usecases/login.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/usecases/register.dart';
import 'auth_event.dart';
import 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final RegisterUseCase _registerUseCase = locator.get();
  final LoginUseCase _loginUseCase = locator.get();

  AuthBloc() : super(AuthInitState()) {
    on<AuthRegisterRequest>(
      (event, emit) async {
        emit(AuthLoadingState());

        final registerParams = RegisterParams(
          username: event.username,
          password: event.password,
          confirmPassword: event.password,
        );

        final registerResponse = await _registerUseCase(registerParams);

        emit(AuthResponseState(registerResponse));
      },
    );

    on<AuthLoginRequest>(
      (event, emit) async {
        emit(AuthLoadingState());

        final loginParams = LoginParams(
          username: event.username,
          password: event.password,
        );

        final loginResponse = await _loginUseCase(loginParams);
        emit(AuthResponseState(loginResponse));
      },
    );
  }
}
