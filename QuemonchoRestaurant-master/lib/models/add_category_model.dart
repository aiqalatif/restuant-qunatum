// To parse this JSON data, do
//
//     final addCategoryModel = addCategoryModelFromJson(jsonString);

import 'dart:convert';

AddCategoryModel addCategoryModelFromJson(String str) => AddCategoryModel.fromJson(json.decode(str));

String addCategoryModelToJson(AddCategoryModel data) => json.encode(data.toJson());

class AddCategoryModel {
    final String title;
    final String value;
    final String imageUrl;

    AddCategoryModel({
        required this.title,
        required this.value,
        required this.imageUrl,
    });

    factory AddCategoryModel.fromJson(Map<String, dynamic> json) => AddCategoryModel(
        title: json["title"],
        value: json["value"],
        imageUrl: json["imageUrl"],
    );

    Map<String, dynamic> toJson() => {
        "title": title,
        "value": value,
        "imageUrl": imageUrl,
    };
}
