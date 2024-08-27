import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class failureWidget extends StatelessWidget {
  const failureWidget({
    super.key,
    required this.message
  });
final String message;

  @override
  Widget build(BuildContext context) {
    return Container(
       width: 240.w,
      decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(50)),
          color: Color(0xff2D2D37)),
      child: ListTile(
        leading: Container(
          padding: const EdgeInsets.all(1),
          child: Image.asset(
            "assets/photo/remove.png",
            height: 25,
          ),
        ),
        title: Text(
       message,
          style: TextStyle(
              fontSize: 12.sp,
              color: Colors.white,
              fontWeight: FontWeight.normal),
        ),
      ),
    );
  }
}