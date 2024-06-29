import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:foodly_restaurant/common/app_style.dart';
import 'package:foodly_restaurant/constants/constants.dart';

class DescriptionField extends StatelessWidget {
  const DescriptionField({
    super.key,
    this.prefixIcon,
    this.keyboardType,
    this.onEditingComplete,
    this.controller,
    this.hintText,
    this.focusNode,
    this.initialValue, this.maxLines,
  });
  final String? hintText;
  final Widget? prefixIcon;
  final TextInputType? keyboardType;
  final void Function()? onEditingComplete;
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final String? initialValue;
  final int? maxLines;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
        cursorColor: Colors.black,
        textInputAction: TextInputAction.next,
        maxLines: maxLines,
        onEditingComplete: onEditingComplete,
        keyboardType: keyboardType,
        initialValue: initialValue,
        controller: controller,
        validator: (value) {
          if (value!.isEmpty) {
            return "Please enter a valid value";
          } else {
            return null;
          }
        },
        style: appStyle(12, kDark, FontWeight.normal),
        decoration: InputDecoration(
          hintText: hintText,
          isDense: true,
          contentPadding:  EdgeInsets.all(8.h),
          hintStyle: appStyle(12, kGray, FontWeight.normal),
          // contentPadding: EdgeInsets.only(left: 24),
          errorBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.red, width: 0.5),
              borderRadius: BorderRadius.all(Radius.circular(12))),
          focusedBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: kPrimary, width: 0.5),
              borderRadius: BorderRadius.all(Radius.circular(12))),
          focusedErrorBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.red, width: 0.5),
              borderRadius: BorderRadius.all(Radius.circular(12))),
          disabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: kGray, width: 0.5),
              borderRadius: BorderRadius.all(Radius.circular(12))),
          enabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: kGray, width: 0.5),
              borderRadius: BorderRadius.all(Radius.circular(12))),
          border: const OutlineInputBorder(
            borderSide: BorderSide(color: kPrimary, width: 0.5),
            borderRadius: BorderRadius.all(
              Radius.circular(12),
            ),
          ),
        ));
  }
}
