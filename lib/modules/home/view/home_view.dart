import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:password_manager/config/theme/colors.dart';
import 'package:password_manager/constants/app_constants.dart';
import 'package:password_manager/core/bloc/auth_bloc.dart';
import 'package:password_manager/core/general_exception.dart';
import 'package:password_manager/modules/home/bloc/home_bloc.dart';
import 'package:password_manager/repository/user/models/account.dart';
import 'package:password_manager/utils/biometric_storage_util.dart';
import 'package:password_manager/widgets/add_account_form.dart';
import 'package:password_manager/widgets/card_account.dart';
import 'package:password_manager/widgets/input_secret_form.dart';
import 'package:password_manager/widgets/loading_page.dart';
import 'package:password_manager/widgets/show_secret_dialog.dart';
import 'package:encrypt/encrypt.dart' as enc;

class HomeView extends StatelessWidget {
  HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final BuildContext contextProvider = context;
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          centerTitle: true,
          title: Text("Otorongo",
              style: Theme.of(context).textTheme.headline3?.copyWith(
                    color: CustomColors.richBlack,
                  )),
        ),
        drawer: Drawer(
          child: ListView(
            children: [
              ListTile(
                title: Text("Mostrar Secreto"),
                onTap: () => showSecret(context),
              ),
              ListTile(
                title: Text("Introducir Secreto"),
                onTap: () {
                  BlocProvider.of<HomeBloc>(context).add(RequestAddSecretEvent());
                  // Navigator.pop(context);
                },
              ),
              ListTile(
                title: Text("Cerrar Sesión"),
                onTap: () => BlocProvider.of<AuthBloc>(context).add(LogoutAuthEvent()),
              ),
              ListTile(
                title: Text("Borrar datos"),
                onTap: () => BlocProvider.of<AuthBloc>(context).add(ClearDataEvent()),
              )
            ],
          ),
        ),
        // floatingActionButtonLocation: FloatingActionButtonLocation,
        floatingActionButton: FloatingActionButton(
          backgroundColor: CustomColors.magicMint,
          child: Icon(
            Icons.add,
            color: CustomColors.richBlack,
          ),
          onPressed: () => showDialog(
              context: context,
              builder: (BuildContext context) {
                // return SingleChildScrollView(
                //     child:
                return AlertDialog(
                  content: FormAddAccount(
                      submitAccount: (webPage, accUsername, accPassword) =>
                          submitAccount(contextProvider, webPage, accUsername, accPassword)),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(AppConstants.sizes[1]))),
                );
                // );
              }),
        ),
        body: BlocListener<HomeBloc, HomeState>(
          listener: (context, state) {
            if (state is HomeError) {
              final snackBar = SnackBar(content: Text(state.message));
              ScaffoldMessenger.of(context).showSnackBar(snackBar);
              BlocProvider.of<AuthBloc>(context).add(LogoutAuthEvent());
            }
            if (state is HomeAddedAccSuccess) {
              Navigator.popAndPushNamed(context, '/');
            }
            if (state is HomeNeedSecret) {
              showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return SingleChildScrollView(
                        child: AlertDialog(
                      title: Text(
                        'Agrega tu llave de encriptación',
                        textAlign: TextAlign.center,
                      ),
                      titleTextStyle: Theme.of(context).textTheme.headline3,
                      content:
                          InputSecretForm(saveSecretCallback: (secret) => saveSecretCallback(contextProvider, secret)),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(AppConstants.sizes[1]))),
                    ));
                  });
            }
          },
          child: BlocBuilder<HomeBloc, HomeState>(
            builder: (context, state) {
              if (state is HomeLoading) {
                return LoadingPage();
              }
              if (state is HomeLoaded) {
                return ListView(
                  children: parseAccounts(state.accounts, context),
                );
              }
              return Container();
            },
          ),
        ));
  }

  List<Widget> parseAccounts(List<Account> accounts, context) {
    return List.from(accounts.map((element) {
      return CardAccount(account: element, requestAddSecret: () => requestAddSecret(context));
    }));
  }

  submitAccount(context, webPage, accUsername, accPassword) {
    print('$webPage, $accUsername, $accPassword');
    BlocProvider.of<HomeBloc>(context).add(AddAccountEvent(webPage, accUsername, accPassword));
  }

  saveSecretCallback(context, secret) {
    BlocProvider.of<HomeBloc>(context).add(AddSecretEvent(secret));
  }

  showSecret(context) async {
    String secret = await BiometricStorageUtil.read('secret') ?? 'No secret.';
    showDialog(
        context: context,
        builder: (builder) {
          return AlertDialog(
            content: ShowSecretDialog(secret: secret),
          );
        });
  }

  requestAddSecret(context) {
    BlocProvider.of<HomeBloc>(context).add(RequestAddSecretEvent());
  }
}
