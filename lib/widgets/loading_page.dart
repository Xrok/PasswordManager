import 'package:flutter/material.dart';
import 'package:password_manager/config/theme/colors.dart';

class LoadingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).backgroundColor,
      child: const Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
