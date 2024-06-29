import 'dart:convert';

List<ReadyOrders> orderFromJson(String str) {
  try {
    final jsonData = json.decode(str);
    final foodList = jsonData['orders'] as List<dynamic>;
    return List<ReadyOrders>.from(foodList.map((x) => ReadyOrders.fromJson(x as Map<String, dynamic>)));
  } catch (e) {
    print("Error parsing JSON: $e");
    return [];
  }
}

String orderToJson(List<ReadyOrders> data) {
  return json.encode({'orders': data.map((x) => x.toJson()).toList()});
}

class ReadyOrders {
  final String id;
  final UserId userId;
  final List<OrderItem> orderItems;
  final double deliveryFee;
  final DeliveryAddress deliveryAddress;
  final String orderStatus;
  final RestaurantId restaurantId;
  final List<double> restaurantCoords;
  final List<double> recipientCoords;

  ReadyOrders({
    required this.id,
    required this.userId,
    required this.orderItems,
    required this.deliveryFee,
    required this.deliveryAddress,
    required this.orderStatus,
    required this.restaurantId,
    required this.restaurantCoords,
    required this.recipientCoords,
  });

  factory ReadyOrders.fromJson(Map<String, dynamic> json) {
    // print("Parsing ReadyOrders from JSON: $json");
    return ReadyOrders(
      id: json["_id"] ?? '',
      userId: UserId.fromJson(json["userId"] as Map<String, dynamic>),
      orderItems: List<OrderItem>.from((json["orderItems"] as List<dynamic>).map((x) => OrderItem.fromJson(x as Map<String, dynamic>))),
      deliveryFee: (json["deliveryFee"] ?? 0).toDouble(),
      deliveryAddress: DeliveryAddress.fromJson(json["deliveryAddress"] as Map<String, dynamic>),
      orderStatus: json["orderStatus"] ?? '',
      restaurantId: RestaurantId.fromJson(json["restaurantId"] as Map<String, dynamic>),
      restaurantCoords: List<double>.from((json["restaurantCoords"] as List<dynamic>).map((x) => (x as num).toDouble())),
      recipientCoords: List<double>.from((json["recipientCoords"] as List<dynamic>).map((x) => (x as num).toDouble())),
    );
  }

  Map<String, dynamic> toJson() => {
    "_id": id,
    "userId": userId.toJson(),
    "orderItems": List<dynamic>.from(orderItems.map((x) => x.toJson())),
    "deliveryFee": deliveryFee,
    "deliveryAddress": deliveryAddress.toJson(),
    "orderStatus": orderStatus,
    "restaurantId": restaurantId.toJson(),
    "restaurantCoords": List<dynamic>.from(restaurantCoords.map((x) => x)),
    "recipientCoords": List<dynamic>.from(recipientCoords.map((x) => x)),
  };
}

class DeliveryAddress {
  final String id;
  final String addressLine1;

  DeliveryAddress({
    required this.id,
    required this.addressLine1,
  });

  factory DeliveryAddress.fromJson(Map<String, dynamic> json) {
    // print("Parsing DeliveryAddress from JSON: $json");
    return DeliveryAddress(
      id: json["_id"] ?? '',
      addressLine1: json["addressLine1"] ?? '',
    );
  }

  Map<String, dynamic> toJson() => {
    "_id": id,
    "addressLine1": addressLine1,
  };
}

class OrderItem {
  final FoodId foodId;
  final int quantity;
  final double price;
  final List<String> additives;
  final String instructions;
  final String id;

  OrderItem({
    required this.foodId,
    required this.quantity,
    required this.price,
    required this.additives,
    required this.instructions,
    required this.id,
  });

  factory OrderItem.fromJson(Map<String, dynamic> json) {
    // print("Parsing OrderItem from JSON: $json");
    return OrderItem(
      foodId: FoodId.fromJson(json["foodId"] as Map<String, dynamic>),
      quantity: json["quantity"] ?? 0,
      price: (json["price"] ?? 0).toDouble(),
      additives: List<String>.from((json["additives"] as List<dynamic>).map((x) => x as String)),
      instructions: json["instructions"] ?? '',
      id: json["_id"] ?? '',
    );
  }

  Map<String, dynamic> toJson() => {
    "foodId": foodId.toJson(),
    "quantity": quantity,
    "price": price,
    "additives": List<dynamic>.from(additives.map((x) => x)),
    "instructions": instructions,
    "_id": id,
  };
}

class FoodId {
  final String id;
  final String title;
  final String time;
  final List<String> imageUrl;

  FoodId({
    required this.id,
    required this.title,
    required this.time,
    required this.imageUrl,
  });

  factory FoodId.fromJson(Map<String, dynamic> json) {
    print("Parsing FoodId from JSON: $json");
    return FoodId(
      id: json["_id"] ?? '',
      title: json["title"] ?? '',
      time: json["time"] ?? '',
      imageUrl: List<String>.from((json["imageUrl"] as List<dynamic>).map((x) => x as String)),
    );
  }

  Map<String, dynamic> toJson() => {
    "_id": id,
    "title": title,
    "time": time,
    "imageUrl": List<dynamic>.from(imageUrl.map((x) => x)),
  };
}

class RestaurantId {
  final String id;
  final String title;
  final String time;
  final String imageUrl;
  final String logoUrl;

  RestaurantId({
    required this.id,
    required this.title,
    required this.time,
    required this.imageUrl,
    required this.logoUrl,
  });

  factory RestaurantId.fromJson(Map<String, dynamic> json) {
    print("Parsing RestaurantId from JSON___________________________________________--: $json");
    return RestaurantId(
      id: json["_id"] ?? '',
      title: json["title"] ?? '',
      time: json["time"] ?? '',
      imageUrl: json["imageUrl"] ?? '',
      logoUrl: json["logoUrl"] ?? '',
    );
  }

  Map<String, dynamic> toJson() => {
    "_id": id,
    "title": title,
    "time": time,
    "imageUrl": imageUrl,
    "logoUrl": logoUrl,
  };
}

class UserId {
  final String id;
  final String phone;
  final String profile;

  UserId({
    required this.id,
    required this.phone,
    required this.profile,
  });

  factory UserId.fromJson(Map<String, dynamic> json) {
    print("Parsing UserId from JSON: $json");
    return UserId(
      id: json["_id"] ?? '',
      phone: json["phone"] ?? '',
      profile: json["profile"] ?? '',
    );
  }

  Map<String, dynamic> toJson() => {
    "_id": id,
    "phone": phone,
    "profile": profile,
  };
}
