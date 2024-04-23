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
        return ios;
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
    apiKey: 'AIzaSyBhLovX_D2m02egNnM1RB7agAHMgBKPbRQ',
    appId: '1:12778704235:web:1bc45d212023b438f0102e',
    messagingSenderId: '12778704235',
    projectId: 'edtech02-14e2c',
    authDomain: 'edtech02-14e2c.firebaseapp.com',
    storageBucket: 'edtech02-14e2c.appspot.com',
    measurementId: 'G-JFMTDE08H8',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCGML5RUr6zY0D_NS_kPvsLufaEKk-8520',
    appId: '1:12778704235:android:97657d9a4632c3b0f0102e',
    messagingSenderId: '12778704235',
    projectId: 'edtech02-14e2c',
    storageBucket: 'edtech02-14e2c.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAV6GnpfrxvGhA7DMM-CFw_-x0e6i_1ylI',
    appId: '1:12778704235:ios:59b21671e17a07b6f0102e',
    messagingSenderId: '12778704235',
    projectId: 'edtech02-14e2c',
    storageBucket: 'edtech02-14e2c.appspot.com',
    iosBundleId: 'com.sangvaleap.onlinecourse',
  );
}
