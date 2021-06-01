import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthInitial());

  @override
  Stream<AuthState> mapEventToState(
    AuthEvent event,
  ) async* {
    yield* _mapAppStartedToState();
  }

  Stream<AuthState> _mapAppStartedToState() async* {
    //var isLoggedIn = await BiometricStorageUtil.read('pwd');
    //yield AuthSuccess();
    yield AuthFailure();
  }
}
