import 'dart:async';

import 'package:flutter/material.dart' hide Notification;
import 'package:thebibleapp/models/event.dart';
import 'package:thebibleapp/models/location.dart';
import 'package:thebibleapp/models/notification.dart';
import 'package:thebibleapp/models_services/firestore_service.dart';

import 'auth_provider.dart';

class AppProvider with ChangeNotifier {
  /* ----------------------------- NOTE NAVIGATION ---------------------------- */
  int _selectedPageIndex = 0;
  int get selectedPageIndex => _selectedPageIndex;

  set setSelectedPageIndex(int index) {
    _selectedPageIndex = index;
    notifyListeners();
  }

/* -------------------------------- NOTE INIT ------------------------------- */
  bool _isInitializedAuthProvider = false;
  AuthProvider? _authProvider;
  AuthProvider? get authProvider => _authProvider;

  set authProvider(AuthProvider? authProvider) {
    _authProvider = authProvider;

    print(authProvider?.user);

    if (authProvider?.user != null && !_isInitializedAuthProvider) {
      print('AppProvider: authProvider set');
      streamEvents();
      streamLocations();
      streamNotifications();
      notifyListeners();
      _isInitializedAuthProvider = true;
    }

    if (authProvider?.user == null) {
      _streamSubscriptionLocations?.cancel();
      _streamSubscriptionEvents?.cancel();
      _streamSubscriptionNotifications?.cancel();
      _isInitializedAuthProvider = false;
    }
  }

/* ------------------------------- NOTE EVENTS ------------------------------ */
  StreamSubscription<List<Event>>? _streamSubscriptionEvents;
  List<Event> _events = [];
  List<Event> get events => _events;

  void streamEvents() {
    var res = FirestoreService.streamEvents();
    _streamSubscriptionEvents = res?.listen((snapshot) {
      _events = snapshot;
      notifyListeners();
    });
  }

  /* --------------------------- NOTE NOTIFICATIONS --------------------------- */
  StreamSubscription<List<Notification>>? _streamSubscriptionNotifications;
  List<Notification> _notifications = [];
  List<Notification> get notifications => _notifications;

  void streamNotifications() {
    var res = FirestoreService.streamNotifications();
    _streamSubscriptionNotifications?.cancel();
    _streamSubscriptionNotifications = res?.listen((snapshot) {
      _notifications = snapshot;
      print('notifications: ${_notifications.length}');
      notifyListeners();
    });
  }

  /* ----------------------------- NOTE LOCATIONS ----------------------------- */
  StreamSubscription<List<Location>>? _streamSubscriptionLocations;
  List<Location> _locations = [];
  List<Location> get locations => _locations;

  void streamLocations() {
    var res = FirestoreService.streamLocations();
    _streamSubscriptionLocations?.cancel();
    _streamSubscriptionLocations = res?.listen((snapshot) {
      _locations = snapshot;
      notifyListeners();
    });
  }
}
