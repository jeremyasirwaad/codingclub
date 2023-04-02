// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Example:
/// ```dart
/// import 'firebase_options.dart';
/// // ...
/// await Firebase.initializeApp(
///   options: DefaultFirebaseOptions.currentPlatform,
/// );
/// ```
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        return macos;
      case TargetPlatform.windows:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for windows - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyCMBDbf2jSAE5tQciRr8LfrqtkTXpYe8B0',
    appId: '1:605164108684:web:b6d294b0aa69f61505b4a9',
    messagingSenderId: '605164108684',
    projectId: 'laptopapp-c7917',
    authDomain: 'laptopapp-c7917.firebaseapp.com',
    storageBucket: 'laptopapp-c7917.appspot.com',
    measurementId: 'G-GMP36LJ1EW',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCw0i30_B-tePqGDG87tJUHjtYbbUQk7T4',
    appId: '1:605164108684:android:351fa947ed7a0bfe05b4a9',
    messagingSenderId: '605164108684',
    projectId: 'laptopapp-c7917',
    storageBucket: 'laptopapp-c7917.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBE0GQfd2t6z0UFgC2-AaKky7E98V2bk1Q',
    appId: '1:605164108684:ios:ef24553b4e18cf3d05b4a9',
    messagingSenderId: '605164108684',
    projectId: 'laptopapp-c7917',
    storageBucket: 'laptopapp-c7917.appspot.com',
    iosClientId: '605164108684-dosofh1fld94nnbp058fjdddhdn5164r.apps.googleusercontent.com',
    iosBundleId: 'com.example.codingclub',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyBE0GQfd2t6z0UFgC2-AaKky7E98V2bk1Q',
    appId: '1:605164108684:ios:ef24553b4e18cf3d05b4a9',
    messagingSenderId: '605164108684',
    projectId: 'laptopapp-c7917',
    storageBucket: 'laptopapp-c7917.appspot.com',
    iosClientId: '605164108684-dosofh1fld94nnbp058fjdddhdn5164r.apps.googleusercontent.com',
    iosBundleId: 'com.example.codingclub',
  );
}
