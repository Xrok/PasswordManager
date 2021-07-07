part of 'auth_bloc.dart';

@immutable
abstract class AuthEvent {}

class AppStartedEvent extends AuthEvent {}

class LoginEvent extends AuthEvent {
  final String username;
  final String password;

  //List<Object> get props => [username, password];

  LoginEvent(this.username, this.password);
}

class LogoutEvent extends AuthEvent {}
