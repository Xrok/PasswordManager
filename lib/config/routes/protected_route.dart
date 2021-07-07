import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:password_manager/core/bloc/auth_bloc.dart';
import 'package:password_manager/widgets/loading_page.dart';

class ProtectedRoute extends StatelessWidget {
  final Widget view;
  const ProtectedRoute({Key? key, required this.view}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(listener: (context, state) {
      if (state is AuthFailure) {
        Navigator.pushReplacementNamed(context, '/login');
      }
    }, child: BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        if (state is AuthSuccess) {
          return view;
        }
        return LoadingPage();
      },
    ));
  }
}
