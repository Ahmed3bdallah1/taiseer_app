import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:learning/ui/ui.dart';

import 'core/service/local_data_manager.dart';

Future setupNotification() async {
  try {
    await Firebase.initializeApp(
        // options: DefaultFirebaseOptions.currentPlatform,
        );
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
