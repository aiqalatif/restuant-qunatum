import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:foodly_restaurant/constants/constants.dart';

// ignore: must_be_immutable
class CustomContainer extends StatelessWidget {
  CustomContainer({
    super.key,
    this.containerContent,
  });

  Widget? containerContent;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: hieght * 0.73,
        child: ClipRRect(
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(30.r),
              bottomRight: Radius.circular(30.r)),
          child: Container(
            width: width,
            color: kOffWhite,
            child: SingleChildScrollView(child: containerContent),
          ),
        ));
  }
}
