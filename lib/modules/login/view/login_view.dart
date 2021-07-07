import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:password_manager/constants/app_constants.dart';
import 'package:password_manager/core/bloc/auth_bloc.dart';

class LoginView extends StatefulWidget {
  @override
  _LoginViewState createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  String username = '';
  String password = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: BlocListener<AuthBloc, AuthState>(
            listener: (context, state) {
              if (state is AuthSuccess) {
                Navigator.pushReplacementNamed(context, '/');
              }
            },
            child: SafeArea(
              child: Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: AppConstants.sizes[3], vertical: 0.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text(
                        "LOGIN",
                        style: Theme.of(context).textTheme.headline1,
                      ),
                      SvgPicture.asset(AppConstants.logoPath),
                      TextField(
                        style: Theme.of(context).textTheme.bodyText1,
                        decoration: InputDecoration(hintText: 'Usuario'),
                        onChanged: (value) => setState(() {
                          username = value;
                        }),
                      ),
                      TextField(
                        style: Theme.of(context).textTheme.bodyText1,
                        decoration: InputDecoration(hintText: 'Contraseña'),
                        obscureText: true,
                        enableSuggestions: false,
                        autocorrect: false,
                        onChanged: (value) => setState(() {
                          password = value;
                        }),
                      ),
                      GestureDetector(
                        child: Text("Entrar",
                            style: Theme.of(context).textTheme.subtitle2),
                        onTap: () => BlocProvider.of<AuthBloc>(context)
                            .add(LoginEvent(username, password)),
                      ),
                      GestureDetector(
                        onTap: () => Navigator.pushNamed(context, '/register'),
                        child: Text("Crear Cuenta",
                            style: Theme.of(context).textTheme.subtitle2),
                      ),
                      SizedBox(
                        height: AppConstants.sizes[3],
                      )
                    ],
                  )),
            )));
  }
}
