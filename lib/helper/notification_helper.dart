import 'dart:js';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_learn/model/notifiaction.dart';
import 'package:rxdart/subjects.dart' as rxSub;
import 'package:flutter_local_notifications/flutter_local_notifications.dart'
    as notifs;
import 'package:rxdart/subjects.dart';

final rxSub.BehaviorSubject<NotificationClass> didRecieveLocalNotification =
    rxSub.BehaviorSubject<NotificationClass>();
final rxSub.BehaviorSubject<String> selectNotificationSubject =
    rxSub.BehaviorSubject<String>();

Future<void> initNotification(
  notifs.FlutterLocalNotificationsPlugin notifsPlugin,
) async {
  var initializationSettingsAndroid =
      notifs.AndroidInitializationSettings('icon');
  var initializationSettingsIOS = notifs.DarwinInitializationSettings(
    requestAlertPermission: false,
    requestBadgePermission: false,
    requestSoundPermission: false,
    onDidReceiveLocalNotification: (id, title, body, payload) {
      if (title != null && body != null && payload != null) {
        didRecieveLocalNotification.add(
          NotificationClass(
            id: id,
            title: title,
            body: body,
            payload: payload,
          ),
        );
      }
    },
  );
  var initializationSettings = notifs.InitializationSettings(
    android: initializationSettingsAndroid,
    iOS: initializationSettingsIOS,
  );
  await notifsPlugin.initialize(initializationSettings,
      onDidReceiveNotificationResponse: (details) {
    print("Notif recieved");
    print(details);
    if (details.payload != null)
      selectNotificationSubject.add(details.payload!);
  }, onDidReceiveBackgroundNotificationResponse: notificationTapBackground);

  print("Notification already initialized");
}

@pragma('vm:entry-point')
void notificationTapBackground(
  notifs.NotificationResponse notificationResponse,
) {
  print('notification(${notificationResponse.id}) action tapped: '
      '${notificationResponse.actionId} with'
      ' payload: ${notificationResponse.payload}');
  if (notificationResponse.input?.isNotEmpty ?? false) {
    // ignore: avoid_print
    print(
        'notification action tapped with input: ${notificationResponse.input}');
  }
}
