abstract class AuthEvent {}

class AuthRegisterRequest extends AuthEvent {
  String username;
  String password;
  String confirmPassword;
  AuthRegisterRequest(this.username, this.password,this.confirmPassword);
}

class AuthLoginRequest extends AuthEvent {
  String username;
  String password;
  AuthLoginRequest(this.username, this.password);
}
