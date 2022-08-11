import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:thebibleapp/models/event.dart';
import 'package:thebibleapp/models/feedback.dart';
import 'package:thebibleapp/models/location.dart';
import 'package:thebibleapp/models/notification.dart';
import 'package:thebibleapp/models/prayer.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirestoreService {
  static Stream<List<Event>>? streamEvents() {
    var ref = FirebaseFirestore.instance.collection('events').snapshots();
    return ref.map((list) => list.docs.map((doc) => Event.fromJson({...doc.data(), "id": doc.id})).toList());
  }

  static Stream<List<Notification>>? streamNotifications() {
    var ref = FirebaseFirestore.instance.collection('notifications').snapshots();
    return ref.map((list) => list.docs.map((doc) => Notification.fromJson({...doc.data(), "id": doc.id})).toList());
  }

  static Stream<List<Location>>? streamLocations() {
    var ref = FirebaseFirestore.instance.collection('locations').snapshots();
    return ref.map((list) => list.docs.map((doc) => Location.fromJson({...doc.data(), "id": doc.id})).toList());
  }

  static Stream<List<Prayer>>? streamPrayers() {
    User? user = FirebaseAuth.instance.currentUser;
    if (user == null) return null;
    var ref = FirebaseFirestore.instance.collection('prayers').where('userId', isEqualTo: user.uid).snapshots();
    return ref.map((list) => list.docs.map((doc) => Prayer.fromJson({...doc.data(), "id": doc.id})).toList());
  }

  static Future<bool> addPrayer(Prayer prayer) async {
    User? user = FirebaseAuth.instance.currentUser;
    try {
      await FirebaseFirestore.instance
          .collection('prayers')
          .doc(prayer.id)
          .set({...prayer.toJson(), 'timestampCreated': FieldValue.serverTimestamp(), 'userId': user?.uid});
      return true;
    } catch (e) {
      return false;
    }
  }

  static Future<bool> addFeedback(Feedback feeback) async {
    User? user = FirebaseAuth.instance.currentUser;
    try {
      await FirebaseFirestore.instance
          .collection('feedbacks')
          .doc(feeback.id)
          .set({...feeback.toJson(), 'timestampCreated': FieldValue.serverTimestamp(), 'userId': user?.uid});
      return true;
    } catch (e) {
      return false;
    }
  }
}
