import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:foodly_restaurant/common/app_style.dart';
import 'package:foodly_restaurant/constants/constants.dart';
import 'package:foodly_restaurant/controllers/password_controller.dart';
import 'package:get/get.dart';

class PasswordField extends StatelessWidget {
  const PasswordField({
    super.key,
    required this.controller,
    this.focusNode,
  });

  final TextEditingController controller;
  final FocusNode? focusNode;
  @override
  Widget build(BuildContext context) {
    final passwordController = Get.put(PasswordController());
    return Obx(() => Padding(
          padding: const EdgeInsets.only(bottom: 10.0),
          child: TextFormField(
            cursorColor: Colors.black,
            textInputAction: TextInputAction.next,
            focusNode: focusNode,
            keyboardType: TextInputType.visiblePassword,
            controller: controller,
            obscureText: passwordController.password,
            validator: (value) {
              if (value!.isEmpty) {
                return "Please enter a valid password";
              } else {
                return null;
              }
            },
            style: appStyle(12, kDark, FontWeight.normal),
            decoration: InputDecoration(
              suffixIcon: GestureDetector(
                onTap: () {
                  passwordController.setPassword =
                      !passwordController.password;
                },
                child: Icon(
                  passwordController.password
                      ? Icons.visibility
                      : Icons.visibility_off,
                  color: kGrayLight,
                ),
              ),
              hintText: 'Password ',
              prefixIcon: const Icon(
                CupertinoIcons.lock_circle,
                color: kGrayLight,
                size: 26,
              ),
              isDense: true,
              contentPadding: const EdgeInsets.all(6),
              hintStyle: appStyle(12, kGray, FontWeight.normal),
              // contentPadding: EdgeInsets.only(left: 24),
              errorBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.red, width: 0.5),
                  borderRadius: BorderRadius.all(Radius.circular(12))),
              focusedBorder: const OutlineInputBorder(
                  borderSide:
                      BorderSide(color: kPrimary, width: 0.5),
                  borderRadius:  BorderRadius.all(Radius.circular(12))),
              focusedErrorBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: kRed, width: 0.5),
                  borderRadius: BorderRadius.all(Radius.circular(12))),
              disabledBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: kGray, width: 0.5),
                  borderRadius: BorderRadius.all(Radius.circular(12))),
              enabledBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: kGray, width: 0.5),
                  borderRadius: BorderRadius.all(Radius.circular(12))),
              border: const OutlineInputBorder(
                borderSide:
                    BorderSide(color: kPrimary, width: 0.5),
                borderRadius:  BorderRadius.all(
                  Radius.circular(12),
                ),
              ),
            ),
          ),
        )
      );
    
  }
}