import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:password_manager/config/theme/colors.dart';
import 'package:password_manager/constants/app_constants.dart';
import 'package:password_manager/modules/home/bloc/home_bloc.dart';

class FormAddAccount extends StatelessWidget {
  const FormAddAccount({Key? key, required this.submitAccount})
      : super(key: key);
  final Function submitAccount;
  @override
  Widget build(BuildContext context) {
    String webPage = "";
    String accUsername = "";
    String accPassword = "";

    TextEditingController passwordController = TextEditingController();
    return SingleChildScrollView(
      // mainAxisSize: MainAxisSize.min,
      child: Form(
          child: Column(
        children: [
          Text('AÑADIR CUENTA',
              style: Theme.of(context).textTheme.headline3?.copyWith(
                    color: CustomColors.cultured,
                  )),
          Padding(
            padding: EdgeInsets.all(AppConstants.sizes[0])
                .copyWith(top: AppConstants.sizes[2]),
            child: TextField(
              style: Theme.of(context).textTheme.bodyText1,
              onChanged: (value) => {webPage = value},
              decoration: InputDecoration(hintText: 'web page'),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(AppConstants.sizes[0]),
            child: TextFormField(
              style: Theme.of(context).textTheme.bodyText1,
              decoration: InputDecoration(hintText: 'username'),
              onChanged: (value) => {accUsername = value},
            ),
          ),
          Padding(
            padding: EdgeInsets.all(AppConstants.sizes[0]),
            child: Column(children: [
              TextFormField(
                controller: passwordController,
                style: Theme.of(context).textTheme.bodyText1,
                decoration: InputDecoration(hintText: 'password'),
                onChanged: (value) => {},
              ),
              SizedBox(
                height: AppConstants.sizes[0],
              ),
              GestureDetector(
                onTap: () {
                  final Random _random = Random.secure();
                  var values =
                      List<int>.generate(32, (i) => _random.nextInt(255));
                  var pass = base64Encode(values).substring(0, 12);
                  passwordController.text = pass;
                },
                child: Text("Generar contraseña",
                    style: Theme.of(context).textTheme.bodyText2),
              ),
            ]),
          ),
          Padding(
            padding: EdgeInsets.all(AppConstants.sizes[1]),
            child: ElevatedButton(
              child: Text('Guardar'),
              onPressed: () {
                submitAccount(webPage, accUsername, passwordController.text);
                Navigator.of(context, rootNavigator: true).pop();
              },
            ),
          )
        ],
      )),
    );
  }
}
