import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/azan_model.dart';
import '../services/azan_notification_services.dart';

class AzanPage extends StatefulWidget {
  const AzanPage({Key? key}) : super(key: key);

  @override
  State<AzanPage> createState() => _AzanPageState();
}

class _AzanPageState extends State<AzanPage> {
  late SharedPreferences prefs;
  bool isAzanSwitched = false;
  var time = DateTime.now();

  List<AzanModel> timesOfAzan = [
    AzanModel(
        name: 'الفجر', hour: 5, minute: 17, image: 'assets/images/Fajr.png'),
    AzanModel(
        name: 'الشروق',
        hour: 6,
        minute: 46,
        image: 'assets/images/SunRise.png'),
    AzanModel(
        name: 'الظهر', hour: 12, minute: 10, image: 'assets/images/Dhuhr.png'),
    AzanModel(
        name: 'العصر', hour: 3, minute: 11, image: 'assets/images/Asr.png'),
    AzanModel(
        name: 'المغرب',
        hour: 5,
        minute: 33,
        image: 'assets/images/Maghrib.png'),
    AzanModel(
        name: 'العشاء', hour: 6, minute: 53, image: 'assets/images/Isha.png'),
  ];

  @override
  void initState() {
    super.initState();
    isAzanSwitched=true;
    initializeSharedPreferences();
  }

  Future<void> initializeSharedPreferences() async {
    prefs = await SharedPreferences.getInstance();
    setState(() {
      isAzanSwitched = prefs.getBool('Azan switcher') ?? false;
    });
  }

  Future<void> saveAzanSwitcherToSharedPreferences() async {
    await prefs.setBool('Azan switcher', isAzanSwitched);

  }
  @override
  Widget build(BuildContext context) {
    initializeSharedPreferences();
    return Container(
      decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/images/background 2.jpg'),
              fit: BoxFit.fill)),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          title: const Text(
            'مواعيد الصلاة',
          ),
          actions: [
            Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Icon(Icons.notifications_active),
          ),
            Switch.adaptive(
              //activeColor: Color(0xff4b4a26),
                value: isAzanSwitched,
                onChanged: (value) {
                  setState(() {
                    isAzanSwitched = value;
                    if(isAzanSwitched){
                      AzanNotificationServices.schedulePrayerNotifications();
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Center(child: Text('تم تفعيل اشعارات الآذان'))));
                    }else{
                      AzanNotificationServices.canclePrayerNotifications();
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Center(child: Text('تم الغاء تفعيل اشعارات الآذان'))));
                    }
                  });
                  saveAzanSwitcherToSharedPreferences();
                }),

          ],
        ),
        body: Column(
          children: [
            Spacer(flex: 1,),
            Center(child: Image.asset('assets/images/praying.png',width: MediaQuery.of(context).size.width *.33,)),
            SizedBox(height: 30,),
            Expanded(
              flex: 5,
              child: Container(
                margin: EdgeInsets.only(left: 20, right: 20, bottom: 70),
                decoration: BoxDecoration(
                    color: Colors.black12,
                    borderRadius: BorderRadius.circular(20)),
                //height: MediaQuery.of(context).size.height,
                child: ListView(
                  children: [
                    CustomAzanTimesWidget(
                      image: timesOfAzan[0].image,
                      name: timesOfAzan[0].name,
                      minute: timesOfAzan[0].minute,
                      hour: timesOfAzan[0].hour,
                    ),
                    Divider(
                      height: 0.5,
                      color: Color(0xff87854f),
                      indent: 10,
                      endIndent: 10,
                    ),
                    CustomAzanTimesWidget(
                      image: timesOfAzan[1].image,
                      name: timesOfAzan[1].name,
                      minute: timesOfAzan[1].minute,
                      hour: timesOfAzan[1].hour,
                    ),
                    Divider(
                      height: 0.5,
                      color: Color(0xff87854f),
                      indent: 10,
                      endIndent: 10,
                    ),
                    CustomAzanTimesWidget(
                      image: timesOfAzan[2].image,
                      name: timesOfAzan[2].name,
                      minute: timesOfAzan[2].minute,
                      hour: timesOfAzan[2].hour,
                    ),
                    Divider(
                      height: 0.5,
                      color: Color(0xff87854f),
                      indent: 10,
                      endIndent: 10,
                    ),
                    CustomAzanTimesWidget(
                      image: timesOfAzan[3].image,
                      name: timesOfAzan[3].name,
                      minute: timesOfAzan[3].minute,
                      hour: timesOfAzan[3].hour,
                    ),
                    Divider(
                      height: 0.5,
                      color: Color(0xff87854f),
                      indent: 10,
                      endIndent: 10,
                    ),
                    CustomAzanTimesWidget(
                      image: timesOfAzan[4].image,
                      name: timesOfAzan[4].name,
                      minute: timesOfAzan[4].minute,
                      hour: timesOfAzan[4].hour,
                    ),
                    Divider(
                      height: 0.5,
                      color: Color(0xff87854f),
                      indent: 10,
                      endIndent: 10,
                    ),
                    CustomAzanTimesWidget(
                      image: timesOfAzan[5].image,
                      name: timesOfAzan[5].name,
                      minute: timesOfAzan[5].minute,
                      hour: timesOfAzan[5].hour,
                    ),
                    Divider(
                      height: 0.5,
                      color: Color(0xff87854f),
                      indent: 10,
                      endIndent: 10,
                    ),


                  ],
                ),
              ),
            ),
            Spacer(flex: 1,)
          ],
        ),
      ),
    );
  }
}
class CustomAzanTimesWidget extends StatelessWidget {
  const CustomAzanTimesWidget({
    super.key,
    required this.image,
    required this.name,
    required this.minute,
    required this.hour,
  });
  final String image;
  final String name;
  final int minute;
  final int hour;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 8),
      child: Row(
        children: [
          Text(
            '$hour:$minute ',
            style: TextStyle(fontSize: 20, fontFamily: 'Tajawal'),
          ),
          Spacer(
            flex: 1,
          ),
          Text(
            name,
            style: TextStyle(fontSize: 20, fontFamily: 'Tajawal'),
          ),
          SizedBox(
            width: 25,
          ),
          Image.asset(
            image,
            height: MediaQuery.of(context).size.height * .05,
          ),
        ],
      ),
    );
  }
}