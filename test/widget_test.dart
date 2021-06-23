// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:password_manager/main.dart';
import 'package:password_manager/repository/user/user_provider.dart';

void main() {
  // testWidgets('Counter increments smoke test', (WidgetTester tester) async {
  //   // Build our app and trigger a frame.
  //   await tester.pumpWidget(const MyApp());

  //   // Verify that our counter starts at 0.
  //   expect(find.text('0'), findsOneWidget);
  //   expect(find.text('1'), findsNothing);

  //   // Tap the '+' icon and trigger a frame.
  //   await tester.tap(find.byIcon(Icons.add));
  //   await tester.pump();

  //   // Verify that our counter has incremented.
  //   expect(find.text('0'), findsNothing);
  //   expect(find.text('1'), findsOneWidget);
  // });
  final provider = UserProvider();
  test('hello-world', () async {
    try {
      // provider
    } catch (e) {}
  });

  test('login', () async {
    try {
      var username = "xrok";
      var password = "1234";
      var response = await provider.login(username, password);
      print(response);
    } catch (e) {
      print(e.toString());
    }
  });

  test('register', () async {
    try {
      var username = "xrok";
      var password = "1234";
      var response = await provider.register(username, password);
      print(response);
    } catch (e) {
      print(e.toString());
    }
  });

  test('fetchAccounts', () async {
    try {
      var username = "xrok";
      var password = "1234";
      var response = await provider.fetchAccounts(username, password);
      print(response);
    } catch (e) {
      print(e.toString());
    }
  });

  test('addAccount', () async {
    try {
      var username = "xrok";
      var password = "1234";
      var webPage = "facebook.com";
      var accUsername = "fbXrok";
      var accPassword = "fb1234";
      var response = await provider.addAccount(username, password, webPage, accUsername, accPassword);
      print(response);
    } catch (e) {
      print(e.toString());
    }
  });

  test('deleteAccount', () async {
    try {
      var username = "xrok";
      var password = "1234";
      var webPage = "facebook.com";
      var accUsername = "fbXrok";
      var response = await provider.deleteAccount(username, password, webPage, accUsername);
      print(response);
    } catch (e) {
      print(e.toString());
    }
  });
}

void testApi() {}
