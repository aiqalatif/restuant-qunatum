
import 'dart:convert';

GetOrder getOrderFromJson(String str) => GetOrder.fromJson(json.decode(str));

String getOrderToJson(GetOrder data) => json.encode(data.toJson());

class GetOrder {
    final String id;
    final UserId userId;
    final List<OrderItem> orderItems;
    final double deliveryFee;
    final DeliveryAddress deliveryAddress;
    final String orderStatus;
    final RestaurantId restaurantId;
    final List<double> restaurantCoords;
    final List<double> recipientCoords;

    GetOrder({
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

    factory GetOrder.fromJson(Map<String, dynamic> json) => GetOrder(
        id: json["_id"],
        userId: UserId.fromJson(json["userId"]),
        orderItems: List<OrderItem>.from(json["orderItems"].map((x) => OrderItem.fromJson(x))),
        deliveryFee: json["deliveryFee"]?.toDouble(),
        deliveryAddress: DeliveryAddress.fromJson(json["deliveryAddress"]),
        orderStatus: json["orderStatus"],
        restaurantId: RestaurantId.fromJson(json["restaurantId"]),
        restaurantCoords: List<double>.from(json["restaurantCoords"].map((x) => x?.toDouble())),
        recipientCoords: List<double>.from(json["recipientCoords"].map((x) => x?.toDouble())),
    );

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

    factory DeliveryAddress.fromJson(Map<String, dynamic> json) => DeliveryAddress(
        id: json["_id"],
        addressLine1: json["addressLine1"],
    );

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

    factory OrderItem.fromJson(Map<String, dynamic> json) => OrderItem(
        foodId: FoodId.fromJson(json["foodId"]),
        quantity: json["quantity"],
        price: json["price"]?.toDouble(),
        additives: List<String>.from(json["additives"].map((x) => x)),
        instructions: json["instructions"],
        id: json["_id"],
    );

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
    final List<String> imageUrl;
    final String time;

    FoodId({
        required this.id,
        required this.title,
        required this.imageUrl,
        required this.time,
    });

    factory FoodId.fromJson(Map<String, dynamic> json) => FoodId(
        id: json["_id"],
        title: json["title"],
        imageUrl: List<String>.from(json["imageUrl"].map((x) => x)),
        time: json["time"],
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "title": title,
        "imageUrl": List<dynamic>.from(imageUrl.map((x) => x)),
        "time": time,
    };
}

class RestaurantId {
    final Coords coords;
    final String id;
    final String title;
    final String time;
    final String imageUrl;
    final String logoUrl;

    RestaurantId({
        required this.coords,
        required this.id,
        required this.title,
        required this.time,
        required this.imageUrl,
        required this.logoUrl,
    });

    factory RestaurantId.fromJson(Map<String, dynamic> json) => RestaurantId(
        coords: Coords.fromJson(json["coords"]),
        id: json["_id"],
        title: json["title"],
        time: json["time"],
        imageUrl: json["imageUrl"],
        logoUrl: json["logoUrl"],
    );

    Map<String, dynamic> toJson() => {
        "coords": coords.toJson(),
        "_id": id,
        "title": title,
        "time": time,
        "imageUrl": imageUrl,
        "logoUrl": logoUrl,
    };
}

class Coords {
    final String id;
    final double latitude;
    final double longitude;
    final String address;
    final String title;
    final double latitudeDelta;
    final double longitudeDelta;

    Coords({
        required this.id,
        required this.latitude,
        required this.longitude,
        required this.address,
        required this.title,
        required this.latitudeDelta,
        required this.longitudeDelta,
    });

    factory Coords.fromJson(Map<String, dynamic> json) => Coords(
        id: json["id"],
        latitude: json["latitude"]?.toDouble(),
        longitude: json["longitude"]?.toDouble(),
        address: json["address"],
        title: json["title"],
        latitudeDelta: json["latitudeDelta"]?.toDouble(),
        longitudeDelta: json["longitudeDelta"]?.toDouble(),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "latitude": latitude,
        "longitude": longitude,
        "address": address,
        "title": title,
        "latitudeDelta": latitudeDelta,
        "longitudeDelta": longitudeDelta,
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

    factory UserId.fromJson(Map<String, dynamic> json) => UserId(
        id: json["_id"],
        phone: json["phone"],
        profile: json["profile"],
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "phone": phone,
        "profile": profile,
    };
}
