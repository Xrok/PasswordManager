import 'package:flutter/material.dart';
import 'package:password_manager/config/routes/protected_route.dart';
import 'package:password_manager/modules/home/home.dart';
import 'package:password_manager/modules/login/login.dart';
import 'package:password_manager/modules/register/register.dart';

class AppRouter {
  AppRouter();
  static Route onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return PageRouteBuilder(
            settings: const RouteSettings(name: '/'),
            pageBuilder: (_, __, ___) => ProtectedRoute(view: Home()));
      case '/login':
        return PageRouteBuilder(
            settings: const RouteSettings(name: '/login'),
            pageBuilder: (_, __, ___) => LoginPage());
      case '/register':
        return PageRouteBuilder(
            settings: const RouteSettings(name: '/register'),
            pageBuilder: (_, __, ___) => RegisterPage());
      default:
        return PageRouteBuilder(
            settings: const RouteSettings(name: '/login'),
            pageBuilder: (_, __, ___) => LoginPage());
    }
  }
}
