import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;

import 'package:password_manager/constants/app_constants.dart';
import 'package:password_manager/core/general_exception.dart';
import 'package:password_manager/repository/user/models/account.dart';

class UserProvider {
  static const _baseUrl = AppConstants.baseUrl;

  static Future<String> register(String username, String password) async {
    log('INIT', name: 'register');
    try {
      final uri = Uri.https(_baseUrl, 'register');
      final response = await http.post(uri,
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: jsonEncode(<String, String>{'username': username, 'password': password}));

      var decodedResponse = jsonDecode(response.body);
      if (response.statusCode == 201) {
        log('END', name: 'register');
        return decodedResponse['username'];
      } else {
        final error = GeneralException(decodedResponse['error'], '001', StackTrace.current);
        log("ERROR'${decodedResponse['error']}", name: 'register', error: error);
        throw error;
      }
    } on GeneralException {
      rethrow;
    } catch (e, stackTrace) {
      log('ERROR', name: 'register', error: e, stackTrace: stackTrace);
      print(e);
      print(stackTrace);
      throw GeneralException('An error ocurred', '000', stackTrace);
    }
  }

  static Future<String> login(String username, String password) async {
    log('INIT', name: 'login');
    try {
      final uri = Uri.https(_baseUrl, 'login');
      final response = await http.post(uri,
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: jsonEncode(<String, String>{'username': username, 'password': password}));

      var decodedResponse = jsonDecode(response.body);
      if (response.statusCode == 200) {
        log('END', name: 'login');
        return decodedResponse['token'];
      } else {
        final error = GeneralException(decodedResponse['error'], '001', StackTrace.current);
        log("ERROR'${decodedResponse['error']}", name: 'login', error: error);
        throw error;
      }
    } on GeneralException {
      rethrow;
    } catch (e, stackTrace) {
      log('ERROR', name: 'login', error: e, stackTrace: stackTrace);
      print(e);
      print(stackTrace);
      throw GeneralException('An error ocurred', '000', stackTrace);
    }
  }

  static Future<List<Account>> fetchAccounts(String jwt) async {
    log('INIT', name: 'fetchAccounts');
    try {
      final uri = Uri.https(_baseUrl, 'user/all');
      final response = await http.post(uri,
          headers: <String, String>{'Content-Type': 'application/json; charset=UTF-8', 'Authorization': jwt});

      var decodedResponse = jsonDecode(response.body);
      if (response.statusCode == 200) {
        var accountList = decodedResponse.map<Account>((userJson) => Account.fromJson(userJson)).toList();
        log('END', name: 'fetchAccounts');
        return accountList;
      } else {
        final error = GeneralException(decodedResponse['error'], '001', StackTrace.current);
        log("ERROR'${decodedResponse['error']}", name: 'fetchAccounts', error: error);
        throw error;
      }
    } on GeneralException {
      rethrow;
    } catch (e, stackTrace) {
      log('ERROR', name: 'fetchAccounts', error: e, stackTrace: stackTrace);
      throw GeneralException('An error ocurred', '000', stackTrace);
    }
  }

  static Future<String> addAccount(String jwt, String webPage, String accUsername, String accPassword) async {
    log('INIT', name: 'addAccount');
    try {
      final uri = Uri.https(_baseUrl, 'user');
      final response = await http.post(uri,
          headers: <String, String>{'Content-Type': 'application/json; charset=UTF-8', 'Authorization': jwt},
          body:
              jsonEncode(<String, String>{'webPage': webPage, 'accUsername': accUsername, 'accPassword': accPassword}));

      var decodedResponse = jsonDecode(response.body);
      if (response.statusCode == 201) {
        log('END', name: 'addAccount');
        return decodedResponse['username'];
      } else {
        final error = GeneralException(decodedResponse['error'], '001', StackTrace.current);
        log("ERROR'${decodedResponse['error']}", name: 'addAccount', error: error);
        throw error;
      }
    } on GeneralException {
      rethrow;
    } catch (e, stackTrace) {
      log('ERROR', name: 'addAccount', error: e, stackTrace: stackTrace);
      throw GeneralException('An error ocurred', '000', stackTrace);
    }
  }

  static Future<String> deleteAccount(String jwt, String webPage, String accUsername) async {
    log('INIT', name: 'deleteAccount');
    try {
      final uri = Uri.https(_baseUrl, 'user');
      final response = await http.patch(uri,
          headers: <String, String>{'Content-Type': 'application/json; charset=UTF-8', 'Authorization': jwt},
          body: jsonEncode(<String, String>{'webPage': webPage, 'accUsername': accUsername}));

      var decodedResponse = jsonDecode(response.body);
      if (response.statusCode == 200) {
        log('END', name: 'deleteAccount');
        return decodedResponse['username'];
      } else {
        final error = GeneralException(decodedResponse['error'], '001', StackTrace.current);
        log("ERROR'${decodedResponse['error']}", name: 'deleteAccount', error: error);
        throw error;
      }
    } on GeneralException {
      rethrow;
    } catch (e, stackTrace) {
      log('ERROR', name: 'deleteAccount', error: e, stackTrace: stackTrace);
      print(stackTrace);
      throw GeneralException('An error ocurred', '000', stackTrace);
    }
  }
}
