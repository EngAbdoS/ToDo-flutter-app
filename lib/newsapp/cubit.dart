import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/newsapp/business/busness_screen.dart';
import 'package:todo/newsapp/science/science_screen.dart';
import 'package:todo/newsapp/settings.dart';
import 'package:todo/newsapp/sports/sports_screen.dart';
import 'package:todo/newsapp/states.dart';

class NewsCubit extends Cubit<NewsState> {
  NewsCubit() : super(NewsInitialState());

  static NewsCubit get(context) => BlocProvider.of(context);
  int currentIndex = 0;

  List<BottomNavigationBarItem> bottomItems = [
    BottomNavigationBarItem(
      icon: Icon(
        Icons.business_center_outlined,
      ),
      label: 'Business',
    ),

    BottomNavigationBarItem(
      icon: Icon(
        Icons.sports_handball,
      ),
      label: 'Sport',
    ),
    BottomNavigationBarItem(
      icon: Icon(
        Icons.science_outlined,
      ),
      label: 'Science',
    ), BottomNavigationBarItem(
      icon: Icon(
        Icons.settings,
      ),
      label: 'Settings',
    ),
  ];

  List<Widget> screens = [
    BusinessScreen(),
    SportsScreen(),
    ScienceScreen(),
    Settings(),

  ];

  void changeBottomnavbar(int index) {
    currentIndex = index;
    emit(NewsBottomNav());
  }
}
