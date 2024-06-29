// ignore_for_file: prefer_final_fields

import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geocoding/geocoding.dart';
  import 'dart:math';
  
class UserLocationController extends GetxController {
  var _currentIndex = 0.obs;

  int get currentIndex => _currentIndex.value;

  set currentIndex(int newIndex) {
    _currentIndex.value = newIndex;
    update(); // Equivalent to notifyListeners()
  }

  var _restaurantLocation = const LatLng(0, 0).obs;

  LatLng get restaurantLocation => _restaurantLocation.value;

  void setLocation(LatLng newLocation) {
    _restaurantLocation.value = newLocation;
    update(); // Equivalent to notifyListeners()
  }

  var _currentLocation = const LatLng(0, 0).obs;

  LatLng get currentLocation => _currentLocation.value;

  void setUserLocation(LatLng newLocation) {
    _currentLocation.value = newLocation;
    update(); // Equivalent to notifyListeners()
  }


  var _userAddress = const Placemark(
    name: "Central Park",
    street: "59th St to 110th St",
    isoCountryCode: "US",
    country: "United States",
    postalCode: "10022",
    administrativeArea: "New York",
    subAdministrativeArea: "New York County",
    locality: "New York",
    subLocality: "Manhattan",
    thoroughfare: "Central Park West",
    subThoroughfare: "1",
  ).obs;

  Placemark get userAddress => _userAddress.value;

  void setUserAddress(Placemark newAddress) {
    _userAddress.value = newAddress;
    update(); // Equivalent to notifyListeners()
  }



int generateRandomNumber(int min, int max) {
  final random = Random();
  return min + random.nextInt(max - min + 1);
}
}
