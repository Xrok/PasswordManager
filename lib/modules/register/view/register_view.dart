import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:password_manager/constants/app_constants.dart';

class RegisterView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: AppConstants.sizes[3], vertical: 0.0),
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
              ),
              TextField(
                style: Theme.of(context).textTheme.bodyText1,
                decoration: InputDecoration(hintText: 'Contraseña'),
              ),
              GestureDetector(
                child: Text("Registrarme",
                    style: Theme.of(context).textTheme.subtitle2),
                onTap: () => Navigator.popAndPushNamed(context, "/login"),
              ),
              SizedBox(
                height: AppConstants.sizes[3],
              )
            ],
          )),
    ));
  }
}
