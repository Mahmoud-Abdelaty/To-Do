// ignore_for_file: prefer_const_literals_to_create_immutables, sized_box_for_whitespace, must_be_immutable, unnecessary_string_interpolations, use_key_in_widget_constructors, prefer_const_constructors, avoid_print
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:to_do/shared/cubit/cubit.dart';

Widget buildTaskItem(Map model, context) => Dismissible(
  key: Key(model['id'].toString()),
  direction: DismissDirection.startToEnd,
  onDismissed: (direction){
    AppCubit.get(context).deleteDatabase(id: model['id']);
  },
  background: Stack(
    alignment: AlignmentDirectional.centerStart,
    children:
    [
      Container(
        alignment: AlignmentDirectional.center,
        decoration: BoxDecoration(
          color: Colors.red,
          borderRadius: BorderRadiusDirectional.only(
            topStart: Radius.circular(20),
            bottomStart: Radius.circular(20),
          ),
        ),
        clipBehavior: Clip.antiAliasWithSaveLayer,
        width: 100,
        height: 100,
        child: Text(
          'Delete',
          style: TextStyle(
              color: Colors.black,
              fontSize: 20
          ),
        ),
      ),
    ],
  ),
  child: Padding(

    padding: const EdgeInsets.all(20.0),

    child: Row(

      children:

      [

        CircleAvatar(

          radius: 40,

          backgroundColor: Colors.amber,

          child: Text(

              '${model['time']}',

            style: TextStyle(

              color: Colors.indigo,

              fontWeight: FontWeight.w500

            ),

          ),

        ),

        SizedBox(

          width: 20,

        ),

        Expanded(

          child: Column(

            mainAxisSize: MainAxisSize.min,

            crossAxisAlignment: CrossAxisAlignment.start,

            children:

            [

              Text(

                '${model['title']}',

                style: TextStyle(

                  color: Colors.indigo,

                  fontSize: 20,

                  fontWeight: FontWeight.bold,

                ),

              ),

              Text(

                '${model['date']}',

                style: TextStyle(

                  color: Colors.indigo,

                  fontSize: 15,

                  fontWeight: FontWeight.bold,

                ),

              ),

            ],

          ),

        ),

        IconButton(

            onPressed: ()

            {

              AppCubit.get(context).updateDatabase(

                  status: 'Done',

                  id: model['id'],

              );

            },

            icon: Icon(

              Icons.check_box_rounded,

              color: Colors.amber[600],

            ),),

        IconButton(

          onPressed: ()

          {

            AppCubit.get(context).updateDatabase(status: 'Archive', id: model['id']);

          },

          icon: Icon(

            Icons.archive_rounded,

            color: Colors.amber[600],

          ),),

      ],

    ),

  ),
);

Widget noTasks(List<Map> tasks) => ConditionalBuilder(
  condition: tasks.isNotEmpty,
  builder: (context) => ListView.separated(
    itemBuilder: (context,index) {
      return buildTaskItem(tasks[index],context);
    },
    separatorBuilder: (context,index) => Padding(
      padding: const EdgeInsets.symmetric(
          horizontal: 35
      ),
      child: Container(
        color: Colors.indigo,
        width: double.infinity,
        height: 1,
      ),
    ),
    itemCount: tasks.length,
    physics: BouncingScrollPhysics(),
  ),
  fallback: (context) => Center(
    child: SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children:
        [
          Icon(
            Icons.menu,
            color: Colors.white24,
            size: 100,
          ),
          Text(
            'No Tasks Yet, Please Add Some Tasks',
            style: TextStyle(
                color: Colors.white24,
                fontWeight: FontWeight.bold,
                fontSize: 16
            ),
          ),
        ],
      ),
    ),
  ),

);







// Widget buildNoTasks() => Center(
//   child: Column(
//     mainAxisAlignment: MainAxisAlignment.center,
//     children:
//     [
//       Icon(
//         Icons.menu,
//         color: Colors.white24,
//         size: 100,
//       ),
//       Text(
//         'No TAsks Yet, Please Add Some Tasks',
//         style: TextStyle(
//             color: Colors.white24,
//             fontWeight: FontWeight.bold,
//             fontSize: 16
//         ),
//       ),
//     ],
//   ),
// );
