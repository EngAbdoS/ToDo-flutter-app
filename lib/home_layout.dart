import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:sqflite/sqflite.dart';
import 'package:todo/cubit/cubit.dart';
import 'package:todo/cubit/states.dart';
import 'archived_task_screen.dart';
import 'constans.dart';
import 'don_task_screen.dart';
import 'new_task_screen.dart';

class HomeLayout extends StatelessWidget {
  var titlecontroller = TextEditingController();
  var timecontroller = TextEditingController();
  var datecontroller = TextEditingController();
  var scafoldKey = GlobalKey<ScaffoldState>();
  var formKey = GlobalKey<FormState>();

  @override
  // void initState() {
  //   // TODO: implement initState
  //   super.initState();
  //   createDatabase();
  // }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => AppCubit()..createDatabase(),
      child: BlocConsumer<AppCubit, AppStates>(
          listener: (BuildContext context, AppStates state) {
        if (state is AppInsertDB) Navigator.pop(context);
      }, builder: (BuildContext context, AppStates state) {
        AppCubit cubit = AppCubit.get(context);
        return Scaffold(
          key: scafoldKey,
          appBar: AppBar(
            title: Text(
              cubit.title[cubit.currerntindex],
            ),
          ),
          body: ConditionalBuilder(
            condition: cubit.tasks.length > 0,
            builder: (context) => cubit.set_screen[cubit.currerntindex],
            fallback: (context) => Center(
              child: CircularProgressIndicator(),
            ),
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              if (cubit.isBottomSheetDown) {
                if (formKey.currentState.validate()) {
                  cubit.insertDatabase(
                      title: titlecontroller.text,
                      time: timecontroller.text,
                      date: datecontroller.text);
                  // insertDatabase(
                  //   title: titlecontroller.text,
                  //   date: datecontroller.text,
                  //   time: timecontroller.text,
                  // ).then((value) {
                  //   /* getDataFromDatabase(database).then((value) {
                  //     Navigator.pop(context);
                  //     setState(() {
                  //       isBottomSheetDown = false;
                  //       fbIcon = Icons.edit;
                  //       tasks = value;
                  //       print(tasks);
                  //
                  //     });
                  //   });*/
                  //   Navigator.pop(context);
                  //   isBottomSheetDown = false;
                  //   // setState(() {
                  //   //   fbIcon = Icons.edit;
                  //   // });
                  // });//
                }
              } else {
                scafoldKey.currentState
                    .showBottomSheet((context) => Container(
                          color: Colors.purple[100],
                          padding: EdgeInsets.all(20),
                          child: Form(
                            key: formKey,
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                TextFormField(
                                  controller: titlecontroller,
                                  keyboardType: TextInputType.text,
                                  decoration: const InputDecoration(
                                    prefixIcon: Icon(Icons.title),
                                    border: OutlineInputBorder(),
                                    labelText: 'Task title',
                                  ),
                                  validator: (String value) {
                                    if (value.isEmpty) {
                                      return 'date must not be empty';
                                    }
                                    return null;
                                  },
                                ),
                                SizedBox(
                                  height: 15,
                                ),
                                TextFormField(
                                  controller: timecontroller,
                                  onTap: () {
                                    showTimePicker(
                                      context: context,
                                      initialTime: TimeOfDay.now(),
                                    ).then((value) {
                                      timecontroller.text =
                                          value.format(context).toString();
                                    });
                                  },
                                  keyboardType: TextInputType.datetime,
                                  decoration: const InputDecoration(
                                    prefixIcon: Icon(Icons.watch_later),
                                    border: OutlineInputBorder(),
                                    labelText: 'Task Time',
                                  ),
                                  validator: (String value) {
                                    if (value.isEmpty) {
                                      return 'time must not be empty';
                                    }
                                    return null;
                                  },
                                ),
                                SizedBox(
                                  height: 15,
                                ),
                                TextFormField(
                                  controller: datecontroller,
                                  onTap: () {
                                    showDatePicker(
                                      context: context,
                                      initialDate: DateTime.now(),
                                      firstDate: DateTime.now(),
                                      lastDate: DateTime.utc(2022),
                                    ).then((value) {
                                      datecontroller.text = DateFormat.yMMMd()
                                          .format(value); //.toString();
                                    });
                                  },
                                  keyboardType: TextInputType.datetime,
                                  decoration: const InputDecoration(
                                    prefixIcon: Icon(Icons.date_range),
                                    border: OutlineInputBorder(),
                                    labelText: 'Task Date',
                                  ),
                                  validator: (String value) {
                                    if (value.isEmpty) {
                                      return 'Date must not be empty';
                                    }
                                    return null;
                                  },
                                ),
                              ],
                            ),
                          ),
                        ))
                    .closed
                    .then((value) {
                  cubit.changeBottomShD(
                    isShow: false,
                    icon: Icons.edit,
                  );
                });
                cubit.changeBottomShD(
                  isShow: true,
                  icon: Icons.add,
                );
              }
            },
            child: Icon(cubit.fbIcon),
          ),
          bottomNavigationBar: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            currentIndex: cubit.currerntindex,
            onTap: (index) {
              cubit.changeindex(index);
            },
            items: [
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.menu,
                ),
                label: 'New Tasks',
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.check_circle_outline,
                ),
                label: 'Done',
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.archive_outlined,
                ),
                label: 'Archive',
              ),
            ],
          ),
        );
      }),
    );
  }
}
