
import 'package:flutter/material.dart';

import 'home_screen.dart';
class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    _navigatetohome();
  }
  _navigatetohome() async{
    await Future.delayed(Duration(milliseconds: 5000),(){});
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context){
      return HomePage();
    }));
  }


  @override
  Widget build(BuildContext context) {

    return Scaffold(
     // body: ,


      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset('assets/images/AppIcon.png',width: MediaQuery.of(context).size.width *.33,),
          SizedBox(height: 20,),
          Text('splash Screen', style: TextStyle(
            fontSize: 24,
          ),),
        ],
      ),
    );
  }
}
