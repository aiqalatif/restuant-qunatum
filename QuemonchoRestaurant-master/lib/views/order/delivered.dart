import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:foodly_restaurant/common/app_style.dart';
import 'package:foodly_restaurant/common/custom_container.dart';
import 'package:foodly_restaurant/common/reusable_text.dart';
import 'package:foodly_restaurant/common/row_text.dart';
import 'package:foodly_restaurant/constants/constants.dart';
import 'package:foodly_restaurant/controllers/order_controller.dart';
import 'package:get/get.dart';

class DeliveredPage extends StatelessWidget {
  const DeliveredPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(OrdersController());
    return Scaffold(
        backgroundColor: kPrimary,
        appBar: AppBar(
          backgroundColor: kOffWhite,
          elevation: 0,
          leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: const Icon(
              Icons.arrow_back_ios,
              color: kDark,
            ),
          ),
        ),
        body: SafeArea(
          child: CustomContainer(
            containerContent: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.asset(
                  'assets/images/delivery.png',
                  height: hieght / 3,
                  width: width,
                ),
                SizedBox(
                  height: 20.h,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 12.0.w),
                  child: ReusableText(
                      text: "Order Delivered",
                      style: appStyle(20, kDark, FontWeight.bold)),
                ),
                Container(
                  margin: EdgeInsets.all(12.h),
                  padding: EdgeInsets.all(8.h),
                  height: 100,
                  decoration: BoxDecoration(
                    color: kLightWhite,
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                  child:  Column(
                    children: [
                      RowText(first: "Order Number", second: controller.order!.id, color: kDark,),
                      RowText(first: "Recipient No.", second: controller.order!.userId.phone, color: kDark),
                      const RowText(first: "Rating", second: '⭐ 5.0', color: kDark),
                       RowText(first: "Earnings", second: "\$ ${controller.order!.deliveryFee}", color: kDark),
                    ],
                  ),
                )
              ],
            ),
          ),
        ));
  }
}
