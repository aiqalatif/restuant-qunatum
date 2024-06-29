// ignore_for_file: unrelated_type_equality_checks, unused_local_variable

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:foodly_restaurant/common/app_style.dart';
import 'package:foodly_restaurant/common/divida.dart';
import 'package:foodly_restaurant/common/reusable_text.dart';
import 'package:foodly_restaurant/common/row_text.dart';
import 'package:foodly_restaurant/common/shimmers/foodlist_shimmer.dart';
import 'package:foodly_restaurant/constants/constants.dart';
import 'package:foodly_restaurant/controllers/order_controller.dart';
import 'package:foodly_restaurant/hooks/fetchOrderById.dart';
import 'package:foodly_restaurant/views/home/widgets/back_ground_container.dart';
import 'package:foodly_restaurant/views/home/widgets/notification_tile.dart';
import 'package:get/get.dart';

class NotificationOrderPage extends StatefulHookWidget {
  const NotificationOrderPage({super.key});

  @override
  State<NotificationOrderPage> createState() => _NotificationOrderPageState();
}

class _NotificationOrderPageState extends State<NotificationOrderPage> {
  String image =
      "https://d326fntlu7tb1e.cloudfront.net/uploads/5c2a9ca8-eb07-400b-b8a6-2acfab2a9ee2-image001.webp";

  @override
  Widget build(BuildContext context) {
    final orderController = Get.put(OrdersController());
    final message =
        ModalRoute.of(context)!.settings.arguments as NotificationResponse;

    var orderData = jsonDecode(message.payload.toString());

    final results = fetchOrder(orderData['orderId']);

    final isLoading = results.isLoading;
    final data = results.data;

    if (isLoading) {
      return Scaffold(
          appBar: AppBar(
            title: ReusableText(
                text: "Data Loading",
                style: appStyle(16, kGray, FontWeight.w500)),
          ),
          body: const FoodsListShimmer());
    }

    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          centerTitle: true,
          leading: InkWell(
              onTap: () {
                Get.back();
              },
              child: const Icon(
                Icons.arrow_back_ios,
                color: kPrimary,
              )),
          title: ReusableText(
              text: data!.id, style: appStyle(16, kGray, FontWeight.w500)),
          backgroundColor: kOffWhite,
        ),
        body: BackGroundContainer(
            child: Container(
          margin: EdgeInsets.symmetric(horizontal: 12.w),
          child: ListView(
            physics: const NeverScrollableScrollPhysics(),
            children: [
              SizedBox(
                height: 10.h,
              ),
              NotificationTile(
                order: data,
                active: "",
              ),
              Container(
                width: width,
                height: hieght / 3.5,
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(20.r)),
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 12.w),
                  decoration: BoxDecoration(
                      color: kOffWhite,
                      borderRadius: BorderRadius.circular(12.r)),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 5.h,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          ReusableText(
                              text: data.orderItems[0].foodId.title,
                              style: appStyle(14, kGray, FontWeight.bold)),
                          CircleAvatar(
                            radius: 14,
                            backgroundColor: kTertiary,
                            backgroundImage: NetworkImage(image),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 5.h,
                      ),
                      RowText(first: "Order Status", second: data.orderStatus),
                      SizedBox(
                        height: 5.h,
                      ),
                      RowText(first: "Quantity", second: "${data.orderItems[0].quantity}"),
                      SizedBox(
                        height: 5.h,
                      ),
                      RowText(first: "Recipient", second: data.deliveryAddress.addressLine1),
                      SizedBox(
                        height: 5.h,
                      ),
                      GestureDetector(
                        onTap: () {},
                        child: RowText(first: "Phone ", second: data.userId.phone),
                      ),
                      const Divida(),
                      ReusableText(
                          text: "Additives ",
                          style: appStyle(12, kGray, FontWeight.w500)),
                      SizedBox(
                        height: 5.h,
                      ),
                      SizedBox(
                        height: 15.h,
                        child: ListView.builder(
                            itemCount: data.orderItems[0].additives.length,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, i) {
                              final addittive = data.orderItems[0].additives[i];
                              return Container(
                                margin: EdgeInsets.only(right: 5.h),
                                decoration: BoxDecoration(
                                    color: kPrimary,
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(15.r))),
                                child: Center(
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 4.0),
                                    child: ReusableText(
                                        text: addittive,
                                        style: appStyle(
                                            8, kLightWhite, FontWeight.w400)),
                                  ),
                                ),
                              );
                            }),
                      ),
                      const Divida(),
                      SizedBox(
                        height: 5.h,
                      ),
                      // orderController.order!.orderStatus == "Placed"
                      //     ? Row(
                      //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      //         children: [
                      //           CustomButton(
                      //               onTap: () {
                      //                 orderController.processOrder(
                      //                     orderController.order!.id,
                      //                     "Preparing");
                      //                 orderController.tabIndex = 1;
                      //               },
                      //               btnWidth: width / 2.5,
                      //               radius: 9.r,
                      //               color: kPrimary,
                      //               text: "Accept"),
                      //           CustomButton(
                      //               onTap: () {
                      //                 orderController.processOrder(
                      //                     orderController.order!.id,
                      //                     "Cancelled");
                      //                     orderController.tabIndex = 5;
                      //               },
                      //               color: kRed,
                      //               radius: 9.r,
                      //               btnWidth: width / 2.5,
                      //               text: "Decline")
                      //         ],
                      //       )
                      //     : const SizedBox.shrink(),

                      //     orderController.order!.orderStatus == "Preparing"
                      //     ? Row(
                      //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      //         children: [
                      //           CustomButton(
                      //               onTap: () {
                      //                 orderController.processOrder(
                      //                     orderController.order!.id,
                      //                     "Ready");
                      //                 orderController.tabIndex = 2;
                      //               },
                      //               btnWidth: width / 2.5,
                      //               radius: 9.r,
                      //               color: kPrimary,
                      //               text: "Push to Couriers"),
                      //           CustomButton(
                      //               onTap: () {
                      //                 orderController.processOrder(
                      //                     orderController.order!.id,
                      //                     "Manual");
                      //                     orderController.tabIndex = 3;
                      //               },
                      //               color: kSecondary,
                      //               radius: 9.r,
                      //               btnWidth: width / 2.5,
                      //               text: "Self Delivery")
                      //         ],
                      //       )
                      //     : const SizedBox.shrink(),

                      //     orderController.order!.orderStatus == "Manual"
                      //     ? CustomButton(
                      //         onTap: () {
                      //           orderController.processOrder(
                      //               orderController.order!.id,
                      //               "Out_for_Delivery");
                      //               orderController.tabIndex = 4;
                      //         },
                      //         color: kSecondary,
                      //         radius: 9.r,
                      //         btnWidth: width,
                      //         text: "Mark As Delivered")
                      //     : const SizedBox.shrink(),

                      //     orderController.order!.orderStatus == "Ready"
                      //     ? CustomButton(
                      //         onTap: () {
                      //           // orderController.processOrder(
                      //           //     orderController.order!.id,
                      //           //     "Manual");
                      //           //     orderController.tabIndex = 4;
                      //         },
                      //         color: kSecondary,
                      //         radius: 9.r,
                      //         btnWidth: width,
                      //         text: "Self Delivery")
                      //     : const SizedBox.shrink()
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 10.h,
              ),
            ],
          ),
        )));
  }
}
