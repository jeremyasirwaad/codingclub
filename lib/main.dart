import 'package:codingclub/Components/HiddenDrawer.dart';
import 'package:codingclub/Pages/GctNews.dart';
import 'package:codingclub/Pages/JobOpportunities.dart';
import 'package:codingclub/Pages/JoinCodingClub.dart';
import 'package:codingclub/Pages/Quiz.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import './Pages/HomePage.dart';
import './Pages/SplashScreen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import './Pages/EventsDetails.dart';
import './firebase_analytics.dart';
import 'package:upgrader/upgrader.dart';

final GlobalKey<NavigatorState> navigatorKey = new GlobalKey<NavigatorState>();

@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // If you're going to use other Firebase services in the background, such as Firestore,
  // make sure you call `initializeApp` before using other Firebase services.
  await Firebase.initializeApp();

  print("Handling a background message: ${message.messageId}");
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await FirebaseMessaging.instance
      .subscribeToTopic("NOTE")
      .then((value) => print("done"));
  final fcmToken = await FirebaseMessaging.instance.getToken();
  print(fcmToken);
  RemoteMessage? initialMessage =
      await FirebaseMessaging.instance.getInitialMessage();
  if (initialMessage != null) {
    _handleMessage(initialMessage);
  }
  FirebaseMessaging.onMessageOpenedApp.listen(_handleMessage);
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  runApp(MyApp());
}

void _handleMessage(RemoteMessage message) {
  print("Entered Through Notification");
  print(message.data);
  print(message.data['page']);
  navigatorKey.currentState!.pushNamed(message.data['page']);
}

class MyApp extends StatelessWidget {
  // get generateRoute => null;

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return MaterialApp(
      title: "Coding Club",
      navigatorKey: navigatorKey,
      navigatorObservers: [Analytics.observer],
      // onGenerateRoute: generateRoute,
      routes: {
        '/': (context) => HiddenDrawer(
              page: 0,
            ),
        '/news': (context) => HiddenDrawer(
              page: 1,
            ),
        '/job': (context) => HiddenDrawer(
              page: 2,
            ),
        '/annual': (context) => HiddenDrawer(
              page: 3,
            ),
        '/quiz': (context) => HiddenDrawer(
              page: 4,
            ),
        '/join': (context) => HiddenDrawer(
              page: 5,
            ),
      },
      initialRoute: "/",
      // home: UpgradeAlert(
      //   child: const SplashScreen(),
      //   upgrader: Upgrader(
      //       shouldPopScope: () => true,
      //       durationUntilAlertAgain: const Duration(days: 2),
      //       canDismissDialog: true),
      // )
    );
  }
}
