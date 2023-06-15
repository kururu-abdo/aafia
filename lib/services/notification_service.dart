import 'package:aafia/data/models/base/push_notification_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationService {
  //Singleton pattern
  static final NotificationService _notificationService =
      NotificationService._internal();
  factory NotificationService() {
    return _notificationService;
  }
  NotificationService._internal();

    //instance of FlutterLocalNotificationsPlugin
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = 
      FlutterLocalNotificationsPlugin();

 requestIOSPermissions(
    ) {
  flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
          IOSFlutterLocalNotificationsPlugin>()
      ?.requestPermissions(
        alert: true,
        badge: true,
        sound: true,
      );
}



            Future<void> init() async {

    //Initialization Settings for Android
    final AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('app_icon');

    //Initialization Settings for iOS 
    final IOSInitializationSettings initializationSettingsIOS =
        IOSInitializationSettings(
      requestSoundPermission: false,
      requestBadgePermission: false,
      requestAlertPermission: false,
    );

    //InitializationSettings for initializing settings for both platforms (Android & iOS)
    final InitializationSettings initializationSettings =
        InitializationSettings(
            android: initializationSettingsAndroid,
            iOS: initializationSettingsIOS);

    await flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
    );
  }
  Future selectNotification(String payload) async {
    // await Navigator.push(
    //   context,
    //   MaterialPageRoute<void>(builder: (context) => SecondScreen(payload)),
    // );
}


 static   AndroidNotificationDetails _androidNotificationDetails =
      AndroidNotificationDetails(
    'channel ID',
    'channel name',
    'channel description',
    playSound: true,
    priority: Priority.high,
    importance: Importance.high,
  );
static  IOSNotificationDetails _iosNotificationDetails =
 IOSNotificationDetails(
    presentAlert: true,
    presentBadge: true,
    presentSound: true,
    badgeNumber: null,
    // attachments: List<IOSNotificationAttachment>?
    // subtitle: String?, 
    //     threadIdentifier: String?
  );
  NotificationDetails platformChannelSpecifics = 
  NotificationDetails(
    android: _androidNotificationDetails,
    iOS: _iosNotificationDetails);



 Future<void> showNotifications(PushNotification pushNotification) async {
    await flutterLocalNotificationsPlugin.show(
      pushNotification.id!,
     pushNotification.title,
      pushNotification.body,
      platformChannelSpecifics,
      payload: 'Notification Payload',
    );
  }








}