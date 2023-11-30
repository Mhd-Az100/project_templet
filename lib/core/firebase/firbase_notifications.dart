// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:developer';

import 'package:base_templet/core/dependency_injection/injection_container.dart';
import 'package:base_templet/core/session_management/session.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationInitial {
  String? fcmToken;
  NotificationInitial({
    this.fcmToken,
  });
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
  registerOnFirebase() async {
    try {
      await _firebaseMessaging.subscribeToTopic('all');
      await _firebaseMessaging.getToken().then(
        (token) {
          fcmToken = token;
          if (fcmToken != null) {
            log(fcmToken.toString());
            injection<GlobalSession>().setFcmToken(fcmToken ?? '');
          }
        },
      );
      FirebaseMessaging.onMessage.listen(
        (RemoteMessage message) {
          inspect(message);
          // log((message.toString()), name: "this is the messsssssssssage : ");
          RemoteNotification? notification = message.notification;
          AndroidNotification? android = message.notification?.android;
          var flutterLocalNotificationsPlugin =
              FlutterLocalNotificationsPlugin();
          AndroidNotificationChannel channel;
          if (!kIsWeb) {
            channel = const AndroidNotificationChannel(
              'high_importance_channel', // id
              'High Importance Notifications', // title

              description:
                  'This channel is used for important notifications.', // description
              importance: Importance.high,
            );

            flutterLocalNotificationsPlugin
                .resolvePlatformSpecificImplementation<
                    AndroidFlutterLocalNotificationsPlugin>()
                ?.createNotificationChannel(channel);
            if (notification != null && android != null) {
              flutterLocalNotificationsPlugin.show(
                notification.hashCode,
                notification.title,
                notification.body,
                NotificationDetails(
                  android: AndroidNotificationDetails(
                    channel.id,
                    channel.name,
                    channelDescription: channel.description,
                    icon: 'launch_background',
                  ),
                ),
              );
            }
          }
        },
      );
    } catch (e) {
      log(e.toString(), name: "error in firebase fcm token");
    }
  }
}
