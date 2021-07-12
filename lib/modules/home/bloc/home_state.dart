part of 'home_bloc.dart';

@immutable
abstract class HomeState {
  final List<Account> accounts;

  HomeState(this.accounts);
}

class HomeInitial extends HomeState {
  HomeInitial({List<Account> accounts = const []}) : super(accounts);
}

class HomeLoading extends HomeState {
  HomeLoading({List<Account> accounts = const []}) : super(accounts);
}

class HomeLoaded extends HomeState {
  final List<Account> accounts;
  HomeLoaded(this.accounts) : super(accounts);
}

class HomeAddedAccSuccess extends HomeState {
  HomeAddedAccSuccess({List<Account> accounts = const []}) : super(accounts);
}

class HomeNeedSecret extends HomeState {
  HomeNeedSecret({List<Account> accounts = const []}) : super(accounts);
}

class HomeError extends HomeState {
  final String message;
  HomeError(this.message, {List<Account> accounts = const []}) : super(accounts);
}
