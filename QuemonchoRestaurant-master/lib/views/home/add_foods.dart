// ignore_for_file: prefer_final_fields

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:foodly_restaurant/common/app_style.dart';
import 'package:foodly_restaurant/common/custom_appbar.dart';
import 'package:foodly_restaurant/common/custom_btn.dart';
import 'package:foodly_restaurant/common/description.dart';
import 'package:foodly_restaurant/common/reusable_text.dart';
import 'package:foodly_restaurant/common/row_text.dart';
import 'package:foodly_restaurant/constants/constants.dart';
import 'package:foodly_restaurant/controllers/Image_upload_controller.dart';
import 'package:foodly_restaurant/controllers/foods_controller.dart';
import 'package:foodly_restaurant/controllers/restaurant_controller.dart';
import 'package:foodly_restaurant/models/foods.dart';
import 'package:foodly_restaurant/models/foods_request.dart';
import 'package:foodly_restaurant/views/auth/widgets/email_textfield.dart';
import 'package:foodly_restaurant/views/home/widgets/back_ground_container.dart';
import 'package:foodly_restaurant/views/home/widgets/is_available_switch.dart';
import 'package:foodly_restaurant/views/home/widgets/more_categories.dart';
import 'package:get/get.dart';
class AddFoodsPage extends StatefulWidget {
  const AddFoodsPage({super.key});

  @override
  State<AddFoodsPage> createState() => _AddFoodsPageState();
}

class _AddFoodsPageState extends State<AddFoodsPage> {
  TextEditingController _title = TextEditingController();
  TextEditingController _description = TextEditingController();
  TextEditingController _price = TextEditingController();
  TextEditingController _time = TextEditingController();
  TextEditingController _additiveTitle = TextEditingController();
  TextEditingController _additivePrice = TextEditingController();
  TextEditingController _tags = TextEditingController();
  TextEditingController _type = TextEditingController();

