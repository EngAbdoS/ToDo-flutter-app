import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/components.dart';
import 'package:todo/cubit/cubit.dart';
import 'package:todo/cubit/states.dart';

import 'constans.dart';

class NewTaskScreen extends StatefulWidget {

  @override
  _NewTaskScreenState createState() => _NewTaskScreenState();
}

class _NewTaskScreenState extends State<NewTaskScreen> {
  @override
  Widget build(BuildContext context) {
     return BlocConsumer<AppCubit,AppStates>(
       listener: (context,state){},
       builder: (context,state){
         var tasks=AppCubit.get(context).tasks;
       return ListView.separated(
           itemBuilder: (context, index) => buildTaskItem(tasks[index],context),
           separatorBuilder: (context, index) => Padding(
                 padding: const EdgeInsetsDirectional.only(start: 20, end: 20),
                 child: Container(
                   width: double.infinity,
                   height: 1,
                   color: Colors.grey[300],
                 ),
               ),
           itemCount: tasks.length);}
     );
  }
}
