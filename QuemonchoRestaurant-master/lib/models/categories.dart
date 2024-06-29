import 'dart:convert';

class Categories {
  String? id;
  String? title;
  String? value;
  String? imageUrl;

  Categories({this.id, this.title, this.value, this.imageUrl});

  factory Categories.fromJson(Map<String, dynamic> json) {
    return Categories(
      id: json['_id'],
      title: json['title'],
      value: json['value'],
      imageUrl: json['imageUrl'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['_id'] = id;
    data['title'] = title;
    data['value'] = value;
    data['imageUrl'] = imageUrl;
    return data;
  }
}
List<Categories> categoryFromJson(String str) =>
    List<Categories>.from(json.decode(str)['data'].map((x) => Categories.fromJson(x)));

String restaurantsToJson(List<Categories> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));