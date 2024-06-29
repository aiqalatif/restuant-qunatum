import 'dart:convert';

class Reservation {
  String id;
  User user;
  DateTime dateTime;
  int numberOfGuests;
  String specialRequests;
  String status;

  Reservation({
    required this.id,
    required this.user,
    required this.dateTime,
    required this.numberOfGuests,
    required this.specialRequests,
    required this.status,
  });

  factory Reservation.fromJson(Map<String, dynamic> json) {
    return Reservation(
      id: json['_id'],
      user: User.fromJson(json['user']),
      dateTime: DateTime.parse(json['dateTime']),
      numberOfGuests: json['numberOfGuests'],
      specialRequests: json['specialRequests'],
      status: json['status'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'user': user.toJson(),
      'dateTime': dateTime.toIso8601String(),
      'numberOfGuests': numberOfGuests,
      'specialRequests': specialRequests,
      'status': status,
    };
  }
}

class User {
  String id;
  String email;
  String phone;
  String profile;

  User({
    required this.id,
    required this.email,
    required this.phone,
    required this.profile,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['_id'],
      email: json['email'],
      phone: json['phone'],
      profile: json['profile'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'email': email,
      'phone': phone,
      'profile': profile,
    };
  }
}
 
List<Reservation> reservationFromJson(String str) {
  try {
    final jsonData = json.decode(str);
    final foodList = jsonData['data'] as List<dynamic>;
    return List<Reservation>.from(foodList.map((x) => Reservation.fromJson(x as Map<String, dynamic>)));
  } catch (e) {
    print("Error parsing JSON: $e");
    return [];
  }
}

String orderToJson(List<Reservation> data) {
  return json.encode({'data': data.map((x) => x.toJson()).toList()});
}