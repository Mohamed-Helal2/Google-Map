
import 'package:flutter/material.dart';

class map_style_photo extends StatelessWidget {
  const map_style_photo({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: 3),
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: Colors.blue, width: 2),
          borderRadius: BorderRadius.circular(20)),
      height: 65,
      width: 65,
      child: ClipRRect(
          borderRadius: BorderRadius.circular(15),
          child: Image.asset(
            'assets/photo/style.png',
            fit: BoxFit.fill,
          )),
    );
  }
}
