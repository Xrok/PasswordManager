import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:password_manager/main.dart';
import 'package:password_manager/repository/user/user_provider.dart';

void main() {
  String username = "xrok";
  String password = "1234";
  test('hello-world', () async {
    try {} catch (e) {}
  });

  test('login', () async {
    try {
      var response = await UserProvider.login(username, password);
      print(response);
    } catch (e) {
      print(e.toString());
    }
  });

  test('register', () async {
    try {
      var response = await UserProvider.register(username, password);
      print(response);
    } catch (e) {
      print(e.toString());
    }
  });

  test('fetchAccounts', () async {
    try {
      var jwt = await UserProvider.login(username, password);
      var response = await UserProvider.fetchAccounts(jwt);
      print(response);
    } catch (e) {
      print(e.toString());
    }
  });

  test('addAccount', () async {
    try {
      var jwt = await UserProvider.login(username, password);
      var webPage = "facebook.com";
      var accUsername = "fbXrok";
      var accPassword = "fb1234";
      var response = await UserProvider.addAccount(jwt, webPage, accUsername, accPassword);
      print(response);
    } catch (e) {
      print(e.toString());
    }
  });

  test('deleteAccount', () async {
    try {
      var jwt = await UserProvider.login(username, password);
      var webPage = "facebook.com";
      var accUsername = "fbXrok";
      var response = await UserProvider.deleteAccount(jwt, webPage, accUsername);
      print(response);
    } catch (e) {
      print(e.toString());
    }
  });
}
