import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:azkar_muslims_app/screens/home_screen.dart';
import 'package:azkar_muslims_app/screens/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

import 'services/boxes.dart';
import 'screens/azkar_category_screen.dart';
import 'services/azan_notification_services.dart';
import 'services/azkar_notification_service.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await AwesomeNotifications().isNotificationAllowed().then((isAllowed){
    if(!isAllowed){
      AwesomeNotifications().requestPermissionToSendNotifications();
    }
  });
  await AzanNotificationServices.initializeNotification();
  //await AzkarNotificationServices.initializeNotification();


  HiveService().hivestate();
  runApp(const AzkarApp());
}

class AzkarApp extends StatefulWidget {
  const AzkarApp({Key? key}) : super(key: key);

  @override
  State<AzkarApp> createState() => _AzkarAppState();
}

class _AzkarAppState extends State<AzkarApp> {


  bool hasPermission=false;
  Future getPermission()async{
    if(await Permission.location.serviceStatus.isEnabled){
      var status = await Permission.location.status;
      if(status.isGranted){
        hasPermission=true;
      }else{
        Permission.location.request().then((value) {
          setState(() {
            hasPermission=(value== PermissionStatus.granted);
          });
        });
      }
    }
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        appBarTheme: const AppBarTheme(
            elevation: 0,
            centerTitle: true,
            titleTextStyle: TextStyle(
              fontFamily: 'Tajawal',
              fontSize: 25,
              color: Color(0xff87854f),
              fontWeight: FontWeight.bold,
            )),
      ),
      home: FutureBuilder(
        builder:(context,snapshot){
          if(hasPermission){
            return AnimatedSplashScreen(
              backgroundColor: Color(0xffF2F1EC),
              splashIconSize: 200,
              splashTransition: SplashTransition.rotationTransition,
             // pageTransitionType: PageTransitionType.lefttoright,
              duration: 2000,
                animationDuration: Duration(seconds: 2),
                splash: 'assets/images/AppIcon.png',
              nextScreen: HomePage(),

            );
          }else{
            return Scaffold(
              backgroundColor:Colors.white,
            );
          }
        },
        future: getPermission(),
      ),
    );
  }
}
