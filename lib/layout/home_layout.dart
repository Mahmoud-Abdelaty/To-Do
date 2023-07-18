// ignore_for_file: prefer_const_literals_to_create_immutables, sized_box_for_whitespace, must_be_immutable, unnecessary_string_interpolations, use_key_in_widget_constructors, prefer_const_constructors, avoid_print, unused_local_variable
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do/shared/cubit/cubit.dart';
import 'package:to_do/shared/cubit/states.dart';

// 1. create database
// 2. create tables
// 3. open database
// 4. insert database
// 5. get from database
// 6. update in database
// 7. delete from database

class HomeLayout extends StatelessWidget
{
  var scaffoldKey = GlobalKey<ScaffoldState>();
  var formKey = GlobalKey<FormState>();
  var titleController = TextEditingController();
  var timeController = TextEditingController();
  var dateController = TextEditingController();

  @override
  Widget build(BuildContext context)
  {
    return BlocProvider(
      create: (BuildContext context) => AppCubit()..createDatabase(),
      child: BlocConsumer<AppCubit, AppStates>(
        listener: (BuildContext context, AppStates state)
        {
          if(state is AppInsertDatabaseState)
            {
              Navigator.pop(context);
            }
        },
        builder: (BuildContext context, AppStates state)
          {
            AppCubit cubit = AppCubit.get(context);

            return Scaffold(
              key: scaffoldKey,
              backgroundColor: Colors.black,
              appBar: AppBar(
                // systemOverlayStyle: SystemUiOverlayStyle(
                //   statusBarColor: Colors.black,
                //   statusBarBrightness: Brightness.light,
                // ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(0),
                ),
                centerTitle: true,
                backgroundColor: Colors.indigo,
                elevation: 15,
                shadowColor: Colors.indigoAccent,
                title: Text(
                  cubit.titles[cubit.currentIndex],
                  style: TextStyle(
                      color: Colors.black
                  ),
                ),
              ),
              body: ConditionalBuilder(
                condition: state is! AppGetDatabaseLoadingState,
                builder: (context) => cubit.screens[cubit.currentIndex],
                fallback: (context) => Center(child: CircularProgressIndicator(
                  color: Colors.amber,
                )),
              ),
              bottomNavigationBar: BottomNavigationBar(
                backgroundColor: Colors.black,
                elevation: 0,
                // selectedFontSize: 15,
                // unselectedFontSize: 10,
                type: BottomNavigationBarType.fixed,
                selectedItemColor: Colors.indigo[500],
                unselectedItemColor: Colors.blueGrey[900],
                currentIndex: cubit.currentIndex,
                onTap: (index) {
                 cubit.changeIndex(index);
                },
                items:
                [
                  BottomNavigationBarItem(
                    icon: Icon(
                      Icons.task,
                    ),
                    label: 'Tasks',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(
                      Icons.cloud_done,
                    ),
                    label: 'Done',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(
                      Icons.archive,
                    ),
                    label: 'Archive',
                  ),
                ],

              ),
            );
          }
      )
    );
  }

  Future<String> getName() async
  {
    return 'Hello Bro';
  }


}




