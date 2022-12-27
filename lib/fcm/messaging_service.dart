import 'dart:developer';
import 'dart:io';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:kirana_store/core/core.dart';
import 'package:kirana_store/main.dart';
import 'package:rxdart/rxdart.dart';

import '../ui/ui.dart';


//*** for background notification initiate this must be on top on any class ***//
Future _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  debugPrint(" --- background message received in service---");
  debugPrint("_firebaseMessagingBackgroundHandler message: $message");
  debugPrint(
      "_firebaseMessagingBackgroundHandler title: ${message.notification!.title}");
  debugPrint(
      "_firebaseMessagingBackgroundHandler body: ${message.notification!.body}");
}

class MessagingService {
  MessagingService();
  final _messageStreamController = BehaviorSubject<RemoteMessage>();
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

  Future init() async {
    final settings = await _requestPermission();

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      debugPrint("authorized ");
      _getToken();
      _registerForegroundMessageHandler();
      FirebaseMessaging.onBackgroundMessage(
          _firebaseMessagingBackgroundHandler);
    } else {
      log("permission denied android");
    }
    if (Platform.isIOS) {
      debugPrint("ios permission");
      await _firebaseMessaging.setForegroundNotificationPresentationOptions(
        alert: true, // Required to display a heads up notification
        badge: true,
        sound: true,
      );
    }
  }

  Future _getToken() async {
    final fcmToken = await FirebaseMessaging.instance.getToken();
    bool login =await navKey.currentContext!.read<LocalRepository>().isLoggedIn();
    if (kDebugMode) {
      print(' fcm $fcmToken');
    }
    if (fcmToken != null) {
    navKey.currentContext!.read<LocalRepository>().setFcmToken(fcmToken);
    }
    FirebaseMessaging.instance.onTokenRefresh.listen((newToken) async {
      navKey.currentContext!.read<LocalRepository>().setFcmToken(newToken);
    });

    //open app from terminated state
    FirebaseMessaging.instance.getInitialMessage().then((message) {
      if (message != null) {
        log('payload open page from terminated app  on notification click');
        //navigation route to open page

        if(login==true) {
          Future.delayed(const Duration(seconds: 6), () {
            var notificationData = message.data;
            if (notificationData.isNotEmpty) {

                navKey.currentState!.push(MaterialPageRoute(
                    builder: (BuildContext context) =>
                        const NotificationScreen()));

            }
          });
         } else {}
      }
    });
    var printValue = false;
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      printValue = true;
      if (printValue == true) {
        printValue = false;
        log('payload open app page from background notification on click $printValue');
        openPage(message, navKey.currentContext!, 1);
      }
    });
  }

  Future<NotificationSettings> _requestPermission() async {
    return await _firebaseMessaging.requestPermission(
        alert: true,
        badge: true,
        sound: true,
        carPlay: false,
        criticalAlert: true,
        provisional: true,
        announcement: true);
  }

  Future _registerForegroundMessageHandler() async {
    // await Firebase.initializeApp();
    FirebaseMessaging.onMessage.listen((remoteMessage) {
      log(" --- Foreground message received Service---");
      log("_registerForegroundMessageHandler message: $remoteMessage");

        _handleMessage(remoteMessage, 2);

    }, onError: (e) {
      log('Foreground message  Service Error $e');
    });
  }
}

//call only when app is in foreground state
Future<void> _handleMessage(RemoteMessage message, int type) async {
  log('_handleMessage ${message.data} type: $type');
  //for foreground notification
  _showNotification(
      message, message.notification!.title!, message.notification!.body!, type);
}

//call only when app is in foreground state
Future _showNotification(
    RemoteMessage message,
    String title,
    String body,
    int notificationId,
    ) async {
  if (kDebugMode) {
    print('show notification');
  }
  FlutterLocalNotificationsPlugin flip = FlutterLocalNotificationsPlugin();

  // app_icon needs to be a added as a drawable
  var android =
  const AndroidInitializationSettings('@mipmap/ic_launcher');
  var iosSettings = const DarwinInitializationSettings(
    requestSoundPermission: false,
    requestBadgePermission: false,
    requestAlertPermission: false,
  );

  // initialise settings for both Android and iOS device.
  var settings = InitializationSettings(android: android, iOS: iosSettings);
  await flip.initialize(settings, onDidReceiveNotificationResponse:
      (NotificationResponse notificationResponse) {
    openPage(message, navKey.currentContext!, notificationId);
    flip.cancel(notificationId);
  });

  AndroidNotificationDetails androidPlatformChannelSpecifics =
  const AndroidNotificationDetails(
    'progress channel',
    'progress channel',
    channelDescription: 'progress channel description',
    channelShowBadge: false,
    importance: Importance.high,
    onlyAlertOnce: true,
    showProgress: false,
  );
  var iOSPlatformChannelSpecifics = const DarwinNotificationDetails(
    presentAlert: true,
    presentBadge: true,
    presentSound: true,
  );

  final NotificationDetails platformChannelSpecifics = NotificationDetails(
      android: androidPlatformChannelSpecifics,
      iOS: iOSPlatformChannelSpecifics);
  await flip.show(
    notificationId,
    title,
    body,
    platformChannelSpecifics,
    payload: '',
  );
}

Future<void> openPage(RemoteMessage message, BuildContext context, int notificationId) async {
  bool login =await navKey.currentContext!.read<LocalRepository>().isLoggedIn();
  var notificationData = message.data;

  log('payload$notificationData :: $notificationId');
  //if(notificationData.isNotEmpty){
      if(login==true){
    Navigator.of(context).push(MaterialPageRoute(
        builder: (BuildContext context) => const NotificationScreen()));
  }
  // }
  //navigation route
}
