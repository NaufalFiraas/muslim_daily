import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:muslim_daily/data/models/sholat_reminder_model.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:rxdart/rxdart.dart';

class SholatReminderRepositories {
  late final FlutterLocalNotificationsPlugin notification;

  SholatReminderRepositories(
      [FlutterLocalNotificationsPlugin? optionalNotification]) {
    notification = optionalNotification ?? FlutterLocalNotificationsPlugin();
  }

  BehaviorSubject onNotification = BehaviorSubject<String?>();

  Future<void> init() async {
    AndroidInitializationSettings androidSetting =
        const AndroidInitializationSettings('@mipmap/ic_launcher');
    IOSInitializationSettings iOSSetting = const IOSInitializationSettings();

    InitializationSettings settings = InitializationSettings(
      android: androidSetting,
      iOS: iOSSetting,
    );

    await notification.initialize(settings, onSelectNotification: (payload) {
      onNotification.add(payload);
    });
  }

  NotificationDetails notificationDetails() {
    return const NotificationDetails(
      android: AndroidNotificationDetails(
        'channel id',
        'channel name',
        importance: Importance.max,
      ),
      iOS: IOSNotificationDetails(),
    );
  }

  Future<void> showScheduledNotification(
      SholatReminderModel reminderModel) async {
    notification.zonedSchedule(
      reminderModel.id,
      reminderModel.title,
      reminderModel.body,
      _scheduleDaily(Time(reminderModel.hour, reminderModel.minute)),
      notificationDetails(),
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
      androidAllowWhileIdle: true,
      matchDateTimeComponents: DateTimeComponents.time,
      payload: reminderModel.payload,
    );
  }

  tz.TZDateTime _scheduleDaily(Time time) {
    final tz.Location location = tz.getLocation('Asia/Jakarta');
    final tz.TZDateTime now = tz.TZDateTime.now(location);
    final tz.TZDateTime schedule = tz.TZDateTime(
      location,
      now.year,
      now.month,
      now.day,
      time.hour,
      time.minute,
    );

    return schedule.isBefore(now)
        ? schedule.add(const Duration(days: 1))
        : schedule;
  }

  Future<void> cancelNotification(int id) async {
    notification.cancel(id);
  }
}
