part of 'register_bloc.dart';

@immutable
abstract class RegisterState {}

class RegisterInitial extends RegisterState {}

class SuccessfullRegisteredState extends RegisterState {
  final String secret;

  SuccessfullRegisteredState(this.secret);
}

class LoadingRegisterState extends RegisterState {}

class ErrorRegisterState extends RegisterState {
  final String message;

  ErrorRegisterState(this.message);
}