  final PageController _pageController = PageController();

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final imageUploader = Get.put(ImageUploadController());
    final foodsController = Get.put(FoodsController());
    final restaurantController = Get.put(RestaurantController());
// final box = GetStorage();
// String resturantId = box.read('restaurantId');
    return Scaffold(
      backgroundColor: kLightWhite,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        flexibleSpace: CustomAppBar(
          title: "Fill the required info to add food items",
          heading: "Welcome Foodly",
        ),
        elevation: 0,
        backgroundColor: kLightWhite,
      ),
      body: BackGroundContainer(
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          children: [
            SizedBox(
              height: hieght,
              width: width,
              child: PageView(
                controller: _pageController,
                pageSnapping: false,
                children: [
                  SizedBox(
                    height: hieght,
                    child: AllCategories(
                      next: () {
                        _pageController.animateToPage(1,
                            duration: const Duration(milliseconds: 400),
                            curve: Curves.easeInOut);
                      },
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 12.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 20.h,
                        ),
                        ReusableText(
                          text: "Upload Images",
                          style: appStyle(16, kGray, FontWeight.w600),
                        ),
                        ReusableText(
                          text:
                              "You are required to upload a minimum of two images",
                          style: appStyle(11, kGray, FontWeight.normal),
                        ),

                        SizedBox(
                          height: 20.h,
                        ),

                        SizedBox(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  imageUploader.pickImage("one");
                                },
                                child: Container(
                                  height: 120.h,
                                  width: width / 2.5,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10.r),
                                      border: Border.all(color: kGrayLight)),
                                  child: Obx(
                                    () => imageUploader.imageOneUrl == ""
                                        ? Center(
                                            child: Text(
                                              "Upload Image",
                                              style: appStyle(
                                                  16, kDark, FontWeight.w600),
                                            ),
                                          )
                                        : ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(10.r),
                                            child: Image.network(
                                              imageUploader.imageOneUrl,
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                  ),
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  imageUploader.pickImage("two");
                                },
                                child: Container(
                                  height: 120.h,
                                  width: width / 2.5,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10.r),
                                      border: Border.all(color: kGrayLight)),
                                  child: Obx(
                                    () => imageUploader.imageTwoUrl == ""
                                        ? Center(
                                            child: Text(
                                              "Upload Image",
                                              style: appStyle(
                                                  16, kDark, FontWeight.w600),
                                            ),
                                          )
                                        : ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(10.r),
                                            child: Image.network(
                                              imageUploader.imageTwoUrl,
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),

                        //add spacer
                        SizedBox(
                          height: 20.h,
                        ),

                        SizedBox(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  imageUploader.pickImage("three");
                                },
                                child: Container(
                                  height: 120.h,
                                  width: width / 2.5,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10.r),
                                      border: Border.all(color: kGrayLight)),
                                  child: Obx(
                                    () => imageUploader.imageThreeUrl == ""
                                        ? Center(
                                            child: Text(
                                              "Upload Image",
                                              style: appStyle(
                                                  16, kDark, FontWeight.w600),
                                            ),
                                          )
                                        : ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(10.r),
                                            child: Image.network(
                                              imageUploader.imageThreeUrl,
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                  ),
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  imageUploader.pickImage("four");
                                },
                                child: Container(
                                  height: 120.h,
                                  width: width / 2.5,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10.r),
                                      border: Border.all(color: kGrayLight)),
                                  child: Obx(
                                    () => imageUploader.imageFourUrl == ""
                                        ? Center(
                                            child: Text(
                                              "Upload Image",
                                              style: appStyle(
                                                  16, kDark, FontWeight.w600),
                                            ),
                                          )
                                        : ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(10.r),
                                            child: Image.network(
                                              imageUploader.imageFourUrl,
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                  ),
                                ),
                              )
                          
                            ],
                          ),
                        ),

                        SizedBox(
                          height: 20.h,
                        ),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            CustomButton(
                              text: "B A C K",
                              btnHieght: 40,
                              color: kPrimary,
                              btnWidth: width / 2.5,
                              onTap: () {
                                _pageController.previousPage(
                                    duration: const Duration(milliseconds: 400),
                                    curve: Curves.easeInOut);
                              },
                            ),
                            CustomButton(
                              text: "N E X T",
                              color: kPrimary,
                              btnHieght: 40,
                              btnWidth: width / 2.5,
                              onTap: () {
                                if(imageUploader.images.length > 1){
                                   _pageController.animateToPage(2,
                                    duration: const Duration(milliseconds: 400),
                                    curve: Curves.easeInOut);
                                }
                               
                              },
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                  Container(
                      padding: EdgeInsets.symmetric(horizontal: 12.w),
                      child: Obx(
                        () => ListView(
                          children: [
                            SizedBox(
                              height: 20.h,
                            ),
                            ReusableText(
                              text: "Add Details",
                              style: appStyle(16, kGray, FontWeight.w600),
                            ),
                            ReusableText(
                              text:
                                  "You are required fill all the details fully with the correct information",
                              style: appStyle(11, kGray, FontWeight.normal),
                            ),
                            SizedBox(
                              height: 20.h,
                            ),
                            EmailTextField(
                              hintText: "Title",
                              controller: _title,
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
                            DescriptionField(
                              hintText: "Description of the food item ",
                              controller: _description,
                              maxLines: 4,
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
                              hintText: "Preparation time e.g 25 min",
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
                              hintText: "Price",
                              controller: _price,
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
                            SizedBox(
                              height: 20.h,
                            ),
                            ReusableText(
                              text: "Add FoodType",
                              style: appStyle(16, kGray, FontWeight.w600),
                            ),
                            ReusableText(
                              text:
                                  "You are required fill all the details fully with the correct information",
                              style: appStyle(11, kGray, FontWeight.normal),
                            ),
                            SizedBox(
                              height: 20.h,
                            ),
                            EmailTextField(
                              hintText: "Breakfast / Lunch / Dinner",
                              controller: _type,
                              prefixIcon: Icon(
                                Ionicons.time_outline,
                                color: Theme.of(context).dividerColor,
                                size: 20.h,
                              ),
                              keyboardType: TextInputType.text,
                            ),
                            SizedBox(
                              height: 10.h,
                            ),
                            foodsController.type.isNotEmpty
                                ? Row(
                                    children: List.generate(
                                        foodsController.type.length, (index) {
                                      return Container(
                                        margin: const EdgeInsets.only(right: 5),
                                        decoration: BoxDecoration(
                                            color: kPrimary,
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(8.r))),
                                        child: Center(
                                          child: Padding(
                                            padding: const EdgeInsets.all(2.0),
                                            child: ReusableText(
                                                text:
                                                    foodsController.type[index],
                                                style: appStyle(8, kLightWhite,
                                                    FontWeight.w400)),
                                          ),
                                        ),
                                      );
                                    }),
                                  )
                                : const SizedBox.shrink(),
                            SizedBox(
                              height: 20.h,
                            ),
                            CustomButton(
                              text: "A D D    T Y P E",
                              btnHieght: 40,
                              onTap: () {
                                if (_type.text.isNotEmpty) {
                                  foodsController.type.add(_type.text);

                                  _type.clear();
                                } else {
                                  Get.snackbar(
                                      "Error", "Please enter a valid value",
                                      snackPosition: SnackPosition.BOTTOM);
                                }
                              },
                            ),
                            SizedBox(
                              height: 20.h,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                CustomButton(
                                  text: "B A C K",
                                  btnHieght: 40,
                                  color: kPrimary,
                                  btnWidth: width / 2.5,
                                  onTap: () {
                                    _pageController.previousPage(
                                        duration:
                                            const Duration(milliseconds: 400),
                                        curve: Curves.easeInOut);
                                  },
                                ),
                                CustomButton(
                                  text: "N E X T",
                                  color: kPrimary,
                                  btnHieght: 40,
                                  btnWidth: width / 2.5,
                                  onTap: () {
                                    _pageController.nextPage(
                                        duration:
                                            const Duration(milliseconds: 400),
                                        curve: Curves.easeInOut);
                                  },
                                ),
                              ],
                            )
                          ],
                        ),
                      )),
                  Container(
                      padding: EdgeInsets.symmetric(horizontal: 12.w),
                      child: Obx(
                        () => ListView(
                          children: [
                            SizedBox(
                              height: 20.h,
                            ),
                            ReusableText(
                              text: "Add Additives",
                              style: appStyle(16, kGray, FontWeight.w600),
                            ),
                            ReusableText(
                              text:
                                  "You are required fill all the details fully with the correct information",
                              style: appStyle(11, kGray, FontWeight.normal),
                            ),
                            SizedBox(
                              height: 20.h,
                            ),
                            EmailTextField(
                              hintText: "Additive title",
                              controller: _additiveTitle,
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
                              hintText: "Additive price",
                              controller: _additivePrice,
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
                            foodsController.additives.isNotEmpty
                                ? Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 8.0),
                                    child: ListView.builder(
                                      shrinkWrap: true,
                                      itemCount:
                                          foodsController.additives.length,
                                      itemBuilder: (context, index) {
                                        return RowText(
                                            first: foodsController
                                                .additives[index].title,
                                            second:
                                                "\$ ${foodsController.additives[index].price}");
                                      },
                                    ),
                                  )
                                : const SizedBox.shrink(),
                            CustomButton(
                              text: "A D D    A D D I T I V E",
                              btnHieght: 40,
                              onTap: () {
                                if (_additivePrice.text.isEmpty ||
                                    _additiveTitle.text.isEmpty) {
                                  Get.snackbar(
                                      "Error", "Please enter a valid value",
                                      snackPosition: SnackPosition.BOTTOM);
                                } else {
                                  Additive additive = Additive(
                                      id: foodsController
                                          .generateRandomNumber(),
                                      title: _additiveTitle.text,
                                      price: _additivePrice.text);

                                  foodsController.additives.add(additive);
                                  _additivePrice.clear();
                                  _additiveTitle.clear();
                                }
                              },
                            ),
                            SizedBox(
                              height: 20.h,
                            ),
                            ReusableText(
                              text: "Add Tags",
                              style: appStyle(16, kGray, FontWeight.w600),
                            ),
                            ReusableText(
                              text:
                                  "You are required fill all the details fully with the correct information",
                              style: appStyle(11, kGray, FontWeight.normal),
                            ),
                            SizedBox(
                              height: 20.h,
                            ),
                            EmailTextField(
                              hintText: "Tag title",
                              controller: _tags,
                              prefixIcon: Icon(
                                Ionicons.time_outline,
                                color: Theme.of(context).dividerColor,
                                size: 20.h,
                              ),
                              keyboardType: TextInputType.text,
                            ),
                            SizedBox(
                              height: 10.h,
                            ),
                            foodsController.tags.isNotEmpty
                                ? Row(
                                    children: List.generate(
                                        foodsController.tags.length, (index) {
                                      return Container(
                                        margin: const EdgeInsets.only(right: 5),
                                        decoration: BoxDecoration(
                                            color: kPrimary,
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(8.r))),
                                        child: Center(
                                          child: Padding(
                                            padding: const EdgeInsets.all(2.0),
                                            child: ReusableText(
                                                text:
                                                    foodsController.tags[index],
                                                style: appStyle(8, kLightWhite,
                                                    FontWeight.w400)),
                                          ),
                                        ),
                                      );
                                    }),
                                  )
                                : const SizedBox.shrink(),
                            SizedBox(
                              height: 20.h,
                            ),
                            CustomButton(
                              text: "A D D    T A G S",
                              btnHieght: 40,
                              onTap: () {
                                if (_tags.text.isNotEmpty) {
                                  foodsController.tags.add(_tags.text);
                                  _tags.clear();
                                } else {
                                  Get.snackbar(
                                      "Error", "Please enter a valid value",
                                      snackPosition: SnackPosition.BOTTOM);
                                }
                              },
                            ),
                            SizedBox(
                              height: 10.h,
                            ),
                            const AvailableSwitch(),
                            SizedBox(
                              height: 10.h,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                CustomButton(
                                  text: "B A C K",
                                  btnHieght: 40,
                                  color: kPrimary,
                                  btnWidth: width / 2.5,
                                  onTap: () {
                                    _pageController.previousPage(
                                        duration:
                                            const Duration(milliseconds: 400),
                                        curve: Curves.easeInOut);
                                  },
                                ),
CustomButton(
  text: "S U B M I T",
  color: kPrimary,
  btnHieght: 40,
  btnWidth: width / 2.5,
  onTap: () {
    if (_title.text.isEmpty ||
        _description.text.isEmpty ||
        _price.text.isEmpty ||
        _time.text.isEmpty ||
        foodsController.type.isEmpty ||
        foodsController.additives.isEmpty ||
        foodsController.tags.isEmpty) {
      Get.snackbar(
        "Error",
        "Please enter a valid value",
        snackPosition: SnackPosition.BOTTOM,
      );
    } else {
      // Debugging print statements
      // print('Title: ${_title.text}');
      // print('Description: ${_description.text}');
      // print('Price: ${_price.text}');
      // print('Time: ${_time.text}');
      // if (restaurantController.restaurant == null) {
      //   print('Restaurant is null');
      // } else {
      //   print('Restaurant Code: ${restaurantController.restaurant!.code}');
        print('Restaurant ID: ${restaurantController.restaurant!.id}');
      // }
      // print('Tags: ${imageUploader.images}');

      // // Ensure all necessary fields are not null
      // if (restaurantController.restaurant == null ||
      //     restaurantController.restaurant!.code == null ||
      //     restaurantController.restaurant!.id == null) {
      //   Get.snackbar(
      //     "Error",
      //     "Restaurant information is missing",
      //     snackPosition: SnackPosition.BOTTOM,
      //   );
      //   return;
      // }

      // Rest of your logic...
      AddFoods food = AddFoods(
        title: _title.text,
        foodTags: foodsController.tags,
        foodType: foodsController.type,
        isAvailable: true,
        code: '41007428',
        category: foodsController.category,
        restaurant:restaurantController.restaurantId!,
        description: _description.text,
        time: _time.text,
        price: double.parse(_price.text),
        additives: foodsController.additives,
        imageUrl: imageUploader.images,
      );

      print("Creating JSON for the food item");
      String foodItem = addFoodsToJson(food);
      print("JSON created: $foodItem");

      // Add the food item
      foodsController.addFood(foodItem);
      print("Food item added successfully");

      // Clear text fields and other variables
      _title.clear();
      _description.clear();
      _price.clear();
      _time.clear();
      foodsController.type.clear();
      foodsController.additives.clear();
      foodsController.tags.clear();
      imageUploader.imageOneUrl = "";
      imageUploader.imageTwoUrl = "";
      imageUploader.imageThreeUrl = "";
      imageUploader.imageFourUrl = "";
    }
  },
),

                              ],
                            )
                          ],
                        ),
                      ))
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
