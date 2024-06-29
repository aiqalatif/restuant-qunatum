import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:foodly_restaurant/constants/constants.dart';
import 'package:foodly_restaurant/controllers/login_response.dart';
import 'package:foodly_restaurant/controllers/notifications_controller.dart';
import 'package:foodly_restaurant/controllers/restaurant_controller.dart';
import 'package:foodly_restaurant/main.dart';
import 'package:foodly_restaurant/models/api_error.dart';
import 'package:foodly_restaurant/models/environment.dart';
import 'package:foodly_restaurant/models/restaurant_response.dart';
import 'package:foodly_restaurant/views/auth/restaurant_registration.dart';
import 'package:foodly_restaurant/views/auth/login_page.dart';
import 'package:foodly_restaurant/views/auth/verification_page.dart';
import 'package:foodly_restaurant/views/auth/waiting_page.dart';
import 'package:foodly_restaurant/views/home/home_page.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;

class LoginController extends GetxController {
  final box = GetStorage();
  final controller = Get.put(NotificationsController());
  final restaurantController = Get.put(RestaurantController());
  final RxBool _isLoading = false.obs;

  bool get isLoading => _isLoading.value;

  set setLoading(bool newValue) {
    _isLoading.value = newValue;
  }
void loginFunc(String model) async {
    setLoading = true;

    var url = Uri.parse('${Environment.appBaseUrl}/login');

    try {
        var response = await http.post(
            url,
            headers: {
                'Content-Type': 'application/json',
            },
            body: model,
        );

        if (response.statusCode == 200) {
            LoginResponse data = loginResponseFromJson(response.body);
            String userId = data.id;
            String userData = json.encode(data);

            box.write(userId, userData);
            box.write("token", json.encode(data.userToken));
            box.write("userId", userId);
            box.write("e-verification", data.verification);
            controller.updateUserToken(controller.fcmToken);
            print("${controller.fcmToken} updated successfully");

            if (data.userType == "Vendor") {
                if (data.verification) {
                    getRestaurant(data.userToken,data.id);
                } else {
                    Get.offAll(() => const VerificationPage(),
                        transition: Transition.fade,
                        duration: const Duration(seconds: 2));
                }
            } else {
                Get.snackbar("Opps Error ",
                    "You do not have a registered restaurant, please register first",
                    colorText: Colors.white,
                    backgroundColor: kRed,
                    icon: const Icon(Ionicons.fast_food_outline));

                defaultHome = const Login();
                Get.offAll(() => const RestaurantRegistration(),
                    transition: Transition.fade,
                    duration: const Duration(seconds: 2));
            }

            setLoading = false;

            Get.snackbar("Successfully logged in ", "Enjoy your awesome experience",
                colorText: kLightWhite,
                backgroundColor: kPrimary,
                icon: const Icon(Ionicons.fast_food_outline));
        } else {
            var data = apiErrorFromJson(response.body);

            Get.snackbar(data.message, "Failed to login, please try again",
                colorText: kLightWhite,
                backgroundColor: kRed,
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


  void logout() {
    box.erase();
    defaultHome = const Login();
    Get.offAll(() => defaultHome,
        transition: Transition.fade, duration: const Duration(seconds: 2));
  }

  LoginResponse? getUserData() {
    String? userId = box.read("userId");
    if (userId != null) {
      String? data = box.read(userId);
      if (data != null) {
        return loginResponseFromJson(data);
      }
    }
    return null;
  }

  void getRestaurant(String token,String id) async {
    var url = Uri.parse('${Environment.appBaseUrl}/api/restaurant/byOwner/$id');

    try {
        var response = await http.get(
            url,
            headers: {
                'Content-Type': 'application/json',
                'Authorization': 'Bearer $token',
            },
        );

        if (response.statusCode == 200) {
            Datum restaurant = Datum.fromJson(json.decode(response.body)["data"][0]);
            restaurantController.restaurant = restaurant;
            box.write("restaurantId", restaurant.id);
            box.write("verification", restaurant.verification);
            box.write(restaurant.id, json.encode(restaurant));

            if (restaurant.verification != "Verified") {
                Get.offAll(() => const WaitingPage(),
                    transition: Transition.fade,
                    duration: const Duration(seconds: 2));
            } else {
                Get.to(() => const HomePage(),
                    transition: Transition.fade,
                    duration: const Duration(seconds: 2));
            }

        } else {
            var error = apiErrorFromJson(response.body);
            Get.snackbar("Opps Error ", error.message,
                colorText: kLightWhite,
                backgroundColor: kRed,
                icon: const Icon(Ionicons.fast_food_outline));

            Get.offAll(() => const HomePage(),
                transition: Transition.fade, duration: const Duration(seconds: 2));
        }
    } catch (e) {
        Get.snackbar(e.toString(), "Failed to login, please try again",
            colorText: kLightWhite,
            backgroundColor: kRed,
            icon: const Icon(Icons.error));
    }
}




  Datum? getRestaurantData(String restaurantId) {
    String? data = box.read(restaurantId);
    if (data != null) {
        return Datum.fromJson(json.decode(data));
    }
    return null;
}

  final RxBool _payout = false.obs;

  bool get payout => _payout.value;

  set setRequest(bool newValue) {
    _payout.value = newValue;
  }
}
