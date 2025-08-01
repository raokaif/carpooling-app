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
    apiKey: 'AIzaSyB9nP2llmP7sj7NKrBSujKVGfX2ef2wf40',
    appId: '1:216810061782:web:ac6fcd99aa0aec9fe0ee77',
    messagingSenderId: '216810061782',
    projectId: 'carpooling-app-8a52b',
    authDomain: 'carpooling-app-8a52b.firebaseapp.com',
    storageBucket: 'carpooling-app-8a52b.firebasestorage.app',
    measurementId: 'G-NX7MXMG5VF',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDE3BNQFgztSupv1NpHuE9kWRnuZ1nvWts',
    appId: '1:216810061782:android:0f592cffe0bf81dee0ee77',
    messagingSenderId: '216810061782',
    projectId: 'carpooling-app-8a52b',
    storageBucket: 'carpooling-app-8a52b.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBByOLP-c169uAlZI6f8YqxJJzZwi2OBUQ',
    appId: '1:216810061782:ios:0792f6745d09078ee0ee77',
    messagingSenderId: '216810061782',
    projectId: 'carpooling-app-8a52b',
    storageBucket: 'carpooling-app-8a52b.firebasestorage.app',
    iosBundleId: 'com.example.carpoolingApp',
  );
}
