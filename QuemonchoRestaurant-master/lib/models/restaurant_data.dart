// To parse this JSON data, do
//
//     final statistics = statisticsFromJson(jsonString);

import 'dart:convert';

Statistics statisticsFromJson(String str) => Statistics.fromJson(json.decode(str));

String statisticsToJson(Statistics data) => json.encode(data.toJson());

class Statistics {
    final Data data;
    final List<LatestPayout> latestPayout;
    final int ordersTotal;
    final int cancelledOrders;
    final double revenueTotal;
    final int processingOrders;
    final RestaurantToken restaurantToken;

    Statistics({
        required this.data,
        required this.latestPayout,
        required this.ordersTotal,
        required this.cancelledOrders,
        required this.revenueTotal,
        required this.processingOrders,
        required this.restaurantToken,
    });

    factory Statistics.fromJson(Map<String, dynamic> json) => Statistics(
        data: Data.fromJson(json["data"]),
        latestPayout: List<LatestPayout>.from(json["latestPayout"].map((x) => LatestPayout.fromJson(x))),
        ordersTotal: json["ordersTotal"],
        cancelledOrders: json["cancelledOrders"],
        revenueTotal: json["revenueTotal"],
        processingOrders: json["processingOrders"],
        restaurantToken: RestaurantToken.fromJson(json["restaurantToken"]),
    );

    Map<String, dynamic> toJson() => {
        "data": data.toJson(),
        "latestPayout": List<dynamic>.from(latestPayout.map((x) => x.toJson())),
        "ordersTotal": ordersTotal,
        "cancelledOrders": cancelledOrders,
        "revenueTotal": revenueTotal,
        "processingOrders": processingOrders,
        "restaurantToken": restaurantToken.toJson(),
    };
}

class Data {
    final String id;
    final String title;
    final String time;
    final String imageUrl;
    final List<dynamic> foods;
    final bool pickup;
    final bool delivery;
    final String owner;
    final bool isAvailable;
    final String code;
    final String logoUrl;
    final int rating;
    final String ratingCount;
    final String verification;
    final String verificationMessage;
    final double earnings;

    Data({
        required this.id,
        required this.title,
        required this.time,
        required this.imageUrl,
        required this.foods,
        required this.pickup,
        required this.delivery,
        required this.owner,
        required this.isAvailable,
        required this.code,
        required this.logoUrl,
        required this.rating,
        required this.ratingCount,
        required this.verification,
        required this.verificationMessage,
        required this.earnings,
    });

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["_id"],
        title: json["title"],
        time: json["time"],
        imageUrl: json["imageUrl"],
        foods: List<dynamic>.from(json["foods"].map((x) => x)),
        pickup: json["pickup"],
        delivery: json["delivery"],
        owner: json["owner"],
        isAvailable: json["isAvailable"],
        code: json["code"],
        logoUrl: json["logoUrl"],
        rating: json["rating"],
        ratingCount: json["ratingCount"],
        verification: json["verification"],
        verificationMessage: json["verificationMessage"],
        earnings: json["earnings"]?.toDouble(),
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "title": title,
        "time": time,
        "imageUrl": imageUrl,
        "foods": List<dynamic>.from(foods.map((x) => x)),
        "pickup": pickup,
        "delivery": delivery,
        "owner": owner,
        "isAvailable": isAvailable,
        "code": code,
        "logoUrl": logoUrl,
        "rating": rating,
        "ratingCount": ratingCount,
        "verification": verification,
        "verificationMessage": verificationMessage,
        "earnings": earnings,
    };
}

class LatestPayout {
    final String id;
    final String restaurant;
    final double amount;
    final String status;
    final String method;
    final DateTime createdAt;
    final DateTime updatedAt;
    final String accountBank;
    final String accountName;
    final String accountNumber;

    LatestPayout({
        required this.id,
        required this.restaurant,
        required this.amount,
        required this.status,
        required this.method,
        required this.createdAt,
        required this.updatedAt,
        required this.accountBank,
        required this.accountName,
        required this.accountNumber,
    });

    factory LatestPayout.fromJson(Map<String, dynamic> json) => LatestPayout(
        id: json["_id"],
        restaurant: json["restaurant"],
        amount: json["amount"]?.toDouble(),
        status: json["status"],
        method: json["method"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        accountBank: json["accountBank"],
        accountName: json["accountName"],
        accountNumber: json["accountNumber"],
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "restaurant": restaurant,
        "amount": amount,
        "status": status,
        "method": method,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "accountBank": accountBank,
        "accountName": accountName,
        "accountNumber": accountNumber,
    };
}

class RestaurantToken {
    final String id;
    final String fcm;

    RestaurantToken({
        required this.id,
        required this.fcm,
    });

    factory RestaurantToken.fromJson(Map<String, dynamic> json) => RestaurantToken(
        id: json["_id"],
        fcm: json["fcm"],
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "fcm": fcm,
    };
}
