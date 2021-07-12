import 'package:flutter/material.dart';
import 'package:password_manager/config/theme/colors.dart';
import 'package:qr_flutter/qr_flutter.dart';

class ShowSecretDialog extends StatelessWidget {
  const ShowSecretDialog({Key? key, required this.secret}) : super(key: key);

  final String secret;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          secret,
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.bodyText1?.copyWith(color: CustomColors.cultured),
        ),
        QrImage(data: secret),
        ElevatedButton(
          child: Text('Ok 😶‍🌫️'),
          onPressed: () => Navigator.pop(context),
        )
      ],
    );
  }
}
