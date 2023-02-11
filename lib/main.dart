import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import './Pages/HomePage.dart';
import './Pages/SplashScreen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return MaterialApp(title: "Coding Club", home: SplashScreen());
  }
}
