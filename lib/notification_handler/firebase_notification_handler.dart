/*
import 'dart:io';

import 'package:food_delivery/utils/baseClass.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:firebase_core/firebase_core.dart';

class FirebaseNotifications with BaseClass {
  FirebaseMessaging _firebaseMessaging;
  bool _isConfigured = false;
  Function nextScreen;
  BuildContext context;

  FirebaseMessaging setUpFirebase(Function next, BuildContext context) {
    _firebaseMessaging = FirebaseMessaging.instance;
    firebaseCloudMessaging_Listeners();
    nextScreen = next;
    this.context = context;
    return _firebaseMessaging;
  }

  void deleteFirebaseInstance() {
    _firebaseMessaging.deleteToken();
  }


  void overLayNotificationNew(String title, String body) async {
*/
/*    if (Platform.isAndroid) {
      showNotificationOverLay(
        title: title,
        subTitle: body,
      );
      try {
        if (await Vibration.hasVibrator()) {
          Vibration.vibrate();
        }
        if (await Vibration.hasAmplitudeControl()) {
          Vibration.vibrate(amplitude: 128);
        }
      } catch (error) {
        print(error);
      }
    } else {
      showNotificationOverLay(
        title: title,
        subTitle: body,
      );
      try {
        if (await Vibration.hasVibrator()) {
          Vibration.vibrate();
        }
        if (await Vibration.hasAmplitudeControl()) {
          Vibration.vibrate(amplitude: 128);
        }
      } catch (error) {
        print(error);
      }
    }*//*

  }

  Future<void> _firebaseMessagingBackgroundHandler(
      RemoteMessage message) async {
    // If you're going to use other Firebase services in the background, such as Firestore,
    // make sure you call `initializeApp` before using other Firebase services.
    await Firebase.initializeApp();
    print('Handling a background message ${message.messageId}');
  }

  void firebaseCloudMessaging_Listeners() {
    if (Platform.isIOS) iOS_Permission();
    _firebaseMessaging.getToken().then((token) {
      print(token);
    });
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print(message.notification.body);
      print(message.notification);

      print(message.notification.title);
      print(message.data.toString());
      overLayNotificationNew(
          message.notification.title, message.notification.body);
      RemoteNotification notification = message.notification;
      AndroidNotification android = message.notification?.android;

      if (notification != null && android != null) {}
    });
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print("HELLOOOOO OPENEDDDDDD");
      print('A new onMessageOpenedApp event was published!');
      nextScreen(message, "onLaunch");
    });
    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  }

*/
/*    FirebaseMessaging.onBackgroundMessage((RemoteMessage message) {
      RemoteNotification notification = message.notification;
      AndroidNotification android = message.notification?.android;
    });
  }*//*


  */
/*if (!_isConfigured) {
      _firebaseMessaging.configure(
        onMessage: (Map<String, dynamic> message) async {
          print('on message $message');

          //    _dropUi(message);
          overLayNotification(message);
          //   nextScreen(message, "onMessage");

          //     nextScreen();
        },
        onResume: (Map<String, dynamic> message) async {
          print('on resume $message');
          // print(message['notification']['body']);
          nextScreen(message, "onResume");
        },
        onLaunch: (Map<String, dynamic> message) async {
          print('on launch $message');
          //  print(message['notification']['body']);
          nextScreen(message, "onLaunch");
        },
      );
      _isConfigured = true;
    }*//*


  void iOS_Permission() async {
    NotificationSettings settings = await _firebaseMessaging.requestPermission(
        announcement: true,
        carPlay: true,
        criticalAlert: true,
        provisional: false,
        sound: true,
        badge: true,
        alert: true);

    */
/*   _firebaseMessaging.requestPermission(

        IosNotificationSettings(sound: true, badge: true, alert: true));
    _firebaseMessaging.onIosSettingsRegistered
        .listen((IosNotificationSettings settings) {
      print("Settings registered: $settings");
    });*//*

  }
}
*/
