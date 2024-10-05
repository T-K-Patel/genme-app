part of 'auth_bloc.dart';

@immutable
abstract class AuthEvent {
  const AuthEvent();
}

class AuthEventInitialize extends AuthEvent {
  const AuthEventInitialize();
}


class AuthEventCheck extends AuthEvent {
  const AuthEventCheck();
}
class AuthEventLogin extends AuthEvent {
  final String username;
  final String password;
  const AuthEventLogin({required this.username, required this.password});
}

class AuthEventLogout extends AuthEvent {
  const AuthEventLogout();
}

