// ignore_for_file: must_be_immutable

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:foodly_restaurant/common/app_style.dart';
import 'package:foodly_restaurant/common/reusable_text.dart';
import 'package:foodly_restaurant/constants/constants.dart';
import 'package:foodly_restaurant/controllers/login_controller.dart';
import 'package:foodly_restaurant/controllers/restaurant_controller.dart';
import 'package:foodly_restaurant/controllers/updates_controllers/new_orders_controller.dart';
import 'package:foodly_restaurant/controllers/updates_controllers/picked_controller.dart';
import 'package:foodly_restaurant/controllers/updates_controllers/ready_for_pick_up_controller.dart';
import 'package:foodly_restaurant/views/profile/profile_page.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class CustomAppBar extends StatelessWidget {
  CustomAppBar({
    super.key,
    this.type,
    this.title,
    this.heading,
    this.onTap,
  });

  final bool? type;
  final String? title;
  final String? heading;
  final void Function()? onTap;

  Stream<Map<String, dynamic>> restaurantStream(String restaurantId) {
    DatabaseReference restaurantRef =
        FirebaseDatabase.instance.ref(restaurantId);

    return restaurantRef.onValue.map((event) {
      final restaurantData = event.snapshot.value as Map<dynamic, dynamic>;

      return Map<String, dynamic>.from(restaurantData);
    });
  }

  @override
  Widget build(BuildContext context) {
    final box = GetStorage();
    final restaurantController = Get.put(RestaurantController());
    final outForDeliveryController = Get.put(ReadyForPickUpController());
    final pickedController = Get.put(PickedController());
    final newOrderController = Get.put(NewOrdersController());
    final controller = Get.put(LoginController());
    bool? status = box.read('status');
    String id = box.read('restaurantId');
    // restaurantController.restaurant = controller.getRestaurantData(id);

    restaurantController.setStatus = status ?? false;
    return Container(
      width: width,
      padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 6),
      height: 100,
      color: kLightWhite,
      child: Stack(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  GestureDetector(
                    onTap: () {
                      Get.to(() => const ProfilePage(),
                      transition: Transition.cupertino,
                      duration: const Duration(milliseconds: 900)
                      );
                    },
                    child: CircleAvatar(
                      radius: 16.r,
                      backgroundColor: kTertiary,
                      backgroundImage: NetworkImage(
                          restaurantController.restaurant == null
                              ? profile
                              : restaurantController.restaurant!.logoUrl),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0, bottom: 0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ReusableText(
                            text: heading != null
                                ? heading ?? ""
                                : restaurantController.restaurant == null
                                    ? ""
                                    : restaurantController.restaurant!.title,
                            style: appStyle(13, kSecondary, FontWeight.w600)),
                        SizedBox(
                          width: width * 0.65,
                          child: ReusableText(
                              text: title != null
                                  ? title ?? ""
                                  : restaurantController.restaurant == null
                                      ? ""
                                      : restaurantController
                                          .restaurant!.coords.address,
                              style: appStyle(11, kGray, FontWeight.normal)),
                        )
                      ],
                    ),
                  ),
                ],
              ),
              GestureDetector(
                onTap: onTap,
                child: Obx(
                  () => SvgPicture.asset(
                    restaurantController.status
                        ? 'assets/icons/open_sign.svg'
                        : 'assets/icons/closed_sign.svg',
                    height: 35.h,
                    width: 35.w,
                  ),
                ),
              ),
            ],
          ),
          type != true
              ? Positioned(
                  top: 45,
                  left: 0,
                  child: GestureDetector(
                    onTap: () {
                      Get.back();
                    },
                    child: const Icon(
                      AntDesign.closecircle,
                      color: kRed,
                      size: 18,
                    ),
                  ))
              : const SizedBox.shrink(),
          StreamBuilder<Map<String, dynamic>>(
              stream: restaurantStream(id),
              builder: (BuildContext context,
                  AsyncSnapshot<Map<String, dynamic>> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const SizedBox(); // Show loading indicator while waiting for data
                }
                if (snapshot.hasError) {
                  return const SizedBox(); // Handle errors from the stream
                }

                // The stream has data, so display the appropriate UI
                if (!snapshot.hasData) {
                  return const SizedBox();
                }
                String lastOrder = 'updated';
                String status = "none";

                Map<String, dynamic> restaurantData = snapshot.data!;

                if (lastOrder != restaurantData['order_id'] &&
                    status != restaurantData['status']) {
                  lastOrder = restaurantData['order_id'];
                  status = restaurantData['status'];

                  if (restaurantData['status'] == "Out_for_Delivery") {
                    outForDeliveryController.refetch.value = true;
                    Future.delayed(
                      const Duration(seconds: 5),
                      () {
                        outForDeliveryController.refetch.value = false;
                      },
                    );
                  } else if (restaurantData['status'] == "Delivered") {
                    pickedController.refetch.value = true;

                    Future.delayed(
                      const Duration(seconds: 5),
                      () {
                        pickedController.refetch.value = false;
                      },
                    );
                  } else if (restaurantData['status'] == "Pending") {
                    newOrderController.refetch.value = true;

                    Future.delayed(
                      const Duration(seconds: 5),
                      () {
                        newOrderController.refetch.value = false;
                      },
                    );
                  }
                } else {}

                return const SizedBox.shrink();
              })
        ],
      ),
    );
  }

  String getTimeOfDay() {
    DateTime now = DateTime.now();
    int hour = now.hour;

    if (hour >= 0 && hour < 12) {
      return "☀️";
    } else if (hour >= 12 && hour < 17) {
      return "🌤️";
    } else {
      return "🌙";
    }
  }

  String profile =
      'https://d326fntlu7tb1e.cloudfront.net/uploads/51530ae8-32b8-4a04-89b3-17f40a2f4cc1-avatar.png';
}
