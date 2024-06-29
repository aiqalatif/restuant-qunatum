// ignore_for_file: prefer_final_fields, unnecessary_null_comparison

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:foodly_restaurant/constants/constants.dart';
import 'package:foodly_restaurant/models/api_error.dart';
import 'package:foodly_restaurant/models/environment.dart';
import 'package:foodly_restaurant/models/sucess_model.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;

class NotificationsController extends GetxController {
  final box = GetStorage();

  RxString _fcmToken = ''.obs;

  String get fcmToken => _fcmToken.value;

  set setFcm(String newValue) {
    _fcmToken.value = newValue;
  }

  String extractOrderNumber(String input) {
    // Find the start index of the order number
    String identifier = "order : ";
    int startIndex = input.indexOf(identifier);

    // Check if the identifier is found
    if (startIndex != -1) {
      // Adjust startIndex to the beginning of the order number
      startIndex += identifier.length;

      // Extract the order number
      // Assuming the order number length is fixed (e.g., 24 characters long)
      return input.substring(startIndex, startIndex + 24);
    }

    // Return an empty string if the identifier is not found
    return '';
  }

  void updateUserToken(String deviceToken) async {
    String token = box.read('token');
    String accessToken = jsonDecode(token);
    var url = Uri.parse(
        '${Environment.appBaseUrl}/api/users/updateToken/$deviceToken');

    try {
      
      var response = await http.put(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $accessToken'
        },
      );

      print(response.statusCode);

      if (response.statusCode == 200) {
        var data = successResponseFromJson(response.body);
        debugPrint(data.message);
      } else {
        var data = apiErrorFromJson(response.body);

        Get.snackbar(data.message, "Failed to login, please try again",
            colorText: kLightWhite,
            backgroundColor: kRed,
            icon: const Icon(Icons.error));
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  RxBool _loading = false.obs;

  bool get loading => _loading.value;

  set setLoader(bool newLoader) {
    _loading.value = newLoader;
  }

  // GetOrder? order;
  // void getOrder(String orderNumber) async {
  //   setLoader = true;
  //   var url = Uri.parse('${Environment.appBaseUrl}/api/orders/$orderNumber');

  //   try {
  //     var response = await http.get(
  //       url,
  //       headers: {
  //         'Content-Type': 'application/json',
  //       },
  //     );

  //     if (response.statusCode == 200) {
  //       order = getOrderFromJson(response.body);
  //       setLoader = false;
  //     } else {
  //       var data = apiErrorFromJson(response.body);
  //       setLoader = false;
  //       Get.snackbar(data.message, "Failed to login, please try again",
  //           colorText: kLightWhite,
  //           backgroundColor: kRed,
  //           icon: const Icon(Icons.error));
  //     }
  //   } catch (e) {
  //     setLoader = false;
  //     debugPrint(e.toString());
  //   }
  // }
}
