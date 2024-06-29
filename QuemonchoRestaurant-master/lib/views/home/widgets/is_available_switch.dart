import 'package:flutter/material.dart';
import 'package:foodly_restaurant/common/app_style.dart';
import 'package:foodly_restaurant/common/reusable_text.dart';
import 'package:foodly_restaurant/constants/constants.dart';
import 'package:foodly_restaurant/controllers/restaurant_controller.dart';
import 'package:get/get.dart';

class AvailableSwitch extends StatelessWidget {
  const AvailableSwitch({super.key});

  @override
  Widget build(BuildContext context) {
    final restaurantController = Get.put(RestaurantController());
    return SizedBox(
        height: 30,
        width: width,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
             ReusableText(
              text: 'Food Availability',
              style: appStyle(14, kGray, FontWeight.w600,
              ),
            ),
            Obx(
              () => Switch(

                value: restaurantController.isAvailable,
                onChanged: (value) {
                  restaurantController.setAvailability =
                      !restaurantController.isAvailable;
                },
                activeColor: kSecondary,
              ),
            )
          ],
        ));
  }
}
