// ignore_for_file: avoid_print, unnecessary_string_interpolations, curly_braces_in_flow_control_structures

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sqflite/sqflite.dart';
import 'package:to_do/modules/archived_tasks/archived_tasks_screen.dart';
import 'package:to_do/modules/done_tasks/done_tasks_screen.dart';
import 'package:to_do/modules/new_tasks/new_tasks_screen.dart';
import 'package:to_do/shared/cubit/states.dart';

class AppCubit extends Cubit<AppStates>
{
  AppCubit() : super(AppInitialState());

  static AppCubit get(context) => BlocProvider.of(context);


  int currentIndex = 0;

  List<Widget> screens =
  [
    NewTasksScreen(),
    DoneTasksScreen(),
    ArchivedTasksScreen(),
  ];

  List<String> titles =
  [
    'New Tasks',
    'Done Tasks',
    'Archived Tasks',
  ];

  void changeIndex(int index)
  {
    currentIndex=index;
    emit(AppChangeBottomNavBarState());
  }


  late Database database;

  List<Map> newTasks = [];
  List<Map> doneTasks = [];
  List<Map> archivedTasks = [];

  void createDatabase() {
    // open the database
    openDatabase(
        'todo.db',
        version: 1,
        onCreate: (Database db, int version) async {
          // When creating the db, create the table
          print('Database Opened');
          await db.execute(
              'CREATE TABLE Tasks (id INTEGER PRIMARY KEY, title TEXT, time Text, date Text, status Text)')
              .then((value) {
            print('Table Created');
          }).catchError((error) {
            print('Error Ya bro Rakez ${error.toString()}');
          });
        },
        onOpen: (database)
        {
          getDatabase(database);
          print('Database Opened');
        }
    ).then((value)
    {
       database = value;
       emit(AppCreateDatabaseState());
    });
  }

   insertToDatabase({
    required String title,
    required String time,
    required String date,
  })
  {
    // Insert some records in a transaction
      database.transaction((txn) async {
      await txn.rawInsert(
          'INSERT INTO Tasks (title, time, date, status) VALUES("$title", "$time", "$date", "New")').then((value) {

        print('$value Inserted Successfully');
        emit(AppInsertDatabaseState());

        getDatabase(database);
      }).catchError((error) {
        print(
            'Error When Inserting New Record Ya bro Rakez ${error.toString()}');
      });
    });
  }

  void getDatabase(database)
  {
    newTasks=[];
    doneTasks=[];
    archivedTasks=[];


    emit(AppGetDatabaseLoadingState());
    database.rawQuery('SELECT * FROM Tasks').then((value)
    {

      value.forEach((element)
      {
        if(element['status'] == 'New')
          newTasks.add(element);
        else if(element['status'] == 'Done')
          doneTasks.add(element);
        else archivedTasks.add(element);
      });

      emit(AppGetDatabaseState());
    });
  }

  void updateDatabase({
   required String status,
   required int id,
}) async
  {
    database.rawUpdate(
        'UPDATE Tasks SET status = ? WHERE id = ?',
        ['$status', id]).then((value)
    {
      getDatabase(database);
      emit(AppUpdateDatabaseState());
    });
  }

  void deleteDatabase({
  required int id,
})
  {
    database.rawDelete('DELETE FROM Tasks WHERE id = ?', [id]).
    then((value)
    {
      getDatabase(database);
      emit(AppDeleteDatabaseState());
    });
  }

  bool isBottomSheetShown = false;
  IconData fabIcon = Icons.edit;

  void changeBottomSheetState({
    required bool isShow,
    required IconData icon,
})
  {
    isBottomSheetShown = isShow;
    fabIcon = icon;
    emit(AppChangeBottomSheetState());
  }

}