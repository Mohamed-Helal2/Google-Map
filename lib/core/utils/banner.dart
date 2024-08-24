import 'package:flutter/material.dart';

class showmaterialbanner {
  void showbanner(
      {required BuildContext context,
      required String message,
      required Color color,
      Widget? leading}) {
    ScaffoldMessenger.of(context).showMaterialBanner(MaterialBanner(
      padding: EdgeInsets.all(20),
      content: Text(message),
      leading: leading,
      actions: [
        SizedBox.shrink(),
      ],
    ));
  }
}
