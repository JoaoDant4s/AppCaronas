import 'package:firebase_messaging/firebase_messaging.dart';

class FirebaseNotifications {
  final messaging = FirebaseMessaging.instance;

  // final androidChannel = const AndroidNotificationChannel(
  //   "high_importance_channel",
  //   "High Importance Notifications",
  //   description: 'This channel is used for important notifications',
  //   importance: Importance.defaultImportance,
  // );

  // final localNotifications = FlutterLocalNotificationsPlugin();

  // Future<void> handleMessage(RemoteMessage? message) async {
  //   if (message == null) return;
  //   navigatorKey.currentState?.pushNamed(AppRoutes.SEARCH);
  // }

  // Future initPushNotifications() async {
  //   await messaging.setForegroundNotificationPresentationOptions(
  //     alert: true,
  //     badge: true,
  //     sound: true,
  //   );

  //   messaging.getInitialMessage().then(handleMessage);
  //   FirebaseMessaging.onMessageOpenedApp.listen(handleMessage);
  //   FirebaseMessaging.onBackgroundMessage(handleBackgroundMessage);
  //   FirebaseMessaging.onMessage.listen((message) {
  //     final notification = message.notification;
  //     if (notification == null) return;
  //     localNotifications.show(
  //         notification.hashCode,
  //         notification.title,
  //         notification.body,
  //         NotificationDetails(
  //           android: AndroidNotificationDetails(
  //             androidChannel.id,
  //             androidChannel.name,
  //             channelDescription: androidChannel.description,
  //             icon: '@drawable/ic_launcher',
  //           ),
  //         ),
  //         payload: jsonEncode(message.toMap()));
  //   });
  // }

  Future<void> handleBackgroundMessage(RemoteMessage message) async {
    print("Title: ${message.notification?.title}");
    print("Body: ${message.notification?.body}");
    print("Payload: ${message.data}");
  }

  Future<void> initNotifications() async {
    await messaging.requestPermission();
    final fCMToken = await messaging.getToken();
    print(fCMToken);
    FirebaseMessaging.onBackgroundMessage(handleBackgroundMessage);
  }

  // Future initLocalNotifications() async {
  //   const android = AndroidInitializationSettings('@drawable/ic_laucher');
  //   const settings = InitializationSettings(android: android);

  //   await localNotifications.initialize(settings);
  // }
}
