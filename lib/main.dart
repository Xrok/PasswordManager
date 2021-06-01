import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:password_manager/config/routes/app_router..dart';
import 'package:password_manager/config/theme/theme.dart';
import 'package:password_manager/core/bloc/auth_bloc.dart';
import 'package:password_manager/repository/user/user_repository.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
        providers: [
          RepositoryProvider<UserRepository>(
              create: (context) => UserRepository())
        ],
        child: BlocProvider(
          create: (context) => AuthBloc()..add(AppStartedEvent()),
          child: MaterialApp(
            theme: customTheme,
            debugShowCheckedModeBanner: false,
            onGenerateRoute: AppRouter.onGenerateRoute,
          ),
        ));

    /*return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const Scaffold(),
    );*/
  }
}
