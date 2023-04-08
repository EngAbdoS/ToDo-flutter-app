import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:todo/newsapp/dio_helper.dart';

import 'home_layout.dart';
import 'new_task_screen.dart';
import 'newsapp/news_layout.dart';
import 'observer.dart';
void main() {
  Bloc.observer = MyBlocObserver();
DioHelper.init();
  runApp(MyApp());
}
 class MyApp extends StatelessWidget {
   @override
   Widget build(BuildContext context) {
     return MaterialApp(
       theme: ThemeData(
         scaffoldBackgroundColor: Colors.orange,
         appBarTheme: AppBarTheme(
           elevation: .6,
           backgroundColor: Colors.orange,
backwardsCompatibility: false,
           systemOverlayStyle: SystemUiOverlayStyle(
             statusBarColor: Colors.indigo,

           ),
         ),
         bottomNavigationBarTheme: BottomNavigationBarThemeData(
           type: BottomNavigationBarType.fixed
         ),
       ),






       debugShowCheckedModeBanner: false,
      // theme: ThemeData.dark(),
       home:NewTaskScreen(),


     );
   }
 }
 