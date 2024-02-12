import 'package:azkar_muslims_app/models/tasbeh_model.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SebhaPage extends StatefulWidget {
  const SebhaPage({Key? key}) : super(key: key);

  @override
  State<SebhaPage> createState() => _SebhaPageState();
}

class _SebhaPageState extends State<SebhaPage> {
  late SharedPreferences prefs;
  int totalCounter = 0;

  List<TasbehModel> tasbehList = [
    TasbehModel(title: 'سبحان الله', count: 0),
    TasbehModel(title: 'الحمد لله', count: 0),
    TasbehModel(title: 'لا اله الا الله', count: 0),
    TasbehModel(title: 'الله أكبر', count: 0),
    TasbehModel(title: 'لا حول ولا قوة الا بالله', count: 0),
    TasbehModel(title: 'استغفر الله العظيم', count: 0),

  ];

  @override
  void initState() {
    super.initState();
    initializeSharedPreferences();
  }

  Future<void> initializeSharedPreferences() async {
    prefs = await SharedPreferences.getInstance();

    setState(() {
      for(int i=0;i<tasbehList.length;i++){
        tasbehList[i].count=prefs.getInt('counter$i')??0;
      }
      totalCounter = prefs.getInt('counter') ?? 0;
    });
  }

  Future<void> saveToltalCounterToSharedPreferences() async {

    await prefs.setInt('counter', totalCounter);
  }
  Future<void> saveListCounterToSharedPreferences()async{
    for(int i=0;i<tasbehList.length;i++){
      await prefs.setInt('counter$i', tasbehList[i].count);
    }
  }


  void resetCounter() {
    setState(() {
      for(int i=0;i<tasbehList.length;i++){
        tasbehList[i].count=0;
      }
      totalCounter = 0;
    });
    saveToltalCounterToSharedPreferences();
    saveListCounterToSharedPreferences();
  }

  void incrementCounter() {
    setState(() {
      totalCounter++;
    });
    saveToltalCounterToSharedPreferences();
  }



  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/background 2.jpg'),
          fit: BoxFit.fill,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          title: const Text('السبحة'),
          actions: [
            IconButton(
              onPressed: resetCounter,
              icon: Icon(Icons.refresh),
            )
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                flex: 1,
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 50.0),
                    child: Text(
                      '$totalCounter',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 70,
                          color: Color(0xff87854f)),
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: GridView.builder(
                  itemCount: tasbehList.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 1 / .45,
                  ),
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: (){
                        setState(() {
                          tasbehList[index].count ++;
                        });
                        saveListCounterToSharedPreferences();
                        incrementCounter();
                      },
                      child: Container(
                        margin: EdgeInsets.all(4),
                        padding: EdgeInsets.all(16),
                        decoration: BoxDecoration(
                            color: Colors.black26,
                            borderRadius: BorderRadius.circular(16)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text(
                              '${tasbehList[index].count}',
                              textAlign: TextAlign.center,
                              style: TextStyle(fontSize: 15, color: Colors.brown,fontWeight: FontWeight.bold),
                            ),
                            Text(
                              tasbehList[index].title,
                              textAlign: TextAlign.center,
                              style: TextStyle(fontSize: 14, color: Colors.black,fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}