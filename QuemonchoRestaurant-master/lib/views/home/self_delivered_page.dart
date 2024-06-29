import 'package:flutter/material.dart';
import 'package:foodly_restaurant/common/custom_appbar.dart';
import 'package:foodly_restaurant/constants/constants.dart';
import 'package:foodly_restaurant/views/home/restaurant_orders/self_deliveries.dart';
import 'package:foodly_restaurant/views/home/widgets/back_ground_container.dart';

class SelfDeliveredPage extends StatelessWidget {
  const SelfDeliveredPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kLightWhite,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        flexibleSpace: CustomAppBar(
          title: "View all internal deliveries and delivery earnings",
          heading: "Welcome Foodly",
        ),
        elevation: 0,
        backgroundColor: kLightWhite,
      ),
      body: const BackGroundContainer(child: SelfDeliveries()),
    );
  }
}
