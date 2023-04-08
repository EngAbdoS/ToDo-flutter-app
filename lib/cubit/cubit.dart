import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sqflite/sqflite.dart';
import 'package:todo/cubit/states.dart';
import 'package:todo/don_task_screen.dart';

import '../archived_task_screen.dart';
import '../new_task_screen.dart';

class AppCubit extends Cubit<AppStates> {
  AppCubit() : super(AppInitialState());

  static AppCubit get(context) => BlocProvider.of(context);
  int currerntindex = 0;
  Database database;
  bool isBottomSheetDown = false;
  IconData fbIcon = Icons.edit;
  List<String> title = [
    'New Task',
    'Done',
    'Archive',
  ];
  List<Widget> set_screen = [
    NewTaskScreen(),
    DonTaskScreen(),
    ArchivedTaskScreen(),
  ];
  List<Map> tasks = [];
  List<Map> donetasks = [];
  List<Map> archivetasks = [];

  void changeBottomShD({
    @required bool isShow,
    @required IconData icon,
  }) {
    isBottomSheetDown = isShow;
    fbIcon = icon;
    emit(AppChangeBSHstate());
  }

  void changeindex(int index) {
    currerntindex = index;
    emit(AppChangeState());
  }

  void createDatabase() {
    openDatabase(
      'todo.db',
      version: 1,
      onCreate: (database, version) {
        print('database created');
        database
            .execute(
                'CREATE TABLE tasks(id INTEGER PRIMARY KEY,title TEXT,date TEXT,time TEXT,status TEXT)')
            .then((value) {
          print('table created');
        }).catchError((error) {
          print("error when creating table ${error.toString()}");
        });
      },
      onOpen: (database) {
        getDataFromDatabase(database);

        print('database opend');
      },
    ).then((value) {
      database = value;
      emit(AppCreateDB());
    });
  }

  Future insertDatabase({
    @required String title,
    @required String time,
    @required String date,
  }) async {
    await database.transaction((txn) {
      txn
          .rawInsert(
              'INSERT INTO tasks(title,time,date,status) VALUES("$title","$time","$date","new")')
          .then((value) {
        print('$value inserted successfully');
        emit(AppInsertDB());
        getDataFromDatabase(database);
      }).catchError((error) {
        print("error when inserting ${error.toString()}");
      });

      return null;
    });
  }

  void getDataFromDatabase(database) {
    database.rawQuery('SELECT * FROM tasks').then((value) {
      tasks = value;
      print(tasks);
      value.forEach((element) {
       // if (element['status'] == 'new')
        //  tasks.add(element);
     //   else
          if (element['status'] == 'done')
          donetasks.add(element);
        else if (element['status'] == 'archive') archivetasks.add(element);
      });

      emit(AppgetDB());
    });
  }

  void updatDB({@required String status, @required int id}) async {
    database.rawUpdate(
      'UPDATE tasks SET status = ? WHERE id = ?',
      ['$status', id],
    ).then((value) {
      emit(AppupdateDB());
    });
  }
}
