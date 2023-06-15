import 'package:apple_shop/common/params/params.dart';

class LoginParams extends Params {
  final String username;
  final String password;

  LoginParams({required this.username, required this.password});
}
