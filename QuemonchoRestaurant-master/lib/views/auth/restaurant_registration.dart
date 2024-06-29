import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:foodly_restaurant/common/app_style.dart';
import 'package:foodly_restaurant/common/custom_btn.dart';
import 'package:foodly_restaurant/common/reusable_text.dart';
import 'package:foodly_restaurant/constants/constants.dart';
import 'package:foodly_restaurant/controllers/Image_upload_controller.dart';
import 'package:foodly_restaurant/controllers/location_controller.dart';
import 'package:foodly_restaurant/controllers/restaurant_controller.dart';
import 'package:foodly_restaurant/models/restaurant_request.dart';
import 'package:foodly_restaurant/views/auth/widgets/email_textfield.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;

class RestaurantRegistration extends StatefulWidget {
  const RestaurantRegistration({super.key});

  @override
  State<RestaurantRegistration> createState() => _RestaurantRegistrationState();
}

class _RestaurantRegistrationState extends State<RestaurantRegistration> {
  final TextEditingController _searchController = TextEditingController();
  late final PageController _pageController = PageController(initialPage: 0);
  GoogleMapController? _mapController;
  final box = GetStorage();

  @override
  void initState() {
    super.initState();
    _pageController.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  List<dynamic> _placeList = [];
  final List<dynamic> _selectedPlace = [];

  LatLng? _selectedLocation;

  void _onSearchChanged(String searchQuery) async {
    if (searchQuery.isNotEmpty) {
      final url = Uri.parse(
          'https://maps.googleapis.com/maps/api/place/autocomplete/json?input=$searchQuery&key=$googleApiKey');
      final response = await http.get(url);

      if (response.statusCode == 200) {
        setState(() {
          _placeList = json.decode(response.body)['predictions'];
        });
      }
    } else {
      setState(() {
        _placeList = [];
      });
    }
  }

  void _getPlaceDetail(String placeId) async {
    final detailUrl = Uri.parse(
        'https://maps.googleapis.com/maps/api/place/details/json?place_id=$placeId&key=$googleApiKey');
    final detailResponse = await http.get(detailUrl);

    if (detailResponse.statusCode == 200) {
      final responseBody = json.decode(detailResponse.body);

      // Extracting latitude and longitude
      final lat = responseBody['result']['geometry']['location']['lat'];
      final lng = responseBody['result']['geometry']['location']['lng'];

      // Extracting the formatted address
      final address = responseBody['result']['formatted_address'];

      // Extracting the postal code
      String postalCode = "";
      final addressComponents = responseBody['result']['address_components'];
      for (var component in addressComponents) {
        if (component['types'].contains('postal_code')) {
          postalCode = component['long_name'];
          break;
        }
      }

      setState(() {
        _selectedLocation = LatLng(lat, lng);
        _searchController.text = address;
        _postalCodeRes.text = postalCode;
        moveToSelectedLocation();
        _placeList = [];
      });
    }
  }

  void moveToSelectedLocation() {
    if (_selectedLocation != null && _mapController != null) {
      _mapController!.animateCamera(
        CameraUpdate.newCameraPosition(
          CameraPosition(
            target: _selectedLocation!,
            zoom: 16.0, // You can adjust the zoom level
          ),
        ),
      );
    }
  }

void _onMarkerDragEnd(LatLng newPosition) async {
  setState(() {
    _selectedLocation = newPosition;
  });

  final reverseGeocodeUrl = Uri.parse(
      'https://maps.googleapis.com/maps/api/geocode/json?latlng=${newPosition.latitude},${newPosition.longitude}&key=$googleApiKey');

  final response = await http.get(reverseGeocodeUrl);

  if (response.statusCode == 200) {
    final responseBody = json.decode(response.body);

    // Extracting the formatted address
    final address = responseBody['results'][0]['formatted_address'];

    // Extracting the postal code
    String postalCode = "";
    final addressComponents = responseBody['results'][0]['address_components'];
    for (var component in addressComponents) {
      if (component['types'].contains('postal_code')) {
        postalCode = component['long_name'];
        break;
      }
    }

    // Update the state with the new address and postal code
    setState(() {
      _searchController.text = address;
      _postalCodeRes.text = postalCode;
    });
  } else {
    // Handle the error or no result case
    print('Failed to fetch address');
  }
}

  String restaurantAddress = "";
  final TextEditingController _title = TextEditingController();
  final TextEditingController _time = TextEditingController();
  final TextEditingController _address = TextEditingController();
  final TextEditingController _postalCodeRes = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final imageUploader = Get.put(ImageUploadController());
    final locationController = Get.put(UserLocationController());
    final restaurantController = Get.put(RestaurantController());
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: ReusableText(
            text: "Restaurant Registration",
            style: appStyle(16, kDark, FontWeight.w600)),
        backgroundColor: Colors.white,
        elevation: 0,
        leading: Padding(
          padding: EdgeInsets.only(right: 0.w),
          child: IconButton(
            onPressed: () {
              _pageController.previousPage(
                  duration: const Duration(milliseconds: 500),
                  curve: Curves.ease);
            },
            icon: const Icon(
              Entypo.arrow_left,
              color: kDark,
            ),
          ),
        ),
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 0.w),
            child: IconButton(
              onPressed: () {
                _pageController.nextPage(
                    duration: const Duration(milliseconds: 500),
                    curve: Curves.ease);
              },
              icon: const Icon(
                Icons.forward,
                color: kDark,
              ),
            ),
          )
        ],
      ),
      body: SizedBox(
        height: hieght,
        width: width,
        child: PageView(
          controller: _pageController,
          pageSnapping: false,
          physics: const NeverScrollableScrollPhysics(),
          onPageChanged: (index) {
            _pageController.jumpToPage(index);
          },
          children: [
            Container(
              color: kGrayLight,
              width: width,
              height: hieght,
              child: Stack(
                children: [
                  GoogleMap(
                    onMapCreated: (GoogleMapController controller) {
                      _mapController = controller;
                    },
                    initialCameraPosition: CameraPosition(
                      target:  _selectedLocation ?? const LatLng(31.7131, 73.9783), // Default location
                      zoom: 15.0,
                    ),
                    markers: _selectedLocation == null
                        // ignore: prefer_collection_literals
                        ? Set.of([])
                        // ignore: prefer_collection_literals
                        : Set.of([
                            Marker(
                              markerId: const MarkerId('Your Location'),
                              position: _selectedLocation!,
                              draggable: true,
                              onDragEnd: (newPosition) {
                                _onMarkerDragEnd(newPosition);
                              },
                            )
                          ]),
                  ),
                  Column(
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 10.h),
                        color: Colors.white,
                        child: TextField(
                          controller: _searchController,
                          onChanged: _onSearchChanged,
                          decoration: const InputDecoration(
                              hintText: 'Search for your address...'),
                        ),
                      ),
                      _placeList.isEmpty
                          ? const SizedBox.shrink()
                          : Expanded(
                              child: ListView(
                                children: List.generate(
                                  _placeList.length,
                                  (index) {
                                    return Container(
                                      color: Colors.white,
                                      child: ListTile(
                                        visualDensity: VisualDensity.compact,
                                        title: Text(
                                            _placeList[index]['description']),
                                        onTap: () {
                                          _getPlaceDetail(
                                              _placeList[index]['place_id']);
                                          _selectedPlace.add(_placeList[index]);
                                        },
                                      ),
                                    );
                                  },
                                ),
                              ),
                            )
                    ],
                  ),
                ],
              ),
            ),
            Container(
              color: Colors.white,
              padding: EdgeInsets.symmetric(horizontal: 10.h),
              width: width,
              height: hieght,
              child: ListView(
                children: [
                  SizedBox(
                    height: 20.h,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: () {
                          imageUploader.pickImage("logo");
                        },
                        child: Container(
                            height: 120.h,
                            width: width / 2.2,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10.r),
                                border: Border.all(color: kGrayLight)),
                            child: Obx(() => imageUploader.logoUrl == ""
                                ? Center(
                                    child: Text(
                                      "Upload Logo",
                                      style:
                                          appStyle(16, kDark, FontWeight.w600),
                                    ),
                                  )
                                : ClipRRect(
                                    borderRadius: BorderRadius.circular(10.r),
                                    child: Image.network(
                                      imageUploader.logoUrl,
                                      fit: BoxFit.cover,
                                    )))),
                      ),
                      GestureDetector(
                        onTap: () {
                          imageUploader.pickImage("cover");
                        },
                        child: Container(
                            height: 120.h,
                            width: width / 2.2,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10.r),
                                border: Border.all(color: kGrayLight)),
                            // ignore: unrelated_type_equality_checks
                            child: Obx(() => imageUploader.coverUrl == ""
                                ? Center(
                                    child: Text(
                                      "Upload Cover",
                                      style:
                                          appStyle(16, kDark, FontWeight.w600),
                                    ),
                                  )
                                : ClipRRect(
                                    borderRadius: BorderRadius.circular(10.r),
                                    child: Image.network(
                                      imageUploader.coverUrl,
                                      fit: BoxFit.cover,
                                    )))),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  EmailTextField(
                    hintText: "Restaurant Title",
                    controller: _title,
                    prefixIcon: Icon(
                      Ionicons.fast_food_outline,
                      color: Theme.of(context).dividerColor,
                      size: 20.h,
                    ),
                    keyboardType: TextInputType.text,
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  EmailTextField(
                    hintText: "Business Hours (e.g 8:00am - 10:00pm)",
                    controller: _time,
                    prefixIcon: Icon(
                      Ionicons.time_outline,
                      color: Theme.of(context).dividerColor,
                      size: 20.h,
                    ),
                    keyboardType: TextInputType.text,
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  EmailTextField(
                    hintText: "Postal Code",
                    controller: _postalCodeRes,
                    prefixIcon: Icon(
                      Ionicons.locate_outline,
                      color: Theme.of(context).dividerColor,
                      size: 20.h,
                    ),
                    keyboardType: TextInputType.text,
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                 
                  EmailTextField(
                    hintText: "Address",
                    controller: _searchController,
                    prefixIcon: Icon(
                      Ionicons.location_outline,
                      color: Theme.of(context).dividerColor,
                      size: 20.h,
                    ),
                    keyboardType: TextInputType.text,
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
CustomButton(
  text: "S U B M I T",
  btnHieght: 40.h,
  onTap: () async {
    // Retrieve the owner ID from storage
    String? ownerId = box.read("userId");
    if (ownerId != null) {
      // Print the owner ID
      print("Owner ID: $ownerId");
    } else {
      // Handle the case where the owner ID is not found
      print("Owner ID not found in storage");
      return; // Exit early if owner ID is not found
    }

    // Proceed with the registration logic
    print("Submit button pressed");

    if (_title.text.isNotEmpty &&
        _time.text.isNotEmpty &&
        _postalCodeRes.text.isNotEmpty &&
        _searchController.text.isNotEmpty &&
        imageUploader.logoUrl.isNotEmpty &&
        imageUploader.coverUrl.isNotEmpty &&
        _selectedLocation != null) {
      RestaurantRequest data = RestaurantRequest(
        title: _title.text,
        time: _time.text,
        code: _postalCodeRes.text,
        logoUrl: imageUploader.logoUrl,
        imageUrl: imageUploader.coverUrl,
        owner: ownerId, // Use ownerId directly
        coords: Coords(
          id: locationController.generateRandomNumber(10, 100000),
          latitude: _selectedLocation!.latitude,
          longitude: _selectedLocation!.longitude,
          address: _searchController.text,
          title: _title.text,
        ),
      );

      String restaurant = restaurantRequestToJson(data);
      print("Restaurant data: $restaurant");

      try {
        restaurantController.restaurantRegistration(restaurant);
        print("Registration successful");
      } catch (e) {
        print("Error during registration: $e");
      }
    } else {
      print("Registration failed: fields are missing");
      Get.snackbar("Registration Failed", "Please fill all the fields and try again",
          colorText: kLightWhite,
          backgroundColor: kRed,
          icon: const Icon(Icons.add_alert));
    }
  },
),

              
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
