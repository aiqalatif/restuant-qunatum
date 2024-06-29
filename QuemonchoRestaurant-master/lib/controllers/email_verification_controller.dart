// ignore_for_file: prefer_final_fields

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:foodly_restaurant/constants/constants.dart';
import 'package:foodly_restaurant/models/api_error.dart';
import 'package:foodly_restaurant/models/environment.dart';
import 'package:foodly_restaurant/models/verification_response.dart';
import 'package:foodly_restaurant/views/auth/restaurant_registration.dart';
import 'package:foodly_restaurant/views/auth/verification_page.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;

class EmailVerificationController extends GetxController {
  final box = GetStorage();
  RxBool _isLoading = false.obs;

  bool get isLoading => _isLoading.value;

  set setLoading(bool newValue) {
    _isLoading.value = newValue;
  }

  var _code = ''.obs;

  String get code => _code.value;

  set code(String newValue) {
    _code.value = newValue;
  }

  void verifyEmail() async {
    String token = box.read('token');
    String accessToken = jsonDecode(token);
    setLoading = true;

    var url = Uri.parse('${Environment.appBaseUrl}/api/users/verify/$code');

    try {
      var response = await http.get(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $accessToken'
        },
      );

      if (response.statusCode == 200) {
        VerificationResponse data = verificationResponseFromJson(response.body);
  
        box.write("e-verification", data.verification);

        setLoading = false;

        Get.snackbar("Successfully verified your account ",
            "Enjoy your awesome experience",
            colorText: kLightWhite,
            snackPosition: SnackPosition.BOTTOM,
            icon: const Icon(Ionicons.fast_food_outline));
        if (data.verification == false) {
          Get.offAll(() => const VerificationPage(),
              transition: Transition.fade,
              duration: const Duration(seconds: 2));
        } else {
          Get.offAll(() => const RestaurantRegistration(),
              transition: Transition.fade,
              duration: const Duration(seconds: 2));
        }
      } else {
        var data = apiErrorFromJson(response.body);

        Get.snackbar(data.message, "Failed to verify, please try again",
            backgroundColor: kRed,
            snackPosition: SnackPosition.BOTTOM,
            icon: const Icon(Icons.error));
      }
    } catch (e) {
      setLoading = false;

      Get.snackbar(e.toString(), "Failed to login, please try again",
          colorText: kLightWhite,
          backgroundColor: kRed,
          icon: const Icon(Icons.error));
    } finally {
      setLoading = false;
    }
  }
}
