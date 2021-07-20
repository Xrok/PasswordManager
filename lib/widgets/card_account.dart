import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:password_manager/config/theme/colors.dart';
import 'package:password_manager/constants/app_constants.dart';
import 'package:password_manager/core/general_exception.dart';
import 'package:password_manager/repository/user/models/account.dart';
import 'package:password_manager/utils/biometric_storage_util.dart';
import 'package:encrypt/encrypt.dart' as enc;

class CardAccount extends StatefulWidget {
  final Account account;

  const CardAccount({Key? key, required this.account}) : super(key: key);

  @override
  State<CardAccount> createState() => _CardAccountState();
}

class _CardAccountState extends State<CardAccount> {
  bool isEncrypted = true;

  decryptInfo() async {
    String keyBase64;
    try {
      keyBase64 = await BiometricStorageUtil.read('secret') ?? '';
      if (keyBase64.isEmpty) {
        print('ga'); //TODO pedir que ingrese el key
      }
      final key = enc.Key.fromBase64(keyBase64);
      final iv = enc.IV.fromLength(16);
      final encrypter = enc.Encrypter(enc.AES(key));
      final encryptedUser = enc.Encrypted.from64(widget.account.username);
      final encryptedPassword = enc.Encrypted.from64(widget.account.password);
      setState(() {
        widget.account.username = encrypter.decrypt(encryptedUser, iv: iv);
        widget.account.password = encrypter.decrypt(encryptedPassword, iv: iv);
        isEncrypted = !isEncrypted;
      });
    } on GeneralException catch (e) {
      print(e.message);
    } catch (e) {
      print('Decryption Error');
    }
  }

  encryptInfo() async {
    String keyBase64;
    try {
      keyBase64 = await BiometricStorageUtil.read('secret') ?? '';
      final key = enc.Key.fromBase64(keyBase64);
      final iv = enc.IV.fromLength(16);
      final encrypter = enc.Encrypter(enc.AES(key));
      final decryptedUser = widget.account.username;
      final decryptedPassword = widget.account.password;
      setState(() {
        widget.account.username =
            encrypter.encrypt(decryptedUser, iv: iv).base64;
        widget.account.password =
            encrypter.encrypt(decryptedPassword, iv: iv).base64;
        isEncrypted = !isEncrypted;
      });
    } on GeneralException catch (e) {
      print(e.message);
    } catch (e) {
      print('Decryption Error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
          vertical: AppConstants.sizes[0], horizontal: AppConstants.sizes[1]),
      padding: EdgeInsets.all(AppConstants.sizes[1]),
      // height: 150,
      decoration: BoxDecoration(
          border: Border.all(color: CustomColors.magicMint, width: 2),
          borderRadius:
              BorderRadius.all(Radius.circular(AppConstants.sizes[2]))),
      child: Wrap(
        runAlignment: WrapAlignment.spaceBetween,
        alignment: WrapAlignment.spaceAround,
        crossAxisAlignment: WrapCrossAlignment.center,
        runSpacing: AppConstants.sizes[0],
        children: [
          SvgPicture.asset(
            AppConstants.logoPath,
            height: 50,
          ),
          SizedBox(
            width: AppConstants.sizes[1],
          ),
          Column(
            // mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                widget.account.webPage,
                style: Theme.of(context).textTheme.subtitle2,
              ),
              Text(
                isEncrypted ? "••••••" : widget.account.username,
                style:
                    Theme.of(context).textTheme.bodyText1, //TODO Obscure text
              ),
              Text(isEncrypted ? "••••••" : widget.account.password,
                  style: Theme.of(context).textTheme.bodyText1)
            ],
          ),
          // const Spacer(),
          Column(children: [
            // const Spacer(),
            ElevatedButton(
              onPressed: () => isEncrypted ? decryptInfo() : encryptInfo(),
              child: Text(
                isEncrypted ? "MOSTRAR" : "OCULTAR",
                style: Theme.of(context)
                    .textTheme
                    .button
                    ?.copyWith(color: CustomColors.richBlack),
              ),
            )
          ])
        ],
      ),
    );
  }
}
