part of 'login_bloc.dart';

@immutable
abstract class LoginEvent {}

class LoginCredEvent extends LoginEvent {
  final String username;
  final String password;
  LoginCredEvent(this.username, this.password);
}
