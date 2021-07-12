import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:password_manager/config/theme/colors.dart';
import 'package:password_manager/constants/app_constants.dart';
import 'package:password_manager/repository/user/models/account.dart';

class CardAccount extends StatefulWidget {
  final Function decryptInfo;
  final Account account;

  const CardAccount({Key? key, required this.decryptInfo, required this.account}) : super(key: key);

  @override
  State<CardAccount> createState() => _CardAccountState();
}

class _CardAccountState extends State<CardAccount> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: AppConstants.sizes[0], horizontal: AppConstants.sizes[1]),
      padding: EdgeInsets.all(AppConstants.sizes[1]),
      // height: 150,
      decoration: BoxDecoration(
          border: Border.all(color: CustomColors.magicMint, width: 2),
          borderRadius: BorderRadius.all(Radius.circular(AppConstants.sizes[2]))),
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
              Text(widget.account.username, style: Theme.of(context).textTheme.bodyText1),
              Text(widget.account.password, style: Theme.of(context).textTheme.bodyText1)
            ],
          ),
          // const Spacer(),
          Column(children: [
            // const Spacer(),
            ElevatedButton(
              onPressed: () => widget.decryptInfo(),
              child: Text(
                "MOSTRAR",
                style: Theme.of(context).textTheme.button?.copyWith(color: CustomColors.richBlack),
              ),
            )
          ])
        ],
      ),
    );
  }
}
