import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:password_manager/utils/biometric_storage_util.dart';
import 'package:password_manager/core/general_exception.dart';
import 'package:password_manager/repository/user/models/account.dart';
import 'package:password_manager/repository/user/user_provider.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeInitial());

  @override
  Stream<HomeState> mapEventToState(
    HomeEvent event,
  ) async* {
    if (event is FetchAccountsEvent) {
      yield* _mapFetchAccountsEventToState(event);
    } else if (event is AddAccountEvent) {
      yield* _mapFetchAddAccountEvent(event);
    } else if (event is RequestAddSecretEvent) {
      yield* _mapRequestAddSecretEventToState(event);
    } else if (event is AddSecretEvent) {
      yield* _mapToAddSecretEventToState(event);
    }
  }

  Stream<HomeState> _mapToAddSecretEventToState(AddSecretEvent event) async* {
    try {
      if (event.secret != null && event.secret!.isNotEmpty) {
        await BiometricStorageUtil.write('secret', event.secret!);
      }
      yield HomeLoaded(state.accounts);
    } catch (e) {}
  }

  Stream<HomeState> _mapRequestAddSecretEventToState(event) async* {
    yield HomeNeedSecret(accounts: state.accounts);
  }

  Stream<HomeState> _mapFetchAccountsEventToState(FetchAccountsEvent event) async* {
    try {
      final jwt = await BiometricStorageUtil.read('jwt');
      if (jwt != null) {
        final accounts = await UserProvider.fetchAccounts(jwt);
        yield HomeLoaded(accounts);
      } else {
        yield HomeError('No JWT');
      }
    } on GeneralException catch (e) {
      yield HomeError(e.message);
    }
  }

  Stream<HomeState> _mapFetchAddAccountEvent(AddAccountEvent event) async* {
    try {
      final jwt = await BiometricStorageUtil.read('jwt');
      if (jwt != null) {
        await UserProvider.addAccount(jwt, event.webPage, event.accUsername, event.accPassword);
        yield HomeAddedAccSuccess(accounts: state.accounts);
      }
    } on GeneralException catch (e) {
      yield HomeError(e.message);
    } catch (e) {
      yield HomeError('Backend Error');
    }
  }
}
