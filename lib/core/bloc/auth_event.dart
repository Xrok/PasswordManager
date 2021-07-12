part of 'auth_bloc.dart';

@immutable
abstract class AuthEvent {}

class AppStartedEvent extends AuthEvent {}

class LoginAuthEvent extends AuthEvent {
  final String username;
  final String password;

  LoginAuthEvent(this.username, this.password);
}

class LoggedInEvent extends AuthEvent {}

class LogoutAuthEvent extends AuthEvent {}
