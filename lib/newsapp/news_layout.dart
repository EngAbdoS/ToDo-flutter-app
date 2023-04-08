import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/newsapp/cubit.dart';
import 'package:todo/newsapp/dio_helper.dart';
import 'package:todo/newsapp/states.dart';

class NewsLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext) => NewsCubit(),
      child: BlocConsumer<NewsCubit, NewsState>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit = NewsCubit.get(context);
          return Scaffold(
            appBar: AppBar(
              title: Text("News App"),
              actions: [
                IconButton(onPressed: () {}, icon: Icon(Icons.search_off))
              ],
            ),
            bottomNavigationBar: BottomNavigationBar(
              currentIndex: cubit.currentIndex,
              onTap: (index) {
                cubit.changeBottomnavbar(index);
              },
              items: cubit.bottomItems,
            ),
            body: cubit.screens[cubit.currentIndex],
            floatingActionButton: FloatingActionButton(
              child: Icon(Icons.plumbing_sharp),
              onPressed: () {
                DioHelper.getdata(
                  url: '',
                  query: {'': ''},
                ).then((value) => null).catchError(() {});
              },
            ),
          );
        },
      ),
    );
  }
}
