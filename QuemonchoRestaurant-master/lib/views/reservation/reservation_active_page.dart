import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:foodly_restaurant/common/app_style.dart';
import 'package:foodly_restaurant/common/custom_btn.dart';
import 'package:foodly_restaurant/common/divida.dart';
import 'package:foodly_restaurant/common/reusable_text.dart';
import 'package:foodly_restaurant/common/row_text.dart';
import 'package:foodly_restaurant/constants/constants.dart';
import 'package:foodly_restaurant/controllers/reservation_controller.dart';
import 'package:foodly_restaurant/models/reservation_model.dart';
import 'package:foodly_restaurant/views/home/widgets/back_ground_container.dart';
import 'package:get/get.dart';

class ActivePageReservation extends StatefulWidget {
  final Reservation order;
  const ActivePageReservation({super.key, required this.order});

  @override
  State<ActivePageReservation> createState() => _ActivePageReservationState();
}

class _ActivePageReservationState extends State<ActivePageReservation> {
  String image =
      "https://d326fntlu7tb1e.cloudfront.net/uploads/5c2a9ca8-eb07-400b-b8a6-2acfab2a9ee2-image001.webp";

  @override
  Widget build(BuildContext context) {
    final orderController = Get.put(ReservationController());

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
          ),
        ),
        title: ReusableText(
          text: widget.order.user.email,
          style: appStyle(16, kGray, FontWeight.w500),
        ),
        backgroundColor: kOffWhite,
      ),
      body: BackGroundContainer(
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 15.w),
          child: ListView(
            physics: const NeverScrollableScrollPhysics(),
            children: [
              SizedBox(
                height: 10.h,
              ),
              Container(
                width: MediaQuery.of(context).size.width, // Updated
                height: MediaQuery.of(context).size.height / 3.5, // Updated
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20.r),
                ),
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 12.w),
                  decoration: BoxDecoration(
                    color: kOffWhite,
                    borderRadius: BorderRadius.circular(12.r),
                  ),
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
                          Expanded(
                            child: ReusableText(
                              text: widget.order.id,
                              style: appStyle(14, kGray, FontWeight.bold),
                             
                            ),
                          ),
                          CircleAvatar(
                            radius: 15,
                            backgroundColor: kTertiary,
                            backgroundImage: NetworkImage(
                              widget.order.user.profile,
                            ),
                          ),
                        ],
                      ),
                    
                      SizedBox(
                        height: 5.h,
                      ),
                      RowText(
                        first: "Reservation Status: ",
                        second: widget.order.status,
                      ),
                      SizedBox(
                        height: 5.h,
                      ),
                      RowText(
                        first: "Number Of Guests: ",
                        second: "${widget.order.numberOfGuests}",
                      ),
                      SizedBox(
                        height: 5.h,
                      ),
                      RowText(
                        first: "Recipient",
                        second: widget.order.user.email,
                      ),
                      SizedBox(
                        height: 5.h,
                      ),
                      GestureDetector(
                        onTap: () {},
                        child: RowText(
                          first: "Phone",
                          second: widget.order.user.phone,
                        ),
                      ),
                      const Divida(),
                      SizedBox(
                        height: 10.h,
                      ),
                      if (widget.order.status == "pending")
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Flexible(
                                child: CustomButton(
                                  onTap: () {
                                    orderController.processreservation(
                                      widget.order.id,
                                      "confirmed",
                                    );
                                    orderController.tabIndex = 1;
                                  },
                                  radius: 9.r,
                                  color: kPrimary,
                                  text: "Accept",
                                ),
                              ),
                           const   SizedBox(width: 10), // Add some space between buttons
                              Flexible(
                                child: CustomButton(
                                  onTap: () {
                                    orderController.processreservation(
                                      widget.order.id,
                                      "cancelled",
                                    );
                                    orderController.tabIndex = 6;
                                  },
                                  radius: 9.r,
                                  color: kRed,
                                  text: "Decline",
                                ),
                              ),
                            ],
                          ),
                        ),
                      SizedBox(
                        height: 10.h,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
