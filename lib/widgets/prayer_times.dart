import '../models/schedule_model.dart';
import 'package:intl/intl.dart';

class PrayerTimes {
  static List<PrayerTime> getPrayerTimes() {
    final now = DateTime.now();
    final formatter = DateFormat('HH:mm');

    final prayerTimes = [
      PrayerTime(
        title: 'أذان الفجر',
        content: 'حان الآن موعد أذان الفجر حسب توقيت القاهرة 5:15' ,
        time: DateTime(now.year, now.month, now.day, 5, 15),
        icon: 'assets/images/Fajr.png',
      ),
      PrayerTime(
        title: 'أذان الظهر',
        content: 'حان الآن موعد أذان الظهر حسب توقيت القاهرة 12:10',
        time: DateTime(now.year, now.month, now.day, 12, 45),
        icon: 'assets/images/Dhuhr.png',
      ),
      PrayerTime(
        title: 'أذان العصر',
        content: 'حان الآن موعد أذان العصر حسب توقيت القاهرة 3:10',
        time: DateTime(now.year, now.month, now.day, 15, 10),
        icon: 'assets/images/Asr.png',
      ),
      PrayerTime(
        title: 'أذان المغرب',
        content: 'حان الآن موعد أذان المغرب حسب توقيت القاهرة 5:37',
        time: DateTime(now.year, now.month, now.day, 17, 37),
        icon: 'assets/images/Maghrib.png',
      ),
      PrayerTime(
        title: 'أذان العشاء',
        content: 'حان الآن موعد أذان العشاء حسب توقيت القاهرة 6:56',
        time: DateTime(now.year, now.month, now.day, 18, 56),
        icon: 'assets/images/Isha.png',
      ),
    ];
    //getPrayerTimes();
    return prayerTimes;
  }

  static List<PrayerTime> getAzkarTimes() {
    final now = DateTime.now();
    final azkarTimes = [
      PrayerTime(
          title: 'أذكار الصباح',
          content: 'وقت قراءة الأذكار',
          time: DateTime(now.year, now.month, now.day, 7,0),
          icon: 'assets/images/rising-sun.png'),
      PrayerTime(
          title: 'أذكار المساء',
          content: 'وقت قراءة الأذكار',
          time: DateTime(now.year, now.month, now.day, 18,0),
          icon: 'assets/images/night.png'),
      PrayerTime(
          title: 'أذكار النوم',
          content: 'وقت قراءة الأذكار',
          time: DateTime(now.year, now.month, now.day, 22,0),
          icon: 'assets/images/night.png'),
    ];
    //getAzkarTimes();
    return azkarTimes;
  }
}
