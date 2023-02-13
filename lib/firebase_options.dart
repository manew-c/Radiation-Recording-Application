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
    apiKey: 'AIzaSyCgxDPTKEf9UduxFMKOV6l4s7sN4gyMKPM',
    appId: '1:676988341737:web:20af1bee67790d0e3c8f78',
    messagingSenderId: '676988341737',
    projectId: 'nuclear-app-cf4ef',
    authDomain: 'nuclear-app-cf4ef.firebaseapp.com',
    storageBucket: 'nuclear-app-cf4ef.appspot.com',
    measurementId: 'G-ZTDN3DYX2F',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyC9diviuWHe5pNI1FY98UxCv_XswgpBRUg',
    appId: '1:676988341737:android:faa827dded45af5e3c8f78',
    messagingSenderId: '676988341737',
    projectId: 'nuclear-app-cf4ef',
    storageBucket: 'nuclear-app-cf4ef.appspot.com',
  );
}
