import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:foodly_restaurant/common/app_style.dart';
import 'package:foodly_restaurant/common/reusable_text.dart';
import 'package:foodly_restaurant/constants/constants.dart';
import 'package:foodly_restaurant/models/foods.dart';


class CategoryFoodTile extends StatelessWidget {
  const CategoryFoodTile({
    super.key,
    required this.food, this.onTap,
  });

  final Food food;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Stack(
        clipBehavior: Clip.hardEdge,
        children: [
          Container(
            margin: const EdgeInsets.only(bottom: 8),
            height: 80.h,
            width: width,
            decoration: const BoxDecoration(
                color: kLightWhite,
                borderRadius: BorderRadius.all(Radius.circular(9))),
            child: Container(
              padding: const EdgeInsets.all(4),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: const BorderRadius.all(Radius.circular(12)),
                    child: Stack(
                      children: [
                        SizedBox(
                            height: 80.h,
                            width: 80.h,
                            child: Image.network(
                              food.imageUrl[0],
                              fit: BoxFit.cover,
                            )),
                        Positioned(
                            bottom: 0,
                            right: 0,
                            left: 0,
                            child: Container(
                              padding:
                                  const EdgeInsets.only(left: 2, bottom: 2),
                              color: kGray.withOpacity(0.6),
                              height: 16,
                              width: width,
                              child: RatingBarIndicator(
                                rating: 5,
                                itemBuilder: (context, index) => const Icon(
                                  Icons.star,
                                  color: Colors.amber,
                                ),
                                itemCount: 5,
                                itemSize: 15.0,
                                direction: Axis.horizontal,
                              ),
                            ))
                      ],
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 5,
                      ),
                      ReusableText(
                          text: food.title,
                          style: appStyle(11, kDark, FontWeight.w400)),
                      ReusableText(
                          text: "Delivery time: ${food.time}",
                          style: appStyle(9, kGray, FontWeight.w400)),
                      const SizedBox(
                        height: 5,
                      ),
                      SizedBox(
                        height: 18,
                        width: width * 0.68,
                        child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: food.additives.length,
                            itemBuilder: (context, i) {
                              final addittives = food.additives[i];
                              return Container(
                                margin: const EdgeInsets.only(right: 5),
                                decoration: const BoxDecoration(
                                    color: kSecondaryLight,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(9))),
                                child: Center(
                                  child: Padding(
                                    padding: const EdgeInsets.all(2.0),
                                    child: ReusableText(
                                        text: addittives.title,
                                        style: appStyle(
                                            8, kGray, FontWeight.w400)),
                                  ),
                                ),
                              );
                            }),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
          Positioned(
            right: 5,
            top: 6.h,
            child: Container(
              width: 60.h,
              height: 19.h,
              decoration: const BoxDecoration(
                  color: kPrimary,
                  borderRadius: BorderRadius.all(
                    Radius.circular(10),
                  )),
              child: Center(
                child: ReusableText(
                  text: "\$ ${food.price.toString()}",
                  style: appStyle(12, kLightWhite, FontWeight.bold),
                ),
              ),
            ),
          ),
          Positioned(
              right: 70.h,
              top: 6.h,
              child: Container(
                width: 19.h,
                height: 19.h,
                decoration: const BoxDecoration(
                    color: kSecondary,
                    borderRadius: BorderRadius.all(Radius.circular(10))),
                child: GestureDetector(
                  onTap: () {},
                  child: const Center(
                    child: Icon(
                      MaterialCommunityIcons.file_document_edit,
                      size: 15,
                      color: kLightWhite,
                    ),
                  ),
                ),
              ))
        ],
      ),
    );
  }
}
