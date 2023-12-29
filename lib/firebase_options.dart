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
    apiKey: 'AIzaSyDThM3Ek1_2CHLqW4V1kCluDux7d4SxD7s',
    appId: '1:224184482202:web:b6ea14a9f165c664d76223',
    messagingSenderId: '224184482202',
    projectId: 'hakim-c34eb',
    authDomain: 'hakim-c34eb.firebaseapp.com',
    storageBucket: 'hakim-c34eb.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAuO3m16dZ9dczPtmhHnzyWW-NH__YJVv0',
    appId: '1:224184482202:android:5a370ac368bf22fad76223',
    messagingSenderId: '224184482202',
    projectId: 'hakim-c34eb',
    storageBucket: 'hakim-c34eb.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCZcPi28s6Az3yoXbiI2aHn-zwt7I3ujYY',
    appId: '1:224184482202:ios:375fabcc24b68b9ed76223',
    messagingSenderId: '224184482202',
    projectId: 'hakim-c34eb',
    storageBucket: 'hakim-c34eb.appspot.com',
    iosBundleId: 'com.example.hakim',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyCZcPi28s6Az3yoXbiI2aHn-zwt7I3ujYY',
    appId: '1:224184482202:ios:0c40f86d5efdad7cd76223',
    messagingSenderId: '224184482202',
    projectId: 'hakim-c34eb',
    storageBucket: 'hakim-c34eb.appspot.com',
    iosBundleId: 'com.example.hakim.RunnerTests',
  );
}