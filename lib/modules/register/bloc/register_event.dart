part of 'register_bloc.dart';

@immutable
abstract class RegisterEvent {}

class SubmitRegisterEvent extends RegisterEvent {
  final String username;
  final String password;

  SubmitRegisterEvent(this.username, this.password);
}
