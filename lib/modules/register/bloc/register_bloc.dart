import 'dart:async';
import 'dart:convert';
import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:password_manager/core/general_exception.dart';
import 'package:password_manager/repository/user/user_provider.dart';
import 'package:password_manager/utils/biometric_storage_util.dart';
import 'package:encrypt/encrypt.dart';

part 'register_event.dart';
part 'register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  RegisterBloc() : super(RegisterInitial());

  @override
  Stream<RegisterState> mapEventToState(
    RegisterEvent event,
  ) async* {
    if (event is SubmitRegisterEvent) {
      yield* _mapSubmitRegisterEventToState(event);
    }
  }

  Stream<RegisterState> _mapSubmitRegisterEventToState(event) async* {
    yield LoadingRegisterState();
    try {
      await UserProvider.register(event.username, event.password);
      final key = Key.fromSecureRandom(32).base64;
      print(key);
      await BiometricStorageUtil.write('secret', key);
      yield SuccessfullRegisteredState(key);
    } on GeneralException catch (e) {
      yield ErrorRegisterState(e.message);
    } catch (e) {
      yield ErrorRegisterState('Backend Error');
    }
  }
}
