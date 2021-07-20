import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:password_manager/config/theme/colors.dart';
import 'package:password_manager/constants/app_constants.dart';

class RegisterAlert extends StatelessWidget {
  const RegisterAlert(
      {Key? key, required this.continueCallback, required this.secret})
      : super(key: key);

  final Function continueCallback;
  final String secret;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'Llave de encriptación',
          textAlign: TextAlign.center,
          style: Theme.of(context)
              .textTheme
              .headline3
              ?.copyWith(color: CustomColors.cultured),
        ),
        SizedBox(
          height: AppConstants.sizes[2],
        ),
        Text(
            'Esta llave será solicitada cuando ingreses desde un nuevo dispositivo, puedes escribirla en algún lugar y ademas será guardada en la aplicación mediante un código QR.',
            style: Theme.of(context)
                .textTheme
                .bodyText1
                ?.copyWith(color: CustomColors.cultured),
            textAlign: TextAlign.justify),
        SizedBox(
          height: AppConstants.sizes[0],
        ),
        Text(secret,
            style: Theme.of(context)
                .textTheme
                .bodyText1
                ?.copyWith(color: CustomColors.cultured),
            textAlign: TextAlign.justify),
        SizedBox(
          height: AppConstants.sizes[2],
        ),
        Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
          ElevatedButton(
            child: Text('Copiar'),
            onPressed: () => {Clipboard.setData(ClipboardData(text: secret))},
          ),
          SizedBox(
            width: AppConstants.sizes[2],
          ),
          ElevatedButton(
            child: Text('Continuar'),
            onPressed: () => {continueCallback(context)},
          )
        ]),
      ],
    );
  }
}
