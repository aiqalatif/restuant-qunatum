import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:foodly_restaurant/common/app_style.dart';
import 'package:foodly_restaurant/common/reusable_text.dart';
import 'package:foodly_restaurant/constants/constants.dart';
import 'package:foodly_restaurant/controllers/updates_controllers/new_request_controller.dart';
import 'package:foodly_restaurant/models/reservation_model.dart';
import 'package:foodly_restaurant/views/reservation/reservation_active_page.dart';
import 'package:get/get.dart';

class reservationTile extends StatelessWidget {
  const reservationTile({
    super.key,
    required this.order,
    required this.active,
  });

  final Reservation order;
  final String? active;

  @override
  Widget build(BuildContext context) {
   
    final controller = Get.put(NewRequestController());
   

    return GestureDetector(
      onTap: () {
        // controller. = order;
        // controller.setDistance =
        //     distanceToRestaurant + distanceFromRestaurantToClient;

       Get.to(() =>  ActivePageReservation(order:order),
              transition: Transition.fadeIn,
              duration: const Duration(seconds: 2));
          // activeOrder = const ActivePage();
      },
      child: Stack(
        clipBehavior: Clip.hardEdge,
        children: [
          Container(
            margin: const EdgeInsets.only(bottom: 8),
            height: 84,
            width: width,
            decoration:  const BoxDecoration(
                // color: controller.order == null? kOffWhite : controller.order!.id == order.id ? kSecondaryLight : kOffWhite,
                borderRadius: BorderRadius.all(Radius.circular(9))),
            child: Container(
              padding: const EdgeInsets.all(4),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                   CircleAvatar(
              radius: 20,
              backgroundColor: Colors.white,
              backgroundImage: NetworkImage(
                _getValidProfileUrl(order.user.profile[0]),
              ),
              onBackgroundImageError: (_, __) {
                // Handle the error by showing a placeholder image
              },
             child: const  Icon(Icons.person, size: 40,color: Colors.blueGrey,),
            ),
                  const SizedBox(
                    width: 10,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 6.h,
                      ),
                      
                      ReusableText(
                          text: order.user.email,
                          style: appStyle(10, kGray, FontWeight.w500)),
                      OrderRowText(
                          text: "🍲 Reservation Date : ${order.dateTime.toString()}"),
                    
                    
                    ],
                  )
                ],
              ),
            ),
          ),
        
        ],
      ),
    );
  }
  String _getValidProfileUrl(String? url) {
  if (url == null || !Uri.tryParse(url)!.hasAbsolutePath == true) {
    // Return a placeholder URL if the provided URL is not valid
    return 'https://via.placeholder.com/50';
  }
  return url;
}
}

// ignore: must_be_immutable
class OrderRowText extends StatelessWidget {
  const OrderRowText({
    super.key,
    required this.text,
  });

  final String text;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: width / 1.6,
        child: ReusableText(
            text: text, style: appStyle(9, kGray, FontWeight.w400)));
  }
  
}
