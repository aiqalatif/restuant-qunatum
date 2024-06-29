import 'dart:convert';

DistanceTime distanceTimeFromJson(String str) => DistanceTime.fromJson(json.decode(str));


class DistanceTime {
    final double price;
    final double distance;
    final double time;

    DistanceTime({
        required this.price,
        required this.distance,
        required this.time,
    });

    factory DistanceTime.fromJson(Map<String, dynamic> json) => DistanceTime(
        price: json["price"]?.toDouble(),
        distance: json["distance"]?.toDouble(),
        time: json["time"]?.toDouble(),
    );
}
