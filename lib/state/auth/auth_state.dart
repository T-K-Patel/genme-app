part of 'auth_bloc.dart';

@immutable
abstract class AuthState {
  const AuthState();
}

final class AuthStateUninitialized extends AuthState {
  const AuthStateUninitialized();
}

final class AuthStateInitial extends AuthState {
  const AuthStateInitial();
}

final class AuthStateLoading extends AuthState {
 const AuthStateLoading();
}

final class AuthStateLoggedIn extends AuthState {
  final UserProfile user;
  const AuthStateLoggedIn({required this.user});
}

final class AuthStateLoggedOut extends AuthState {
  const AuthStateLoggedOut();
}

final class AuthStateError extends AuthState {
  final Exception exception;
  const AuthStateError({required this.exception});
}
