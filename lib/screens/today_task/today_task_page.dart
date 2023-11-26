import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/constant/ak_colors.dart';
import 'package:todo/helper/date_helper.dart';
import 'package:todo/provider/todoprovider.dart';
import 'package:todo/screens/add_task.dart';

import 'model.dart';
import 'task_tail.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TodayTask extends StatelessWidget {
  TodayTask({super.key});
  _addTaskBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
            topRight: Radius.circular(20), topLeft: Radius.circular(20)),
      ),
      builder: (context) {
        return AddTask();
      },
    );
  }

  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    final todayTaskProvider = Provider.of<TodoProvider>(context);

    return SafeArea(
      child: Scaffold(
        key: scaffoldKey,
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: FloatingActionButton(
          backgroundColor: AKColors.kMainColor,
          onPressed: () {
            _addTaskBottomSheet(context);
            // Navigator.push(
            //   context,
            //   MaterialPageRoute(
            //     builder: (context) => AddTask(),
            //   ),
            //);
          },
          child: Icon(
            Icons.add,
            size: 40,
          ),
        ),
        appBar: AppBar(
          backgroundColor: Colors.white,
          centerTitle: true,
          leading: Icon(
            Icons.menu,
            size: 30,
            color: AKColors.kSecondaryColor,
          ),
          title: Text(
            'Today Task ${todayTaskProvider.pickedDate}',
            style: TextStyle(
                color: AKColors.kMainColor,
                fontSize: 28,
                fontWeight: FontWeight.bold),
          ),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(
                      height: 20,
                    ),
                    TextButton(
                      onPressed: () {
                        todayTaskProvider.getDBdata();
                      },
                      child: Text('Get'),
                    ),
                    Column(
                      children: getDataList
                          .map(
                              (e) => TaskTail(task: e.task, endDate: e.endDate))
                          .toList(),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              height: 50,
              width: MediaQuery.of(context).size.width,
              color: AKColors.kBoxBackgroundColor,
            ),
          ],
        ),
      ),
    );
  }
}
