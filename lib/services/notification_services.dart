import 'dart:math';

import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:azkar_muslims_app/models/schedule_model.dart';
import 'package:azkar_muslims_app/widgets/prayer_times.dart';

class NotificationServices {
  static Future<void> initializeNotification() async {
    await AwesomeNotifications().initialize(
        null, [
      NotificationChannel(
        channelKey: 'azan_schedule_app_channel',
        channelName: 'Azan Schedule App Channel',
        channelDescription:
            'this channel is responsible for showing azan schedule app notification',
        importance: NotificationImportance.Max,
        defaultPrivacy: NotificationPrivacy.Public,
        defaultRingtoneType: DefaultRingtoneType.Notification,
       // soundSource: 'assets/sounds/آذان الشيخ سيد النقشبندى(MP3_320K).mp3',
        locked: true,
        enableVibration: true,
        playSound: true,
      ),
      NotificationChannel(
        channelKey: 'azkar_schedule_app_channel',
        channelName: 'Azkar Schedule App Channel',
        channelDescription:
        'this channel is responsible for showing azkar schedule app notification',
        importance: NotificationImportance.Max,
        defaultPrivacy: NotificationPrivacy.Public,
        defaultRingtoneType: DefaultRingtoneType.Notification,
        //locked: true,
        enableVibration: true,
        playSound: true,
        // soundSource: 'assets/sounds/آذان الشيخ سيد النقشبندى(MP3_320K).mp3'
      )
    ]);
  }
  static Future<void> schedulePrayerNotifications()async {
    final prayerTimes=PrayerTimes.getPrayerTimes();

    for(final prayerTime in prayerTimes){

      await scheduleNotification(prayerTime: prayerTime);
    }
  }
  static Future<void> canclePrayerNotifications() async{
    await AwesomeNotifications().cancelAll();

}
  static Future<void> scheduleNotification({
  required PrayerTime prayerTime
}) async {
    final notificationContent=NotificationContent(
        id: Random().nextInt(10000000),
        channelKey: 'azan_schedule_app_channel',
        title: prayerTime.title,
        body: prayerTime.content,
        category:NotificationCategory.Message,
        notificationLayout: NotificationLayout.BigText,
        locked: true,
        wakeUpScreen: true,
        autoDismissible: true,
        fullScreenIntent: true
    );
    final schedule=NotificationCalendar(
      minute: prayerTime.time.minute,
      hour: prayerTime.time.hour,
      day: prayerTime.time.day,
      weekday: prayerTime.time.weekday,
      year: prayerTime.time.year,
      month: prayerTime.time.month,
      second: 2,
      repeats: true,
      preciseAlarm: true,
      allowWhileIdle: true,
      timeZone: await AwesomeNotifications().getLocalTimeZoneIdentifier(),
    );

    await AwesomeNotifications().createNotification(
        content: notificationContent,
      schedule: schedule,

    );
  }
}
