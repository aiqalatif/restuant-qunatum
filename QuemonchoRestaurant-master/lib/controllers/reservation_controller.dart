import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:foodly_restaurant/constants/constants.dart';
import 'package:foodly_restaurant/models/environment.dart';
import 'package:foodly_restaurant/models/reservation_model.dart';
import 'package:foodly_restaurant/views/home/home_page.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;

class ReservationController extends GetxController {
  final box = GetStorage();
  Reservation? order;

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


 void processreservation(String restaurantId, String status) async {
    String token = box.read('token');
    
    String accessToken = jsonDecode(token);

    setLoading = true;
    
         Uri url = Uri.parse('${Environment.appBaseUrl}/api/restaurant/reservations/$restaurantId/status');
    
  try {
  var response = await http.put(
    url,
    headers: {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $accessToken'
    },
    body: jsonEncode({'status': status}), // Send orderStatus in the request body
  );

  print("response.statusCode");
  print(response.statusCode);

  if (response.statusCode == 200) {
    setLoading = false;

    // Show success snackbar
    Get.snackbar(
      "Success", 
      "Reservation status updated successfully",
      colorText: kLightWhite,
      backgroundColor: Colors.blue,
      icon: const Icon(Icons.check_circle),
    );

    // Navigate to HomePage
    Get.off(() => const HomePage(),
        transition: Transition.fadeIn,
        duration: const Duration(seconds: 2));
  } else {
    var data = response.body;

    Get.snackbar(data,
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