import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
// ignore: depend_on_referenced_packages
import 'package:http/http.dart' as http;
import 'package:blukers_client_app/service/pref_services.dart';
import 'package:blukers_client_app/utils/pref_keys.dart';

class NotificationService {
  static Map<String, dynamic> noti = {};
  static Future<void> init() async {
    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
      alert: true, // Required to display a heads up notification
      badge: true,
      sound: true,
    );

    const AndroidNotificationChannel channel = AndroidNotificationChannel(
      'high_importance_channel', // id
      'High Importance Notifications', // title
      importance: Importance.max,
    );

    final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
        FlutterLocalNotificationsPlugin();

    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);

    FirebaseMessaging.onMessage.listen((RemoteMessage? message) {
      RemoteNotification? notification = message?.notification;
      AndroidNotification? android = message?.notification?.android;

      // If `onMessage` is triggered with a notification, construct our own
      // local notification to show to users using the created channel.
      if (notification != null && android != null) {
        Map<String, dynamic> payload = message!.data;
        flutterLocalNotificationsPlugin.show(
          notification.hashCode,
          notification.title,
          notification.body,
          NotificationDetails(
            android: AndroidNotificationDetails(
              channel.id,
              channel.name,
              icon: android.smallIcon,
              // other properties...
            ),
          ),
          payload: jsonEncode(payload),
        );
        noti = {
          "title": notification.title,
          "body": notification.body,
        };
      }
      FirebaseFirestore.instance.collection("Notification").doc().set({
        "title": notification?.title,
        "body": notification?.body,
        "deviceToken": PrefService.getString(PrefKeys.deviceToken),
      });
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) async {
      await Firebase.initializeApp();
    });

    FirebaseMessaging.instance
        .getInitialMessage()
        .then((RemoteMessage? message) async {});
    await FirebaseMessaging.instance.setAutoInitEnabled(true);

    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');
    const IOSInitializationSettings initializationSettingsIOS =
        IOSInitializationSettings(
            onDidReceiveLocalNotification: onDidReceiveLocalNotification);
    const InitializationSettings initializationSettings =
        InitializationSettings(
            android: initializationSettingsAndroid,
            iOS: initializationSettingsIOS);

    flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onSelectNotification: (String? payload) async {
      if (payload != null) {
        if (true) {}
      }
    });
  }

  static Future<void> _firebaseMessagingBackgroundHandler(
      RemoteMessage message) async {
    await Firebase.initializeApp();
  }

  static Future onDidReceiveLocalNotification(
    int id,
    String? title,
    String? body,
    String? payload,
  ) async {}

  static Future<String?> getToken() async {
    try {
      return await FirebaseMessaging.instance.getToken();
    } catch (e) {
      debugPrint(e.toString());
      return null;
    }
  }

  static FirebaseMessaging message = FirebaseMessaging.instance;

  static const String serverToken =
      'AAAAmOaKNCQ:APA91bFqbgmjl8dlMHvZpfArI9ekY8dg9NSg7kqOzunggtGggN_kJcq8HalG7VD5J4MpkEu3Mq5H0F7vmugPHC_k8hCbe0GqdBeZA6lwlms4m2NiFJFHD-noCYmN3QuoBvcx8EQlfuhI';

  static Future<String?> getFcmToken() async {
    return await message.getToken();
  }

  static Future<void> sendNotification(
      SendNotificationModel notification) async {
    await http.post(
      Uri.parse('https://fcm.googleapis.com/fcm/send'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'key=$serverToken',
      },
      body: jsonEncode(notification.toMap()),
    );
  }
}

class SendNotificationModel {
  String? id;
  String? chatId;
  String? title;
  String? body;
  List<String>? fcmTokens;

  SendNotificationModel({
    this.chatId,
    this.title,
    this.body,
    this.id,
    this.fcmTokens,
  });

  Map<String, dynamic> toMap() => {
        "registration_ids": fcmTokens,
        "data": {
          "id": id,
          "chatId": chatId,
          "click_action": "FLUTTER_NOTIFICATION_CLICK",
          "sound": "default",
        },
        "priority": "high",
        "notification": {
          "title": title,
          "body": body,
        }
      };
}
