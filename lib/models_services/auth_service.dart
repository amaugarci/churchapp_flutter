import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:package_info/package_info.dart';

class AuthService {
  static final FirebaseAuth _auth = FirebaseAuth.instance;
  static final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  static final FirebaseMessaging _firestoreMessaging = FirebaseMessaging.instance;

  static Future<User?> signInAnonymously() async {
    try {
      UserCredential authResult = await _auth.signInAnonymously();

      String? currentDevToken = await _firestoreMessaging.getToken();
      User? fbUser = FirebaseAuth.instance.currentUser;
      PackageInfo packageInfo = await PackageInfo.fromPlatform();
      String appVersion = packageInfo.version;
      num appBuildNumber = int.tryParse(packageInfo.buildNumber) ?? 0;

      if (fbUser != null) {
        await _firestore.collection('users').doc(fbUser.uid).set({
          'appBuildNumber': appBuildNumber,
          'appVersion': appVersion,
          'devTokens': FieldValue.arrayUnion([currentDevToken]),
          'timestampLastLogin': DateTime.now(),
        }, SetOptions(merge: true));
      }

      return authResult.user;
    } catch (e) {
      return null;
    }
  }

  static Future<void> updateNotificationStatus(bool status) async {
    User? user = FirebaseAuth.instance.currentUser;
    await _firestore.collection('users').doc(user!.uid).update({'isNotificationsEnabled': status});
  }

/* --------------------- NOTE Update Appversion Login & dev token --------------------- */
  static Future<void> updateAppVersionLastLogin() async {
    String? currentDevToken = await _firestoreMessaging.getToken();
    User? fbUser = FirebaseAuth.instance.currentUser;

    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    String appVersion = packageInfo.version;
    num appBuildNumber = int.tryParse(packageInfo.buildNumber) ?? 0;

    if (fbUser != null) {
      await _firestore.collection('users').doc(fbUser.uid).set({
        'appBuildNumber': appBuildNumber,
        'appVersion': appVersion,
        'devTokens': FieldValue.arrayUnion([currentDevToken]),
        'timestampLastLogin': DateTime.now(),
      }, SetOptions(merge: true));
    }
  }

  static Future<void> signOut() async {
    String? currentDevToken = await _firestoreMessaging.getToken();
    User? fbUser = FirebaseAuth.instance.currentUser;

    if (fbUser != null && currentDevToken != null) {
      await _firestore.collection('users').doc(fbUser.uid).update({
        'devTokens': FieldValue.arrayRemove([currentDevToken]),
        'timestampLogout': DateTime.now(),
      });
    }

    await FirebaseAuth.instance.signOut();
  }
}
