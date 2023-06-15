import 'package:dartz/dartz.dart';

abstract class IAuthRepository {
  Future<Either<String, String>> register(
      String username, String password, String passwordConfirm);
  Future<Either<String, String>> login(String username, String password);
}