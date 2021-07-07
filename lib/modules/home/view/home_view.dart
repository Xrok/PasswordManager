import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:password_manager/config/theme/colors.dart';
import 'package:password_manager/core/bloc/auth_bloc.dart';
import 'package:password_manager/repository/user/models/account.dart';
import 'package:password_manager/widgets/card_account.dart';

class HomeView extends StatelessWidget {
  HomeView({Key? key}) : super(key: key);

  final List<Account> accounts = List.of([
    Account("webPage1", "username", "password"),
    Account("webPage2", "username", "password"),
    Account("webPage3", "username", "password"),
    Account("webPage4", "username", "password"),
    Account("webPage5", "username", "password"),
    Account("webPage6", "username", "password")
  ]);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Otorongo GA",
            style: Theme.of(context).textTheme.headline3?.copyWith(
                  color: CustomColors.richBlack,
                )),
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            ListTile(
              title: Text("Logout"),
              onTap: () =>
                  BlocProvider.of<AuthBloc>(context).add(LogoutEvent()),
            )
          ],
        ),
      ),
      body: ListView(
        children: parseAccounts(accounts),
      ),
    );
  }

  List<Widget> parseAccounts(List<Account> accounts) {
    return List.from(accounts.map((element) {
      return CardAccount(
        webPage: element.webPage,
        decryptInfo: decrypt,
      );
    }));
  }

  void decrypt() {}
}
