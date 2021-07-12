import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:password_manager/utils/biometric_storage_util.dart';
import 'package:password_manager/core/general_exception.dart';
import 'package:password_manager/repository/user/user_provider.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(LoginInitial());

  @override
  Stream<LoginState> mapEventToState(
    LoginEvent event,
  ) async* {
    if (event is LoginCredEvent) {
      yield* _mapLoginCredEventToState(event);
    }
  }

  Stream<LoginState> _mapLoginCredEventToState(LoginCredEvent event) async* {
    yield LoginLoadingState();
    try {
      var jwt = await UserProvider.login(event.username, event.password);
      await BiometricStorageUtil.write('jwt', jwt);
      yield LoginSuccessState();
    } on GeneralException catch (e) {
      yield LoginFailureState(e.message);
    } catch (e) {
      yield LoginFailureState('Backend Error');
    }
  }
}
