import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:foodly_restaurant/constants/constants.dart';
import 'package:foodly_restaurant/controllers/updates_controllers/new_request_controller.dart';
import 'package:foodly_restaurant/hooks/fetch_reservation.dart';
import 'package:foodly_restaurant/models/reservation_model.dart';
import 'package:foodly_restaurant/views/home/widgets/reservation_tile.dart';
import 'package:get/get.dart';

class AcceptRequest extends HookWidget {
  const AcceptRequest({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(NewRequestController());
    final hookResult = fetchRestaurantReservation("pending");
   
      List<Reservation>? reservations = hookResult.data;
    final isLoading = hookResult.isLoading;
    final refetch = hookResult.refetch;

    controller.setOnStatusChangeCallback(refetch);
    return  Container(
      height: hieght / 1.3,
      width: width,
      color: Colors.transparent,
      child: ListView.builder(
          padding: EdgeInsets.only(top: 10.h, left: 12.w, right: 12.w),
          itemCount: reservations!.length,
          itemBuilder: (context, i) {
            Reservation order = reservations[i];
            return reservationTile(
              order: order,
              active: null,
            );
          }),
    );
  }
}