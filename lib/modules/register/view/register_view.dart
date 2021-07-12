import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:password_manager/config/theme/colors.dart';
import 'package:password_manager/constants/app_constants.dart';
import 'package:password_manager/modules/register/bloc/register_bloc.dart';
import 'package:password_manager/widgets/register_alert.dart';

class RegisterView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    TextEditingController usernameController = TextEditingController();
    TextEditingController passwordController = TextEditingController();
    return Scaffold(
        resizeToAvoidBottomInset: false,
        extendBodyBehindAppBar: true,
        body: BlocListener<RegisterBloc, RegisterState>(listener: (context, state) {
          if (state is ErrorRegisterState) {
            final snackBar = SnackBar(content: Text(state.message));
            ScaffoldMessenger.of(context).showSnackBar(snackBar);
          }
          if (state is SuccessfullRegisteredState) {
            showDialog(
                context: context,
                builder: (BuildContext context) {
                  return SingleChildScrollView(
                    child: AlertDialog(
                      content: RegisterAlert(
                        continueCallback: continueCallback,
                        secret: state.secret,
                      ),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(AppConstants.sizes[1]))),
                    ),
                  );
                });
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
                      "REGISTRO",
                      style: Theme.of(context).textTheme.headline1,
                    ),
                    SvgPicture.asset(AppConstants.logoPath),
                    TextField(
                      style: Theme.of(context).textTheme.bodyText1,
                      decoration: InputDecoration(hintText: 'Usuario'),
                      controller: usernameController,
                    ),
                    TextField(
                      style: Theme.of(context).textTheme.bodyText1,
                      decoration: InputDecoration(hintText: 'Contraseña'),
                      controller: passwordController,
                    ),
                    BlocBuilder<RegisterBloc, RegisterState>(
                      builder: (context, state) {
                        if (state is LoadingRegisterState) {
                          return CircularProgressIndicator();
                        } else {
                          return GestureDetector(
                            child: Text("Registrarme", style: Theme.of(context).textTheme.subtitle2),
                            onTap: () => BlocProvider.of<RegisterBloc>(context)
                                .add(SubmitRegisterEvent(usernameController.text, passwordController.text)),
                          );
                        }
                      },
                    ),
                    SizedBox(
                      height: AppConstants.sizes[3],
                    )
                  ],
                )),
          );
        }))));
  }

  void continueCallback(context) {
    Navigator.popAndPushNamed(context, "/login");
  }
}
