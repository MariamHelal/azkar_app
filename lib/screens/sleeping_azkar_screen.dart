import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../services/boxes.dart';

class SleepingAzkarPage extends StatefulWidget {
  SleepingAzkarPage({Key? key, required this.categoryName, required this.id}) : super(key: key);
  final String categoryName;
  final int id;
  var now=DateTime.now();
  @override
  State<SleepingAzkarPage> createState() => _SleepingAzkarPageState();
}

class _SleepingAzkarPageState extends State<SleepingAzkarPage> {

  late SharedPreferences prefs;
  late TimeOfDay _timeOfDay4=TimeOfDay(hour: 7, minute: 00);
  bool isSwitched4=false;
  @override
  void initState() {
    super.initState();
    initializePreferences();
  }
  Future<void> initializePreferences() async {
    prefs = await SharedPreferences.getInstance();
    setState(() {
      //for(int i=0;i<azkarScheduleList.length;i++){
      _timeOfDay4= getTimeFromPreferences() ?? TimeOfDay(hour: 7, minute: 00);
      isSwitched4 = prefs.getBool('Azkar switcher${widget.id}') ?? false;
      //}
    });

  }

  TimeOfDay? getTimeFromPreferences() {
    // for(int i=0;i<azkarScheduleList.length;i++) {
    final hour = prefs.getInt('notificationHour${widget.id}');
    final minute = prefs.getInt('notificationMinute${widget.id}');
    if (hour != null && minute != null) {
      return TimeOfDay(hour: hour, minute: minute);
    }
    return null;
    // }


  }


  // show time picker method
  void _showTimePicker() async {

    final selectedTime= await showTimePicker(
      context: context,
      initialTime: _timeOfDay4,
    );

    if (selectedTime != null) {
      setState(() {
        _timeOfDay4= selectedTime;
      });

      saveTimeToPreferences();
    }
    if(isSwitched4){
      setState(() {
        cancleAzkarNotifications();
        scheduleNotification();
      });
    }

  }
  String getTimeDisplayString() {
    return _timeOfDay4.format(context).toString();
  }
  void saveAzkarSwitcherToSharedPreferences()  {
    // await prefs.setBool('Azan switcher', isAzanSwitched);

    prefs.setBool('Azkar switcher${widget.id}', isSwitched4);



  }
  Future<void> saveTimeToPreferences() async{
    //for (int i=0;i<azkarScheduleList.length;i++){

    prefs.setInt('notificationHour${widget.id}', _timeOfDay4.hour);
    prefs.setInt('notificationMinute${widget.id}', _timeOfDay4.minute);



    //}


  }

  Future<void> scheduleNotification() async {
    final now=DateTime.now();
    var selectedTime =DateTime(now.year,now.month,now.day,_timeOfDay4.hour,_timeOfDay4.minute);
    if(selectedTime.isBefore(now)){
      selectedTime.add(const Duration(days: 1));
    }

    final notificationContent=NotificationContent(
        id: widget.id,
        channelKey: 'azkar_schedule_app_channel',
        title: widget.categoryName,
        body: "موعد  ${widget.categoryName}",
        category:NotificationCategory.Social,
        notificationLayout: NotificationLayout.BigText,
        //locked: true,
        wakeUpScreen: true,
        autoDismissible: true,
        fullScreenIntent: true
    );
    final schedule=NotificationCalendar(
      minute: selectedTime.minute,
      hour: selectedTime.hour,
      day: selectedTime.day,
      weekday: selectedTime.weekday,
      year: selectedTime.year,
      month: selectedTime.month,
      second: 1,
      repeats: true, // Set the schedule to repeat daily
      // preciseAlarm: true,
      allowWhileIdle: true,
      timeZone: await AwesomeNotifications().getLocalTimeZoneIdentifier(),
    );

    await AwesomeNotifications().createNotification(
      content: notificationContent,
      schedule: schedule,

    );
  }

  Future<void> cancleAzkarNotifications() async{
    await AwesomeNotifications().cancelSchedule(widget.id);

  }
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/images/background 2.jpg'),
              fit: BoxFit.fill
          )
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          title: Text(
            widget.categoryName ,
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Icon(Icons.notifications_active),
            ),
            Switch.adaptive(
              //activeColor: Color(0xff4b4a26),
                value: isSwitched4,
                onChanged: (value) {
                  setState(() {
                    isSwitched4 = value;
                    if(isSwitched4){
                      scheduleNotification();
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Center(child: Text('تم تفعيل اشعارات ${widget.categoryName}'))));
                      print('${widget.categoryName} notifications is on');
                    }else{
                      cancleAzkarNotifications();
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Center(child: Text('تم الغاء تفعيل اشعارات ${widget.categoryName}'))));
                      print('${widget.categoryName} notifications of');
                    }
                  });
                  saveAzkarSwitcherToSharedPreferences();
                }),


          ],
        ),
        body: Column(
          children: [
            Container(
              // padding: EdgeInsets.all(16),
              margin: EdgeInsets.symmetric(horizontal: 25,vertical: 5),
              decoration:  BoxDecoration(
                //  color: Colors.black26,
                  borderRadius: BorderRadius.circular(20)
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: (){
                      _showTimePicker();
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      margin: EdgeInsets.symmetric(horizontal: 16),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.black26
                      ),
                      child: Padding(
                        padding: EdgeInsets.all(10.0),
                        child: Row(
                          children: [
                            Text( getTimeDisplayString(),
                                style: TextStyle( fontSize: 16)),
                            Icon(Icons.arrow_drop_down_outlined),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(10.0),
                    child: Text( 'وقت الاشعار',
                        style: TextStyle( fontSize: 20,fontWeight: FontWeight.bold)),
                  ),

                ],
              ),

            ),
            Divider(
              indent: 25,
              endIndent: 25,
              height: .5,
              color: Color(0xff87854f),
            ),

            Expanded(
              child: ListView.builder(
                  itemCount: boxAzkar.get( widget.categoryName ).length,
                  itemBuilder: (context,index){
                    return Column(
                      children: [
                        Container(
                          alignment: AlignmentDirectional.centerEnd,
                          padding: EdgeInsets.all(16),
                          margin: EdgeInsets.symmetric(horizontal: 25,vertical: 5),
                          decoration: BoxDecoration(
                            color: Color(0xff9b9961) ,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Align(
                            alignment: Alignment.centerRight,
                            child: Text(
                              boxAzkar.get( widget.categoryName ) [index],
                              textAlign: TextAlign.right,style: TextStyle(
                              fontSize: 15,
                            ),
                            ),
                          ),
                        ),
                        Divider(
                          indent: 30,
                          endIndent: 30,
                          height: .5,
                          color: Color(0xff87854f),
                        )
                      ],
                    );
                  }
              ),
            ),
          ],
        ),
      ),
    );
  }
}
