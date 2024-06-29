
import 'dart:convert';

import 'package:foodly_restaurant/models/foods.dart';

AddFoods addFoodsFromJson(String str) => AddFoods.fromJson(json.decode(str));

String addFoodsToJson(AddFoods data) => json.encode(data.toJson());

class AddFoods {
    final String title;
    final List<String> foodTags;
    final List<String> foodType;
    final String code;
    final String category;
    final bool isAvailable;
    final String restaurant;
    final String time;
    final String description;
    final double price;
    final List<Additive> additives;
    final List<String> imageUrl;

    AddFoods({
        required this.title,
        required this.foodTags,
        required this.foodType,
        required this.code,
        required this.category,
        required this.isAvailable,
        required this.restaurant,
        required this.description,
        required this.price,
        required this.time,
        required this.additives,
        required this.imageUrl,
    });

    factory AddFoods.fromJson(Map<String, dynamic> json) => AddFoods(
        title: json["title"],
        foodTags: List<String>.from(json["foodTags"].map((x) => x)),
        foodType: List<String>.from(json["foodType"].map((x) => x)),
        code: json["code"],
        category: json["category"],
        isAvailable: json["isAvailable"],
        restaurant: json["restaurant"],
        time: json["time"],
        description: json["description"],
        price: json["price"]?.toDouble(),
        additives: List<Additive>.from(json["additives"].map((x) => Additive.fromJson(x))),
        imageUrl: List<String>.from(json["imageUrl"].map((x) => x)),
    );

    Map<String, dynamic> toJson() => {
        "title": title,
        "foodTags": List<dynamic>.from(foodTags.map((x) => x)),
        "foodType": List<dynamic>.from(foodType.map((x) => x)),
        "code": code,
        "category": category,
        "isAvailable": isAvailable,
        "restaurant": restaurant,
        "time": time,
        "description": description,
        "price": price,
        "additives": List<dynamic>.from(additives.map((x) => x.toJson())),
        "imageUrl": List<dynamic>.from(imageUrl.map((x) => x)),
    };
}


