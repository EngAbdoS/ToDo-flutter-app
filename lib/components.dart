import 'package:flutter/material.dart';
import 'package:todo/cubit/cubit.dart';

Widget buildTaskItem(Map model, context) => Padding(
      padding: const EdgeInsets.all(20.0),
      child: Row(
        children: [
          CircleAvatar(
            radius: 40,
            child: Text('${model['time']}'),
          ),
          SizedBox(
            width: 20,
          ),
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${model['title']}',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  '${model['date']}',
                  style: TextStyle(
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            width: 20,
          ),
          IconButton(
            onPressed: () {
              AppCubit.get(context).updatDB(
                status: 'done',
                id: model['id'],
              );
            },
            icon: Icon(Icons.check_box),
          ),
          SizedBox(
            width: 20,
          ),
          IconButton(
            onPressed: () { AppCubit.get(context).updatDB(
              status: 'archive',
              id: model['id'],
            );},
            icon: Icon(Icons.archive_outlined),
          ),
        ],
      ),
    );
