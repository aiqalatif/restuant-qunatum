import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:foodly_restaurant/common/app_style.dart';
import 'package:foodly_restaurant/common/custom_btn.dart';
import 'package:foodly_restaurant/common/reusable_text.dart';
import 'package:foodly_restaurant/constants/constants.dart';
import 'package:foodly_restaurant/controllers/email_verification_controller.dart';
import 'package:otp_text_field/otp_text_field.dart';
import 'package:otp_text_field/style.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

class VerificationPage extends StatelessWidget {
  const VerificationPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(EmailVerificationController());
    return Scaffold(
      backgroundColor: Colors.white,
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        children: [
          SizedBox(
            height: 100.h,
          ),
          Lottie.asset('assets/anime/delivery.json'),
          SizedBox(
            height: 30.h,
          ),
          ReusableText(
              text: "Verify Your Account",
              style: appStyle(20, kPrimary, FontWeight.bold)),
          Text(
              "Enter the code sent to your email, if you did not send recieve the code, click resend",
              style: appStyle(10, kGrayLight, FontWeight.normal)),
          SizedBox(
            height: 20.h,
          ),
          OTPTextField(
            length: 6,
            width: width,
            fieldWidth: 50.h,
            style: const TextStyle(fontSize: 17),
            textFieldAlignment: MainAxisAlignment.spaceAround,
            fieldStyle: FieldStyle.underline,
            onChanged: (pin) {},
            onCompleted: (pin) {
              controller.code = pin;
            },
          ),
          SizedBox(
            height: 20.h,
          ),
          CustomButton(
            onTap: () {
              controller.verifyEmail();
            },
            color: kPrimary,
            text: "Verify Account",
            btnHieght: 40.h,
          )
        ],
      ),
    );
  }
}
