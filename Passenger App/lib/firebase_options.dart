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
    apiKey: 'AIzaSyBfflLKxAy1Xq6QQJ-E7s-FTlC8UvBbqIw',
    appId: '1:274313832049:web:96876166aab78493cb5dd0',
    messagingSenderId: '274313832049',
    projectId: 'mobileprogramming-carpool',
    authDomain: 'mobileprogramming-carpool.firebaseapp.com',
    storageBucket: 'mobileprogramming-carpool.appspot.com',
    measurementId: 'G-X685D0515L',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCChoo-yL72HJMv9VAJbDkJ7mjeTpbDSdE',
    appId: '1:274313832049:android:e758d7366f7fb65ccb5dd0',
    messagingSenderId: '274313832049',
    projectId: 'mobileprogramming-carpool',
    storageBucket: 'mobileprogramming-carpool.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCmdIgyjw2rg-nb5FDB8sYajx7nZiJcvGk',
    appId: '1:274313832049:ios:7c6c7a0267465fa0cb5dd0',
    messagingSenderId: '274313832049',
    projectId: 'mobileprogramming-carpool',
    storageBucket: 'mobileprogramming-carpool.appspot.com',
    iosBundleId: 'com.example.project',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyCmdIgyjw2rg-nb5FDB8sYajx7nZiJcvGk',
    appId: '1:274313832049:ios:5197cea52d711264cb5dd0',
    messagingSenderId: '274313832049',
    projectId: 'mobileprogramming-carpool',
    storageBucket: 'mobileprogramming-carpool.appspot.com',
    iosBundleId: 'com.example.project.RunnerTests',
  );
}