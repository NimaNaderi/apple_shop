import 'package:apple_shop/common/params/params.dart';

class RegisterParams extends Params {
  final String username;
  final String password;
  final String confirmPassword;

  RegisterParams({required this.username, required this.password, required this.confirmPassword});
}
