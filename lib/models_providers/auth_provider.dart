import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:thebibleapp/models_services/auth_service.dart';

import '../_navbar_page.dart';

class AuthProvider with ChangeNotifier {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  User? _user;
  User? get user => _user;

  Future init() async {
    if (_user == null) _user = await AuthService.signInAnonymously();
    if (_user != null) {
      Get.offAll(() => NavbarPage());
      AuthService.updateAppVersionLastLogin();
    }

    print('AuthProvider init ${_user}');

    notifyListeners();
    return _user;
  }
}
