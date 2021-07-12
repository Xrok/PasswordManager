part of 'home_bloc.dart';

@immutable
abstract class HomeEvent {}

class FetchAccountsEvent extends HomeEvent {}

class AddAccountEvent extends HomeEvent {
  final String webPage;
  final String accUsername;
  final String accPassword;

  AddAccountEvent(this.webPage, this.accUsername, this.accPassword);
}

class AddSecretEvent extends HomeEvent {
  final String? secret;
  AddSecretEvent(this.secret);
}

class RequestAddSecretEvent extends HomeEvent {}
