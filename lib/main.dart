import 'dart:convert';
import 'dart:io' show Platform;
import 'package:device_info_plus/device_info_plus.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart' as path_provider;
import 'package:provider/provider.dart';
import 'package:thebibleapp/_constants.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:thebibleapp/push_notificatoin_system.dart';

import 'models_providers/ads_provider.dart';
import 'models_providers/app_provider.dart';
import 'models_providers/auth_provider.dart';
import 'models_providers/theme_provider.dart';
import 'models_providers/bible_provider.dart';
import 'models_services/notification_service.dart';
import 'pages/app/splash_screen_page.dart';
import 'package:http/http.dart' as http;
import 'global.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  NotificationService.init();

  final appDocumentDirectory =
      await path_provider.getApplicationDocumentsDirectory();
  Hive.init(appDocumentDirectory.path);

  ThemeMode themeMode = await Themes.getThemeModeHive();

  runApp(ChangeNotifierProvider(
      create: (_) => ThemeProvider(themeMode), child: MyApp()));
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with WidgetsBindingObserver {
  Geolocator geolocator = Geolocator();

  LocationPermission? _locationPermission;

  String? identifier;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.renderView.automaticSystemUiAdjustment = false;
    WidgetsBinding.instance.addObserver(this);

    //permission check
    checkIfPermissionLocationAllowed();

    //Push notification for the user location
    PushNotificationSystem pushNotificationSystem = PushNotificationSystem();
    pushNotificationSystem.initializeCloudMessaging(context);
    pushNotificationSystem.generateAndGetToken();

    //get the device info
    getUserDeviceInfo();

    //location
    getUserLocationUpdatesAtRealTime();
  }

  getUserDeviceInfo() async {
    final DeviceInfoPlugin deviceInfoPlugin = new DeviceInfoPlugin();

    try {
      if (Platform.isAndroid) {
        var build = await deviceInfoPlugin.androidInfo;
        identifier = build.id.toString();
      } else if (Platform.isIOS) {
        var data = await deviceInfoPlugin.iosInfo;
        identifier = data.identifierForVendor; //UUID for iOS
      }
    } on PlatformException {
      print('Failed to get platform version');
    }
  }

  currentUserPosition() async {
    Position currentPosition = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    print('currentPosition is : ${currentPosition}');
  }

  getUserLocationUpdatesAtRealTime() async {
    int nCnt = 0;
    //7920 W 25th Ave, Hialeah, FL 33016 : GPS coordinator
    LatLng _target = LatLng(25.8941314
    , -80.3343080);

    //Position _target = await Geolocator.getCurrentPosition(
    //desiredAccuracy: LocationAccuracy.high);

    Geolocator.getPositionStream().listen((Position position) {
      print('listener invoked +++ ${position} -- ${_target}');

      if ((position.latitude == _target.latitude) &&
          (position.longitude == _target.longitude)) {
        FirebaseDatabase.instance.ref().child("Test").set({
          'Lati': position.latitude,
          'Long': position.longitude,
          'deviceID': identifier
        });

        if (nCnt < 3) {
          Future.delayed(Duration(seconds: 5), () {
            sendNotificationToDriverNow(fcmKeyCode, context);
            Fluttertoast.showToast(msg: "Estas Aqui");
          });
          nCnt++;
        }
      }
    });
  }

  static sendNotificationToDriverNow(
      String? deviceRegistrationToken, contex) async {
    Map<String, String> headerNotification = {
      "Content-Type": "application/json",
      "Authorization": cloudMessagingserverToken,
    };
    Map bodyNotification = {
      "body": "Bienvenidos a Iglesia De Dios Avivamiento",
      "title": "Avivamiento"
    };
    Map dataMap = {
      "click_action": "FLUTTER_NOTIFICATION_CLICK",
      "id": "1",
      "status": "done"
    };
    Map officialNotificationFormat = {
      "notification": bodyNotification,
      "data": dataMap,
      "priority": "high",
      "to": deviceRegistrationToken,
    };

    print("deviceRegistrationToken is: ${deviceRegistrationToken}");
    var responsiveNotification = http
        .post(
      Uri.parse("https://fcm.googleapis.com/fcm/send"),
      headers: headerNotification,
      body: jsonEncode(officialNotificationFormat),
    )
        .catchError((err) {
      print('fcm send error: ${err}');
    }).then((msg) => print('fcm send success: ${msg}'));
  }

  checkIfPermissionLocationAllowed() async {
    _locationPermission = await Geolocator.requestPermission();

    if (_locationPermission == LocationPermission.denied) {
      _locationPermission = await Geolocator.requestPermission();
    }
  }

  @override
  void didChangeDependencies() {
    Themes.setStatusNavigationBarColor();
    super.didChangeDependencies();
  }

  @override
  void didChangePlatformBrightness() {
    Themes.setStatusNavigationBarColor();
    super.didChangePlatformBrightness();
  }

  @override
  didChangeAppLifecycleState(AppLifecycleState state) {
    Themes.setStatusNavigationBarColor();

    super.didChangeAppLifecycleState(state);
  }

  @override
  dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => BibleProvider()),
        ChangeNotifierProvider(create: (context) => AdsProvider()),
        ChangeNotifierProvider(create: (context) => AuthProvider()),
        ChangeNotifierProxyProvider<AuthProvider, AppProvider>(
            create: (context) => AppProvider(),
            update: (_, authProvider, prev) =>
                prev!..authProvider = authProvider),
      ],
      child: GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: appName,
        theme: Themes.light(),
        darkTheme: Themes.dark(),
        themeMode: themeProvider.themeMode,
        home: SplashScreenPage(),
      ),
    );
  }
}
