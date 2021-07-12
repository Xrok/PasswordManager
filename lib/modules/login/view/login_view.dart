import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:password_manager/constants/app_constants.dart';
import 'package:password_manager/core/bloc/auth_bloc.dart';
import 'package:password_manager/modules/login/bloc/login_bloc.dart';

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
        resizeToAvoidBottomInset: false,
        extendBodyBehindAppBar: true,
        body: BlocListener<LoginBloc, LoginState>(listener: (context, state) {
          if (state is LoginSuccessState) {
            Navigator.pushReplacementNamed(context, '/');
            BlocProvider.of<AuthBloc>(context).add(LoggedInEvent());
          }
          if (state is LoginFailureState) {
            final snackBar = SnackBar(content: Text(state.message));
            ScaffoldMessenger.of(context).showSnackBar(snackBar);
          }
        }, child: SafeArea(child: LayoutBuilder(builder: (BuildContext context, BoxConstraints viewportConstraints) {
          return SingleChildScrollView(
            padding: EdgeInsets.only(
                right: AppConstants.sizes[3],
                left: AppConstants.sizes[3],
                top: 0.0,
                bottom: MediaQuery.of(context).viewInsets.bottom),
            // MediaQuery.of(context).viewInsets.bottom
            child: ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight: viewportConstraints.maxHeight,
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(
                      "LOGIN",
                      style: Theme.of(context).textTheme.headline1,
                    ),
                    SvgPicture.asset(AppConstants.logoPath),
                    SizedBox(
                      height: AppConstants.sizes[2],
                    ),
                    TextField(
                      style: Theme.of(context).textTheme.bodyText1,
                      decoration: InputDecoration(hintText: 'Usuario'),
                      onChanged: (value) => setState(() {
                        username = value;
                      }),
                    ),
                    SizedBox(
                      height: AppConstants.sizes[2],
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
                    SizedBox(
                      height: AppConstants.sizes[2],
                    ),
                    BlocBuilder<LoginBloc, LoginState>(
                      builder: (context, state) {
                        if (state is LoginLoadingState) {
                          return CircularProgressIndicator();
                        }
                        return Column(
                          children: [
                            GestureDetector(
                              child: Text("Entrar", style: Theme.of(context).textTheme.subtitle2),
                              onTap: () => BlocProvider.of<LoginBloc>(context).add(LoginCredEvent(username, password)),
                            ),
                            SizedBox(
                              height: AppConstants.sizes[2],
                            ),
                            GestureDetector(
                              onTap: () => Navigator.pushNamed(context, '/register'),
                              child: Text("Crear Cuenta", style: Theme.of(context).textTheme.subtitle2),
                            ),
                          ],
                        );
                      },
                    ),
                    SizedBox(
                      height: AppConstants.sizes[2],
                    )
                  ],
                )),
          );
        }))));
  }
}
