// File generated by FlutterFire CLI.
// ignore_for_file: type=lint
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
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for ios - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.macOS:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for macos - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
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
    apiKey: 'AIzaSyAOP6rS8IXl-G1JhGmStQ_s0paEvKKmB7k',
    appId: '1:288314247010:web:9c1ac5910d5695e15dce3b',
    messagingSenderId: '288314247010',
    projectId: 'ecom-admin-94a67',
    authDomain: 'ecom-admin-94a67.firebaseapp.com',
    storageBucket: 'ecom-admin-94a67.appspot.com',
    measurementId: 'G-FDK4F6R3PN',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBV9fVwAJQES60zU5nJVTdm9Toh3qCw0Wc',
    appId: '1:288314247010:android:9d4ff205dccd0d4d5dce3b',
    messagingSenderId: '288314247010',
    projectId: 'ecom-admin-94a67',
    storageBucket: 'ecom-admin-94a67.appspot.com',
  );
}
