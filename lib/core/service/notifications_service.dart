import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import '../../ui/ui.dart';
import 'local_data_manager.dart';

Future setupNotification() async {
  try {
    await Firebase.initializeApp(
        // options: DefaultFirebaseOptions.currentPlatform,
        );

    FlutterError.onError = (errorDetails) {
      FirebaseCrashlytics.instance.recordFlutterFatalError(errorDetails);
    };
    PlatformDispatcher.instance.onError = (error, stack) {
      FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
      return true;
    };

    await dataManager.setFCMToken(await FirebaseMessaging.instance.getToken());
  } finally {
    await FirebaseMessaging.instance.requestPermission();
    FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );
    FirebaseMessaging.onMessage.listen((RemoteMessage event) {
      UIHelper.showGlobalSnackBar(
        text: event.notification?.body,
        title: event.notification?.title,
        onTap: (j) {},
      );
    });
  }
}
