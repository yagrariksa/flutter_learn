import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_learn/helper/notification_helper.dart';
import 'package:flutter_learn/navigation.dart';
import 'package:flutter_learn/screen/alarm_receive.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart'
    as notifs;

Future<void> main() async {
  String initRoute = AlaramReceivePage.routeName;
  final notifs.NotificationAppLaunchDetails? notificationAppLaunchDetails =
      !kIsWeb && Platform.isLinux
          ? null
          : await flutterLocalNotificationsPlugin
              .getNotificationAppLaunchDetails();
  if (notificationAppLaunchDetails?.didNotificationLaunchApp ?? false) {
    initRoute = AlaramReceivePage.routeName;
    selectedNotificationPayload =
        notificationAppLaunchDetails!.notificationResponse?.payload;
  }

  runApp(MyApp(
    initRoute: initRoute,
  ));
}

final notifs.FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    notifs.FlutterLocalNotificationsPlugin();

String? selectedNotificationPayload;

class MyApp extends StatelessWidget {
  MyApp({Key? key, required this.initRoute}) : super(key: key);

  String initRoute = AlaramReceivePage.routeName;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: initRoute,
      routes: <String, WidgetBuilder>{
        HomePage.routeName: (context) => HomePage(),
        AlaramReceivePage.routeName: (context) =>
            AlaramReceivePage(selectedNotificationPayload),
      },
    );
  }
}
