import 'package:flutter/material.dart';
import 'package:password_manager/constants/app_constants.dart';
import 'package:qrcode_reader/qrcode_reader.dart';

class InputSecretForm extends StatelessWidget {
  const InputSecretForm({Key? key, required this.saveSecretCallback}) : super(key: key);
  final Function saveSecretCallback;

  @override
  Widget build(BuildContext context) {
    TextEditingController secretCrontoller = TextEditingController();
    return Column(mainAxisSize: MainAxisSize.min, children: [
      Row(
        children: [
          Expanded(
            child: TextFormField(
              style: Theme.of(context).textTheme.bodyText1,
              controller: secretCrontoller,
              decoration: InputDecoration(hintText: 'Llave de encript.'),
            ),
          ),
          SizedBox(
            width: AppConstants.sizes[0],
          ),
          ElevatedButton(
            child: Icon(Icons.qr_code),
            onPressed: () {
              setQrData(secretCrontoller);
            },
          )
        ],
      ),
      SizedBox(
        height: AppConstants.sizes[2],
      ),
      Row(
        children: [
          ElevatedButton(
            child: Text('Cancelar'),
            onPressed: () {
              saveSecretCallback(secretCrontoller.text);
              Navigator.pop(context);
            },
          ),
          Spacer(),
          ElevatedButton(
            child: Text('Guardar'),
            onPressed: () {
              saveSecretCallback(secretCrontoller.text);
              Navigator.pop(context);
            },
          )
        ],
      )
    ]);
  }

  setQrData(TextEditingController secretController) async {
    print('STARTING CAMERA');
    String futureString = await QRCodeReader().scan();
    secretController.text = futureString;
  }
}
