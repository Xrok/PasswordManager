import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:password_manager/config/theme/colors.dart';
import 'package:password_manager/constants/app_constants.dart';

class CardAccount extends StatefulWidget {
  final Function decryptInfo;
  final String webPage;

  const CardAccount(
      {Key? key, required this.decryptInfo, required this.webPage})
      : super(key: key);

  @override
  State<CardAccount> createState() => _CardAccountState();
}

class _CardAccountState extends State<CardAccount> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
          vertical: AppConstants.sizes[0], horizontal: AppConstants.sizes[1]),
      padding: EdgeInsets.all(AppConstants.sizes[1]),
      height: 150,
      decoration: BoxDecoration(
          border: Border.all(color: CustomColors.magicMint, width: 2),
          borderRadius:
              BorderRadius.all(Radius.circular(AppConstants.sizes[2]))),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SvgPicture.asset(
            AppConstants.logoPath,
            height: 50,
          ),
          SizedBox(
            width: AppConstants.sizes[1],
          ),
          Column(
            children: [
              Text(
                "data",
                style: Theme.of(context).textTheme.subtitle2,
              ),
              Text("data", style: Theme.of(context).textTheme.bodyText1),
              Text("data", style: Theme.of(context).textTheme.bodyText1)
            ],
          ),
          const Spacer(),
          Column(children: [
            const Spacer(),
            ElevatedButton(
              onPressed: () => widget.decryptInfo(),
              child: Text(
                "MOSTRAR",
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
