import 'dart:math';
import 'package:azkar_muslims_app/screens/after_salah_azkar_screen.dart';
import 'package:azkar_muslims_app/screens/eating_azkar_screen.dart';
import 'package:azkar_muslims_app/screens/khrog_azkar_screen.dart';
import 'package:azkar_muslims_app/screens/evening_azkar_screen.dart';
import 'package:azkar_muslims_app/screens/morning_azkar_screen.dart';
import 'package:azkar_muslims_app/screens/sleeping_azkar_screen.dart';
import 'package:azkar_muslims_app/screens/travelling_azkar_screen.dart';
import 'package:azkar_muslims_app/screens/wakeup_azkar_screen.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'roqia_screen.dart';

class AzkarCategoryPage extends StatefulWidget {
  const AzkarCategoryPage({Key? key}) : super(key: key);

  @override
  State<AzkarCategoryPage> createState() => _AzkarCategoryPageState();
}


class _AzkarCategoryPageState extends State<AzkarCategoryPage> {
  late SharedPreferences prefs;
  bool isAzkarSwitched=false;

  @override
  void initState() {
    super.initState();
    isAzkarSwitched=true;
    initializeSharedPreferences();
  }
  Future<void> initializeSharedPreferences() async {
    prefs = await SharedPreferences.getInstance();
    setState(() {
      isAzkarSwitched = prefs.getBool('Azkar switcher') ?? false;

    });
  }

  Future<void> saveAzkarSwitcherToSharedPreferences() async {
    await prefs.setBool('Azkar switcher', isAzkarSwitched);

  }

  @override
  Widget build(BuildContext context) {
    initializeSharedPreferences();
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/background 2.jpg'),
          fit: BoxFit.fill
        )
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          title: const Text(
            'أذكار المسلم',
          ),
        ),
        body: ListView(
          children: [
            CategoryWidget(name: 'أذكار الصباح',icon: 'assets/images/rising-sun.png', pageName: MorningAzkarPage(categoryName: 'أذكار الصباح', id: 0,),),
            CategoryWidget(name: 'أذكار المساء',icon: 'assets/images/night.png', pageName: EveningAzkarPage(categoryName: 'أذكار المساء', id: 1,), ),
            CategoryWidget(name: 'أذكار الخروج',icon: 'assets/images/get-out.png', pageName: KhrogAzkarPage(categoryName: 'أذكار الخروج', id: 2,),),
            CategoryWidget(name: 'أذكار الاستيقاظ من النوم', icon: 'assets/images/get-up.png', pageName: WakeUpAzkarPage(categoryName: 'أذكار الاستيقاظ من النوم', id: 3,),),
            CategoryWidget(name: 'أذكار النوم', icon: 'assets/images/sleeping.png',pageName: SleepingAzkarPage(categoryName: 'أذكار النوم', id: 4,),),
            CategoryWidget(name: 'أذكار بعد الصلاة',icon: 'assets/images/praying (1).png',pageName: AfterSalahAzkarPage(categoryName: 'أذكار بعد الصلاة', id: 5,),),
            CategoryWidget(name: 'دعاء السفر', icon: 'assets/images/airplane.png',pageName: TravellingAzkarPage(categoryName: 'دعاء السفر', id: 6,),),
            CategoryWidget(name: 'أذكار الطعام', icon: 'assets/images/eat.png',pageName: EatingAzkarPage(categoryName: 'أذكار الطعام', id: 7,),),
            CategoryWidget(name: 'الرقية الشرعية', icon: 'assets/images/islamic.png',pageName: RoqiaPage(categoryName: 'الرقية الشرعية', id: 8,),),

          ],
        ),
      ),
    );
  }
}
//late int indexOfAzkar;
class CategoryWidget extends StatefulWidget {
   CategoryWidget({
    super.key, required this.name, required this.icon, required this.pageName,
  });
   final Widget pageName;
  final String name;
  final String icon;
 // final int id;

  @override
  State<CategoryWidget> createState() => _CategoryWidgetState();
}

class _CategoryWidgetState extends State<CategoryWidget> with TickerProviderStateMixin{


  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(builder: (context){
          return widget.pageName;
        }));

      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Colors.black26,
        ),
        margin: const EdgeInsets.symmetric(horizontal: 40,vertical: 5),
        width: double.infinity,
        height: MediaQuery.of(context).size.height * .1,
        child: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
              //  NotificationSwitch(),
                const Spacer(flex: 1,),
                Text(
                  widget.name.toString(),
                  style: const TextStyle(
                      fontFamily: 'Tajawal',
                      color: Colors.black,
                      fontWeight: FontWeight.bold
                  ),
                ),
                const SizedBox(width: 20,),
                const VerticalDivider(
                  indent: 15,
                  endIndent: 15,
                  color: Color(0xff87854f),
                  width: .5,
                ),
                const SizedBox(width: 20,),
                Image.asset(
                  widget.icon,
                  height: MediaQuery.of(context).size.height *.035,
                  alignment: Alignment.centerRight,
                ),
                const SizedBox(width: 20,),

              ],
            ),),
      ),
    );
  }
}
