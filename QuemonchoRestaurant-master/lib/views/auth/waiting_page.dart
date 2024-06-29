import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:foodly_restaurant/common/app_style.dart';
import 'package:foodly_restaurant/common/reusable_text.dart';
import 'package:foodly_restaurant/constants/constants.dart';
import 'package:foodly_restaurant/controllers/login_controller.dart';
import 'package:foodly_restaurant/controllers/restaurant_controller.dart';
import 'package:foodly_restaurant/views/auth/login_page.dart';
import 'package:foodly_restaurant/views/home/widgets/back_ground_container.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:lottie/lottie.dart';

class WaitingPage extends StatelessWidget {
  const WaitingPage({super.key});

  @override
  Widget build(BuildContext context) {
    final box = GetStorage();
    final restaurantController = Get.put(RestaurantController());
    final controller = Get.put(LoginController());
    String id = box.read('restaurantId');
    // restaurantController.restaurant = controller.getRestaurantData(id);
    return Scaffold(
      body: BackGroundContainer(
        color: Colors.white,
          child: Padding(
        padding: EdgeInsets.fromLTRB(24.w, 200.h, 24.w, 0),
        child: ListView(
          children: [
            Lottie.asset('assets/anime/delivery.json'),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ReusableText(
                text: "Status: ${restaurantController.restaurant!.verification}",
                style: appStyle(14, kGray, FontWeight.bold)),

                GestureDetector(
                  onTap: () {
                    Get.to(
                      () => const Login(),
                    );
                  },
                  child: ReusableText(
                      text: "Try Login",
                      style: appStyle(14, kTertiary, FontWeight.bold)),
                ),
              ],
            ),
            
            SizedBox(
              height: 10.h,
            ),
            SizedBox(
              width: width * 0.8,
              child: Text(
                restaurantController.restaurant!.verificationMessage,
                style: const TextStyle(
                  fontWeight: FontWeight.normal,
                  fontSize: 12,
                  color: kGray,
                ),
                textAlign: TextAlign.justify,
              ),
            ),
            SizedBox(
              height: 10.h,
            ),
            
          ],
        ),
      )),
    );
  }
}
