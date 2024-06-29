import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:foodly_restaurant/common/app_style.dart';
import 'package:foodly_restaurant/common/custom_container.dart';
import 'package:foodly_restaurant/constants/constants.dart';

class NoSelection extends StatelessWidget {
  const NoSelection({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimary,
      appBar: AppBar(
        backgroundColor: kOffWhite,
        elevation: 0,
      ),
      body: CustomContainer(
        containerContent: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/delivery.png',
              height: ScreenUtil().setHeight(200),
              width: ScreenUtil().setHeight(200),
            ),
            SizedBox(height: 20.h),
            Center(
              child: Text(
                "No selected orders",
                style: appStyle(20, kDark, FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
