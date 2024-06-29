import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:foodly_restaurant/constants/constants.dart';
import 'package:foodly_restaurant/models/api_error.dart';
import 'package:foodly_restaurant/models/environment.dart';
import 'package:foodly_restaurant/models/ready_orders.dart';
import 'package:foodly_restaurant/views/home/home_page.dart';
import 'package:foodly_restaurant/views/order/active_page.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;

class OrdersController extends GetxController {
  final box = GetStorage();
  ReadyOrders? order;

  int tabIndex = 0;

  double _tripDistance = 0;

  // Getter
  double get tripDistance => _tripDistance;

  // Setter
  set setDistance(double newValue) {
    _tripDistance = newValue;
  }

  // Reactive state
  final _count = 0.obs;

  // Getter
  int get count => _count.value;

  // Setter
  set setCount(int newValue) {
    _count.value = newValue;
  }

  final _setLoading = false.obs;

  // Getter
  bool get setLoading => _setLoading.value;

  // Setter
  set setLoading(bool newValue) {
    _setLoading.value = newValue;
  }

  void pickOrder(String orderId) async {
    String token = box.read('token');
    String driverId = box.read('driverId');
    String accessToken = jsonDecode(token);
   print(driverId);
    setLoading = true;
    var url =
        Uri.parse('${Environment.appBaseUrl}/api/orders/picked-orders/$orderId/$driverId');

    try {
      var response = await http.put(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $accessToken'
        },
      );

      if (response.statusCode == 200) {
        setLoading = false;
        print("_________________");
        print(response.body);
        Get.snackbar("Order picked successfully",
            "To view the order, go to the active tab",
            colorText: kLightWhite,
            backgroundColor: kPrimary,
            icon: const Icon(FontAwesome5Solid.shipping_fast));

        Map<String, dynamic> data = jsonDecode(response.body);
        order = ReadyOrders.fromJson(data);

        Get.off(() => const ActivePage(),
            transition: Transition.fadeIn,
            duration: const Duration(seconds: 2));
      } else {
        var data = apiErrorFromJson(response.body);

        Get.snackbar(
            data.message, "Failed to picking an order, please try again",
            colorText: kLightWhite,
            backgroundColor: kRed,
            icon: const Icon(Icons.error));
      }
    } catch (e) {
      setLoading = false;

      Get.snackbar(e.toString(), "Failed to picking an order, please try again",
          colorText: kLightWhite,
          backgroundColor: kRed,
          icon: const Icon(Icons.error));
    } finally {
      setLoading = false;
    }
  }

 void processOrder(String orderId, String status) async {
    String token = box.read('token');
    String accessToken = jsonDecode(token);

    setLoading = true;
    
    var url = Uri.parse('${Environment.appBaseUrl}/api/orders/$orderId/status');
    
    try {
      var response = await http.put(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $accessToken'
        },
        body: jsonEncode({'orderStatus': status}), // Send orderStatus in the request body
      );

      if (response.statusCode == 200) {
        setLoading = false;

        Get.off(() => const HomePage(),
            transition: Transition.fadeIn,
            duration: const Duration(seconds: 2));
      } else {
        var data = apiErrorFromJson(response.body);

        Get.snackbar(data.message,
            "Failed to mark as delivered, please try again or contact support",
            colorText: kLightWhite,
            backgroundColor: kRed,
            icon: const Icon(Icons.error));
      }
    } catch (e) {
      setLoading = false;

      Get.snackbar(
          e.toString(), "Failed to mark order as delivered please try again",
          colorText: kLightWhite,
          backgroundColor: kRed,
          icon: const Icon(Icons.error));
    } finally {
      setLoading = false;
    }
}
}