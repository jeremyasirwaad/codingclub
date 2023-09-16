import 'package:codingclub/Components/HiddenDrawer.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import './firebase_analytics.dart';
import 'package:upgrader/upgrader.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
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
  FirebaseMessaging.instance.getInitialMessage().then((value) {
    if (value != null) {
      _handleMessage(value);
    }
  });

  FirebaseMessaging.onMessageOpenedApp.listen(_handleMessage);
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  runApp(const MyApp());
}

void _handleMessage(RemoteMessage message) {
  print("Entered Through Notification");
  print(message.data);
  print(message.data['page']);
  navigatorKey.currentState?.pushNamed(message.data['page']);
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

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
        '/': (context) => UpgradeAlert(
              upgrader: Upgrader(
                  shouldPopScope: () => true,
                  durationUntilAlertAgain: const Duration(days: 2),
                  canDismissDialog: true),
              child: const HiddenDrawer(
                page: 0,
              ),
            ),
        '/news': (context) => const HiddenDrawer(
              page: 1,
            ),
        '/job': (context) => const HiddenDrawer(
              page: 2,
            ),
        '/annual': (context) => const HiddenDrawer(
              page: 3,
            ),
        '/quiz': (context) => const HiddenDrawer(
              page: 4,
            ),
        '/join': (context) => const HiddenDrawer(
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
