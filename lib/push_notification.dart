import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
class PushNotificationManager{
  PushNotificationManager._();
  factory PushNotificationManager() => _instance;
  static final PushNotificationManager _instance = PushNotificationManager._();

  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
  bool _initialized= false;

  Future<void> init() async{
     if(!_initialized){
       String? token = await _firebaseMessaging.getToken();
        print("my new token = $token");
        _initialized=true;
     }
  }
}