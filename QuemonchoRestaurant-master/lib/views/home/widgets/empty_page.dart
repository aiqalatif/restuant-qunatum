import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:foodly_restaurant/constants/constants.dart';

class EmptyPage extends StatelessWidget {
  const EmptyPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Padding(
        padding:  EdgeInsets.all(12.0.h),
        child: ClipRRect(
          borderRadius: BorderRadius.all(Radius.circular(20.r),
          ),
          child: Image.asset('assets/images/empty.png', width: width, fit: BoxFit.fitWidth,)),
      ),
    );
  }
}