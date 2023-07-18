// ignore_for_file: prefer_const_literals_to_create_immutables, sized_box_for_whitespace, must_be_immutable, unnecessary_string_interpolations, use_key_in_widget_constructors, prefer_const_constructors, avoid_print
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:to_do/shared/components/components.dart';
import 'package:to_do/shared/cubit/cubit.dart';
import 'package:to_do/shared/cubit/states.dart';


class NewTasksScreen extends StatelessWidget
{
  var scaffoldKey = GlobalKey<ScaffoldState>();
  var formKey = GlobalKey<FormState>();
  var titleController = TextEditingController();
  var timeController = TextEditingController();
  var dateController = TextEditingController();

  @override
  Widget build(BuildContext context)
  {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state){},
      builder: (context, state)
      {
        var tasks = AppCubit.get(context).newTasks;
        AppCubit cubit = AppCubit.get(context);
        //return noTasks(tasks);
        return Scaffold(
          key: scaffoldKey,
          backgroundColor: Colors.black,
          body: noTasks(tasks),
          floatingActionButton: SingleChildScrollView(
            child: FloatingActionButton(
              backgroundColor: Colors.indigo,
              splashColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              onPressed: () {
                // try
                // {
                //   var name =  await getName();
                //   print(name);
                //   print('jjj');
                //   throw('some error');
                //
                // }
                // catch(error)
                // {
                //   print('${error.toString()}');
                // }
                // getName().then((value)
                // {
                //   print(value);
                //   print('osma');
                //   throw('some error');
                // }).catchError((v)
                // {
                //   print('error ${v.toString()}');
                // }
                // );
                if (cubit.isBottomSheetShown) {
                  if (formKey.currentState!.validate()) {
                    cubit.insertToDatabase(
                        title: titleController.text,
                        time: timeController.text,
                        date: dateController.text);
                  }
                }
                else {
                  scaffoldKey.currentState!.showBottomSheet((context) {
                    return Form(
                      key: formKey,
                      child: SingleChildScrollView(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children:
                          [
                            Container(
                              padding: EdgeInsets.all(10),
                              color: Colors.indigo[200],
                              child: TextFormField(
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Title mustn\'t be empty bro';
                                  }
                                  return null;
                                },
                                controller: titleController,
                                cursorColor: Colors.amber,
                                keyboardType: TextInputType.text,
                                style: TextStyle(
                                  color: Colors.black87,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15,
                                ),
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Colors.indigo,
                                    ),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Colors.indigo,
                                    ),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  prefixIcon: Icon(
                                    Icons.title_rounded,
                                    size: 25,
                                    color: Colors.indigo,
                                  ),
                                  labelText: 'Title',
                                  labelStyle: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.indigo,
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.all(10),
                              color: Colors.indigo[200],
                              child: TextFormField(
                                cursorColor: Colors.amber,
                                controller: timeController,
                                keyboardType: TextInputType.datetime,
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Time mustn\'t be empty bro';
                                  }
                                  return null;
                                },
                                onTap: () {
                                  print('Title : ${titleController.text}');
                                  FocusScope.of(context).requestFocus(FocusNode());
                                  showTimePicker(
                                    context: context,
                                    initialTime: TimeOfDay.now(),
                                  ).then((value) {
                                    timeController.text = value!.format(context);
                                    print('Time  : ${value.format(context)}');
                                  });
                                },
                                style: TextStyle(
                                  color: Colors.black87,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15,
                                ),
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Colors.indigo,
                                    ),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Colors.indigo,
                                    ),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  prefixIcon: Icon(
                                    Icons.watch_later_outlined,
                                    size: 25,
                                    color: Colors.indigo,
                                  ),
                                  labelText: 'Task Time',
                                  labelStyle: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.indigo,
                                  ),
                                ),

                              ),
                            ),
                            Container(
                              padding: EdgeInsets.all(10),
                              color: Colors.indigo[200],
                              child: TextFormField(
                                cursorColor: Colors.amber,
                                controller: dateController,
                                keyboardType: TextInputType.datetime,
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Date time mustn\'t be empty bro';
                                  }
                                  return null;
                                },
                                onTap: () {
                                  FocusScope.of(context).requestFocus(FocusNode());
                                  showDatePicker(
                                    context: context,
                                    initialDate: DateTime.now(),
                                    firstDate: DateTime.now(),
                                    lastDate: DateTime.parse('50000-01-01'),
                                  ).then((value) {
                                    dateController.text =
                                        DateFormat.yMMMEd().format(value!);
                                    print(
                                        'Date  : ${DateFormat.yMMMEd().format(value)}');
                                  });
                                },
                                style: TextStyle(
                                  color: Colors.black87,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15,
                                ),
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Colors.indigo,
                                    ),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Colors.indigo,
                                    ),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  prefixIcon: Icon(
                                    Icons.date_range_rounded,
                                    size: 25,
                                    color: Colors.indigo,
                                  ),
                                  labelText: 'Date Time',
                                  labelStyle: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.indigo,
                                  ),
                                ),

                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }).closed.then((value) {
                    cubit.changeBottomSheetState(
                        isShow: false,
                        icon: Icons.edit
                    );
                  });
                  cubit.changeBottomSheetState(
                      isShow: true,
                      icon: Icons.done
                  );
                }
              },
              child: Icon(
                cubit.fabIcon,
                color: Colors.amber,
                size: 30,
              ),
            ),
          ),
        );
      },
    );
  }
}
