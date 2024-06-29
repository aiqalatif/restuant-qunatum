import 'dart:convert';
List<Food> foodFromJson(String str) {
  final parsed = json.decode(str);
  List<dynamic> foodList = parsed["food"]; 

  return List<Food>.from(foodList.map((x) => Food.fromJson(x)));
}


class Food {
    final String id;
    final String title;
    final List<String> foodTags;
    final List<String?> foodType;
    final String code;
    final bool isAvailable;
    final String restaurant;
    final double rating;
    final String ratingCount;
    final String description;
    final double price;
    final List<Additive> additives;
    final List<String> imageUrl;
    final int v;
    final String category;
    final String time;

    Food({
        required this.id,
        required this.title,
        required this.foodTags,
        required this.foodType,
        required this.code,
        required this.isAvailable,
        required this.restaurant,
        required this.rating,
        required this.ratingCount,
        required this.description,
        required this.price,
        required this.additives,
        required this.imageUrl,
        required this.v,
        required this.category,
        required this.time,
    });

    factory Food.fromJson(Map<String, dynamic> json) => Food(
        id: json["_id"],
        title: json["title"],
        foodTags: List<String>.from(json["foodTags"].map((x) => x)),
        foodType: List<String?>.from(json["foodType"].map((x) => x)),
        code: json["code"],
        isAvailable: json["isAvailable"],
        restaurant: json["restaurant"],
        rating: json["rating"]?.toDouble(),
        ratingCount: json["ratingCount"],
        description: json["description"],
        price: json["price"]?.toDouble(),
        additives: List<Additive>.from(json["additives"].map((x) => Additive.fromJson(x))),
        imageUrl: List<String>.from(json["imageUrl"].map((x) => x)),
        v: json["__v"],
        category: json["category"],
        time: json["time"],
    );

}

class Additive {
    final int id;
    final String title;
    final String price;

    Additive({
        required this.id,
        required this.title,
        required this.price,
    });

    factory Additive.fromJson(Map<String, dynamic> json) => Additive(
        id: json["id"],
        title: json["title"],
        price: json["price"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "price": price,
    };
}