import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'global.dart';

class PushNotificationSystem {
  FirebaseMessaging messaging = FirebaseMessaging.instance;

  Future initializeCloudMessaging(BuildContext context) async {
    //1. Terminated
    FirebaseMessaging.instance
        .getInitialMessage()
        .then((RemoteMessage? remoteMessage) {
      if (remoteMessage != null) {
        print('FirebaseMessaging Terminated ++++ : ${remoteMessage}');
      }
    });

    //2. Foreground
    FirebaseMessaging.onMessage.listen((RemoteMessage? remoteMessage) {
      print('FirebaseMessaging Foreground ++++ : ${remoteMessage}');
      // showDialog(
      //   context: context,
      //   builder: (BuildContext context) => AlertDialog(title: Text(remoteMessage.toString())),
      // );
    });

    //3. Background
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage? remoteMessage) {
      print('FirebaseMessaging Background ++++ : ${remoteMessage}');
    });
  }

  Future generateAndGetToken() async {
    fcmKeyCode = await messaging.getToken();

    print("FCM Registrition Token ${fcmKeyCode}");

    messaging.subscribeToTopic("churchApp").catchError((error){
      print('subscribe churchApp error++++: ${ error }');
    }).then( (msg) {
      print('subscribe churchApp success++++: ');
    });
  }

}
