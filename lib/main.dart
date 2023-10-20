import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:web_app/firebase_options.dart';
import 'package:web_app/service/network/customer_service.dart';
import 'package:web_app/ui/page/home/user/home_user.dart';
import 'package:web_app/ui/page/home/user/home_user_controller.dart';
// import 'package:hive/hive.dart';
// import 'package:hive_flutter/hive_flutter.dart';

import 'injection.dart';
import 'main_app.dart';
import 'ui/authorization.dart';

void main() {
  // await _initHive();
  initApp();
}

/// call. Be sure to annotate the handler with `@pragma('vm:entry-point')` above the function declaration.
@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await setupFlutterNotifications();
  showFlutterNotification(message);
  // If you're going to use other Firebase services in the background, such as Firestore,
  // make sure you call `initializeApp` before using other Firebase services.
  print('Handling a background message ${message.messageId}');
}

/// Create a [AndroidNotificationChannel] for heads up notifications
late AndroidNotificationChannel channel;

bool isFlutterLocalNotificationsInitialized = false;

Future<void> setupFlutterNotifications() async {
  if (isFlutterLocalNotificationsInitialized) {
    return;
  }
  channel = const AndroidNotificationChannel(
    'high_importance_channel', // id
    'High Importance Notifications', // title
    description:
        'This channel is used for important notifications.', // description
    importance: Importance.high,
  );

  flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  /// Create an Android Notification Channel.
  ///
  /// We use this channel in the `AndroidManifest.xml` file to override the
  /// default FCM channel to enable heads up notifications.
  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(channel);

  /// Update the iOS foreground notification presentation options to allow
  /// heads up notifications.
  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
    alert: true,
    badge: true,
    sound: true,
  );
  isFlutterLocalNotificationsInitialized = true;
}

void showFlutterNotification(RemoteMessage message) {
  RemoteNotification? notification = message.notification;
  AndroidNotification? android = message.notification?.android;
  if (notification != null && android != null && !kIsWeb) {
    flutterLocalNotificationsPlugin.show(
      notification.hashCode,
      notification.title,
      notification.body,
      NotificationDetails(
        android: AndroidNotificationDetails(
          channel.id,
          channel.name,
          channelDescription: channel.description,
          // TODO add a proper drawable resource to android, for now using
          //      one that already exists in example app.
          icon: 'launch_background',
        ),
      ),
    );
  }
}

/// Initialize the [FlutterLocalNotificationsPlugin] package.
late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

Future<void> initApp() async {
  // final WidgetsBinding widgetsBinding =
  WidgetsFlutterBinding.ensureInitialized();
  await Injection.instance.injection();
  if (!Platform.isWindows) {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    FirebaseMessaging.instance.subscribeToTopic("all");
  }

  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
  final customerService = CustomerService();
  final accId = 3;

  _firebaseMessaging.requestPermission();
  _firebaseMessaging.getToken().then((token) {
    print('Firebase Token: $token');
    if (token != null) {
      customerService.updateNotificationToken(accId, token);
    }
  });

  _firebaseMessaging.getInitialMessage().then((RemoteMessage? message) {
    if (message != null) {
      // Xử lý thông báo khi ứng dụng khởi chạy từ thông báo
      // handleNotification(message);
      final currentRoute = Get.currentRoute;
      print('currentRoute: ${currentRoute}');
      if (currentRoute == HomeUser.route) {
        Get.find<HomeUserController>().changeIndex();
      } else {
        Get.offNamed(HomeUser.route, arguments: 2);
      }
      print(
          'Message opened from terminated state: ${message.notification?.body}');
    }
  });

  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    // Xử lý thông báo khi ứng dụng đang chạy
    // handleNotification(message);
    Get.showSnackbar(GetSnackBar(
      snackPosition: SnackPosition.TOP,
      title: message.notification?.title,
      message: message.notification?.body,
      onTap: (snack) {
        final currentRoute = Get.currentRoute;
        print('currentRoute: ${currentRoute}');
        if (currentRoute == HomeUser.route) {
          Get.find<HomeUserController>().changeIndex();
        } else {
          Get.offNamed(HomeUser.route, arguments: 2);
        }
      },
    ));
  });

  FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
    final currentRoute = Get.currentRoute;
    print('currentRoute: ${currentRoute}');
    if (currentRoute == HomeUser.route) {
      Get.find<HomeUserController>().changeIndex();
    } else {
      Get.offNamed(HomeUser.route, arguments: 2);
    }
    print(
        'Message opened from terminated state: ${message.notification?.body}');
  });

  // FirebaseMessaging.instance.getToken().then(
  //       (value) => print("get token : $value"),
  //     );

  // await FirebaseMessaging.instance.setAutoInitEnabled(true);

  // FirebaseMessaging.instance.onTokenRefresh.listen((fcmToken) {
  //   // TODO: If necessary send token to application server.

  //   // Note: This callback is fired at each app startup and whenever a new
  //   // token is generated.
  // }).onError((err) {
  //   // Error getting token.
  // });

  // FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  int role = -1;
  if (Authorization.isLogged()) {
    role = Authorization.checkRole();
  }
  runApp(MainApp(
    role: role,
  ));
}

// void handleNotification(RemoteMessage message) {
//   final String? title = message.notification?.title;
//   final String? body = message.notification?.body;

//   // Xử lý thông báo tại đây
//   print('Received notification: $title - $body');
// }

// Future<void> checkStatusAndRoleLogin() async {
//   DataLocal dataLocal = DataLocal();
//   RxBool statusLogin = false.obs;
//   RxBool isRoleAdmin = false.obs;
//   final accountId = await dataLocal.getAccountId();
//   final role = await dataLocal.getRole();
//   if (accountId != '') {
//     statusLogin.value = true;
//     // -1 chua login
//     // 0 admin
//     // 1 user
//     if (role != null) {
//       if (role == 0) {
//         isRoleAdmin.value = true;
//       } else {
//         isRoleAdmin.value = false;
//       }
//     }
//   } else {
//     statusLogin.value = false;
//   }

//   final accId = await dataLocal.getAccountId() ?? '';
//   final role = await dataLocal.getRole() ?? -1;

//   if (accId.trim().isNotEmpty && role > -1) {
//     if (role == 0) {
//       Get.offNamed(HomeAdmin.route);
//     } else {
//       Get.offNamed(HomeUser.route);
//     }
//   }
// }

// Future<void> _initHive() async {
//   await Hive.initFlutter();
//   await Hive.openBox("login");
//   await Hive.openBox("accounts");
// }