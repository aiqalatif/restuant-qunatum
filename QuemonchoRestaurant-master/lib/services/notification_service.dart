// ignore_for_file: no_leading_underscores_for_local_identifiers

import 'dart:convert';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:foodly_restaurant/controllers/notifications_controller.dart';
import 'package:foodly_restaurant/main.dart';
import 'package:get/get.dart';

class NotificationService {
  final controller = Get.put(NotificationsController());
  final _messaging = FirebaseMessaging.instance;

  Future<void> initialize(
      FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin) async {
    var androidInitialize =
        const AndroidInitializationSettings('notification_icon');
    var iOSInitialize = const DarwinInitializationSettings();
    var initializationsSettings =
        InitializationSettings(android: androidInitialize, iOS: iOSInitialize);
    flutterLocalNotificationsPlugin.initialize(initializationsSettings,
        onDidReceiveNotificationResponse: (data) {
      try {
        if (data.payload!.isNotEmpty) {
           navigatorKey.currentState
              ?.pushNamed('/order_details_page', arguments: data);
        } else {
          //  Get.toNamed(RouteHelper.getNotificationRoute());
        }
      } catch (e) {}
    });


    await _messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );

    final token = await _messaging.getToken();
    if (token != null) {
      controller.setFcm = token;
    }

    initPushNotification();
  }

  void handleMessage(RemoteMessage? message) {
    if (message?.notification != null) {
      navigatorKey.currentState
          ?.pushNamed('/order_details_page', arguments: message);
    } else {
      return;
    }
  }

  void initPushNotification() {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print(
          "onMessage: ${message.notification?.title}/${message.notification?.body}/${message.notification?.titleLocKey}");
      
      String orderData = jsonEncode(message.data);
      showBigTextNotification(
          message.notification!.body!,
          message.notification!.title!,
          orderData,
          flutterLocalNotificationsPlugin);
     
    });
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print(
          "onOpenApp: ${message.notification?.title}/${message.notification?.body}/${jsonEncode(message.data)}/${message.notification?.titleLocKey}");
      try {} catch (e) {
        print(e.toString());
      }
    });
  }

  static Future<void> showBigTextNotification(String title, String body,
      String orderID, FlutterLocalNotificationsPlugin fln) async {
    BigTextStyleInformation bigTextStyleInformation = BigTextStyleInformation(
      body,
      htmlFormatBigText: true,
      contentTitle: title,
      htmlFormatContentTitle: true,
    );
    AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails(
      'channel_id_5', 'foodly_flutter', importance: Importance.high,
      styleInformation: bigTextStyleInformation, priority: Priority.high,
      playSound: true,
      //sound: RawResourceAndroidNotificationSound('notification'),
    );
    NotificationDetails platformChannelSpecifics =
        NotificationDetails(android: androidPlatformChannelSpecifics);
    await fln.show(0, title, body, platformChannelSpecifics, payload: orderID);
  }
}
