import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import './Pages/HomePage.dart';
import './Pages/SplashScreen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import './Pages/EventsDetails.dart';
import 'package:flutter_downloader/flutter_downloader.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await FlutterDownloader.initialize(
      debug:
          true, // optional: set to false to disable printing logs to console (default: true)
      ignoreSsl:
          true // option: set to false to disable working with http links (default: false)
      );
  await FirebaseMessaging.instance
      .subscribeToTopic("NOTE")
      .then((value) => print("done"));
  final fcmToken = await FirebaseMessaging.instance.getToken();
  print(fcmToken);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return const MaterialApp(title: "Coding Club", home: SplashScreen());
  }
}
