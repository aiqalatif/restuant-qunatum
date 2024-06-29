// ignore_for_file: unrelated_type_equality_checks, unused_local_variable

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:foodly_restaurant/common/app_style.dart';
import 'package:foodly_restaurant/common/custom_btn.dart';
import 'package:foodly_restaurant/common/divida.dart';
import 'package:foodly_restaurant/common/reusable_text.dart';
import 'package:foodly_restaurant/common/row_text.dart';
import 'package:foodly_restaurant/constants/constants.dart';
import 'package:foodly_restaurant/controllers/order_controller.dart';
import 'package:foodly_restaurant/views/home/widgets/back_ground_container.dart';
import 'package:foodly_restaurant/views/home/widgets/order_tile.dart';
import 'package:get/get.dart';

class ActivePage extends StatefulWidget {
  const ActivePage({super.key});

  @override
  State<ActivePage> createState() => _ActivePageState();
}

class _ActivePageState extends State<ActivePage> {
  String image =
      "https://d326fntlu7tb1e.cloudfront.net/uploads/5c2a9ca8-eb07-400b-b8a6-2acfab2a9ee2-image001.webp";

  @override
  Widget build(BuildContext context) {
    final orderController = Get.put(OrdersController());

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
              text:  orderController
                                  .order!.orderItems[0].foodId.title,
              style: appStyle(16, kGray, FontWeight.w500)),
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
              OrderTile(
                order: orderController.order!,
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
                              text: orderController
                                  .order!.orderItems[0].foodId.title,
                              style: appStyle(14, kGray, FontWeight.bold)),
                          CircleAvatar(
                            radius: 14,
                            backgroundColor: kTertiary,
                            backgroundImage: NetworkImage(orderController
                                .order!.orderItems[0].foodId.imageUrl[0]),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 5.h,
                      ),
                       RowText(first: "Order Status", second: orderController.order!.orderStatus),
                      SizedBox(
                        height: 5.h,
                      ),
                      RowText(
                          first: "Quantity",
                          second:
                              "${orderController.order!.orderItems[0].quantity}"),
                      SizedBox(
                        height: 5.h,
                      ),
                      RowText(
                          first: "Recipient",
                          second:
                              orderController.order!.deliveryAddress.addressLine1),
                      SizedBox(
                        height: 5.h,
                      ),
                      GestureDetector(
                        onTap: () {},
                        child: RowText(
                            first: "Phone ",
                            second: orderController.order!.userId.phone),
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
                            itemCount: orderController
                                .order!.orderItems[0].additives.length,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, i) {
                              final addittive = orderController
                                  .order!.orderItems[0].additives[i];
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
orderController.order!.orderStatus == "Pending"
    ? Padding(
        padding:const EdgeInsets.symmetric(horizontal: 20.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
              child: CustomButton(
                  onTap: () {
                    orderController.processOrder(
                        orderController.order!.id, "Preparing");
                    orderController.tabIndex = 1;
                  },
                  radius: 9.r,
                  color: kPrimary,
                  text: "Accept"),
            ),
          const  SizedBox(width: 10), // Add some space between buttons
            Flexible(
              child: CustomButton(
                  onTap: () {
                    orderController.processOrder(
                        orderController.order!.id, "Cancelled");
                    orderController.tabIndex = 6;
                  },
                  color: kRed,
                  radius: 9.r,
                  text: "Decline"),
            ),
          ],
        ),
      )
    : const SizedBox.shrink(),
orderController.order!.orderStatus == "Preparing"
    ? Padding(
        padding:const EdgeInsets.symmetric(horizontal: 20.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
              child: CustomButton(
                  onTap: () {
                    orderController.processOrder(
                        orderController.order!.id, "Ready");
                    orderController.tabIndex = 2;
                  },
                  radius: 9.r,
                  color: kPrimary,
                  text: "Push to Couriers"),
            ),
           const SizedBox(width: 10), // Add some space between buttons
            Flexible(
              child: CustomButton(
                  onTap: () {
                    orderController.processOrder(
                        orderController.order!.id, "Manual");
                    orderController.tabIndex = 4;
                  },
                  color: kSecondary,
                  radius: 9.r,
                  text: "Self Delivery"),
            ),
          ],
        ),
      )
    : const SizedBox.shrink(),
orderController.order!.orderStatus == "Manual"
    ? Padding(
        padding:const EdgeInsets.symmetric(horizontal: 20.0),
        child: CustomButton(
            onTap: () {
              orderController.processOrder(
                  orderController.order!.id, "Delivered");
              orderController.tabIndex = 5;
            },
            color: kSecondary,
            radius: 9.r,
            btnWidth: double.infinity, // Make the button take full width
            text: "Mark As Delivered"),
      )
    : const SizedBox.shrink(),
orderController.order!.orderStatus == "Ready"
    ? Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: CustomButton(
            onTap: () {
              orderController.processOrder(
                  orderController.order!.id, "Manual");
              orderController.tabIndex = 5;
            },
            color: kSecondary,
            radius: 9.r,
            btnWidth: double.infinity, // Make the button take full width
            text: "Self Delivery"),
      )
    : const SizedBox.shrink(),

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
