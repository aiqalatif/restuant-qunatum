import 'package:flutter/material.dart';
import 'package:foodly_restaurant/common/app_style.dart';
import 'package:foodly_restaurant/common/reusable_text.dart';
import 'package:foodly_restaurant/constants/constants.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({super.key, required this.text, this.color, this.onTap, this.btnWidth, this.radius, this.btnHieght});

  final String text;
  final Color? color;
  final double? btnWidth;
  final double? btnHieght;
  final double? radius;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 
         btnWidth ?? width,
        height: btnHieght??28,
        decoration:  BoxDecoration(
            color: color?? kSecondary,
            borderRadius:  BorderRadius.all(Radius.circular(radius??12))),
        child: Center(
          child: ReusableText(
              text: text,
              style: appStyle(12,  kLightWhite, FontWeight.w500)),
        ),
      )
    );
  }
}
