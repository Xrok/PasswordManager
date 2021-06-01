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
        return MaterialPageRoute(
            settings: const RouteSettings(name: '/'),
            //builder: (_) => ProtectedRoute(view: Home()));
            builder: (_) => Home());
      case '/login':
        return MaterialPageRoute(
            settings: const RouteSettings(name: '/login'),
            builder: (_) => LoginPage());
      case '/register':
        return MaterialPageRoute(
            settings: const RouteSettings(name: '/register'),
            builder: (_) => RegisterPage());
      default:
        return MaterialPageRoute(
            settings: const RouteSettings(name: '/login'),
            builder: (_) => LoginPage());
    }
  }
}
