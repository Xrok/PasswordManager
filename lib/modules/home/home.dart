import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:password_manager/modules/home/bloc/home_bloc.dart';
import 'package:password_manager/modules/home/view/home_view.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeBloc()..add(FetchAccountsEvent()),
      child: BlocBuilder<HomeBloc, HomeState>(
        builder: (context, state) {
          return HomeView();
        },
      ),
    );
  }
}
