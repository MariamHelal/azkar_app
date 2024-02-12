import 'package:azkar_muslims_app/screens/azkar_category_screen.dart';
import 'package:azkar_muslims_app/screens/sebha_screen.dart';
import 'package:azkar_muslims_app/screens/qiblah_screen.dart';
import 'package:flutter/material.dart';
import '../models/category_model.dart';
import 'azan_screen.dart';

class HomePage extends StatefulWidget {
   HomePage({Key? key, }) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

   // final Widget pageName;
  List<CategoryModel> Category=[
    CategoryModel(name: 'الأذكار', icon: 'assets/images/quran.png', pageName: AzkarCategoryPage(),),
    CategoryModel(name: 'مواعيد الصلاة', icon: 'assets/images/praying.png', pageName: AzanPage(),),
    CategoryModel(name: 'القبلة', icon: 'assets/images/qibla.png', pageName: QiblahPage(),),
    CategoryModel(name: 'السبحة', icon: 'assets/images/arabic.png', pageName: SebhaPage(),),


  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/images/background 2.jpg'),
              fit: BoxFit.fill
          )
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Padding(

          padding: const EdgeInsets.all(30.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Spacer(flex: 1,),
              const Text('حصن المسلم',style: TextStyle(
                fontFamily: 'Tajawal',
                fontSize: 35,
                color: Color(0xff87854f),
                fontWeight: FontWeight.bold,
              ),),
              Expanded(
                flex: 2,
                child: GridView.builder(
                  itemCount: Category.length,
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                      crossAxisSpacing: 25,
                      mainAxisSpacing: 25
                    ),
                    itemBuilder: (context,index){
                      return GestureDetector(
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(
                              builder: (context){
                              return  Category[index].pageName;
                          }));
                        },
                        child: Container(
                          decoration: BoxDecoration(

                            borderRadius: BorderRadius.circular(20),
                            color: Colors.black12,
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Image.asset(Category[index].icon,height: 50,),
                              const SizedBox(height: 10,),
                              Text(Category[index].name,style: const TextStyle(
                                fontFamily: 'Tajawal',fontWeight: FontWeight.bold,fontSize: 17
                              ),)
                            ],
                          ),
                        ),
                      );
                }),
              ),
             // const Spacer(flex: 1,),

            ],
          ),
        ),
      ),
    );
  }
}
