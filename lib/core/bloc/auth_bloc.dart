import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:password_manager/utils/biometric_storage_util.dart';
import 'package:password_manager/core/general_exception.dart';
import 'package:password_manager/repository/user/user_provider.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthInitial());

  @override
  Stream<AuthState> mapEventToState(
    AuthEvent event,
  ) async* {
    if (event is AppStartedEvent) {
      yield* _mapAppStartedToState();
    } else if (event is LoginAuthEvent) {
      yield* _loginToState(event);
    } else if (event is LogoutAuthEvent) {
      yield* _logoutToState();
    } else if (event is LoggedInEvent) {
      yield* _mapLoggedInEventToState(event);
    } else if (event is ClearDataEvent) {
      yield* _mapClearDataEvent(event);
    }
  }

  Stream<AuthState> _mapClearDataEvent(event) async* {
    await BiometricStorageUtil.delete('secret');
  }

  Stream<AuthState> _mapLoggedInEventToState(event) async* {
    yield AuthSuccess();
  }

  Stream<AuthState> _mapAppStartedToState() async* {
    var isLoggedIn = await BiometricStorageUtil.read('jwt');
    if (isLoggedIn != null) {
      yield AuthSuccess();
    } else {
      yield AuthFailure();
    }
  }

  Stream<AuthState> _loginToState(event) async* {
    try {
      var jwt = await UserProvider.login(event.username, event.password);
      BiometricStorageUtil.write('jwt', jwt);
      yield AuthSuccess();
    } catch (e) {
      yield AuthFailure();
    }
  }

  Stream<AuthState> _logoutToState() async* {
    BiometricStorageUtil.delete('jwt');
    yield AuthFailure();
  }
}
