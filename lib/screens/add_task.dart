import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:todo/helper/message_helper.dart';
import 'package:todo/main.dart';
import 'package:todo/provider/todoprovider.dart';

import '../constant/ak_colors.dart';
import '../helper/date_helper.dart';

class AddTask extends StatefulWidget {
  AddTask({super.key});

  @override
  State<AddTask> createState() => _AddTaskState();
}

class _AddTaskState extends State<AddTask> {
  final TextEditingController taskcontroller = TextEditingController();

  Future<DateTime?> myDatePicker(BuildContext context) async {
    DateTime? picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(1998),
        lastDate: DateTime(2030));

    return picked;
  }

  @override
  Widget build(BuildContext context) {
    final todoProvider = Provider.of<TodoProvider>(context);
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
              height: 180.h,
              width: 1.sw,
              decoration: BoxDecoration(
                  border: Border.all(color: AKColors.kMainColor, width: 3),
                  borderRadius: BorderRadius.circular(10)),
              child: TextField(
                controller: taskcontroller,
                decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Enter Your Task',
                    hintStyle: TextStyle(color: AKColors.kSecondaryColor),
                    suffixIcon: Icon(Icons.task)),
                style: TextStyle(color: AKColors.kSecondaryColor, fontSize: 20),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
              height: 180.h,
              width: 1.sw,
              decoration: BoxDecoration(
                  border: Border.all(
                    color: AKColors.kMainColor,
                    width: 3,
                  ),
                  borderRadius: BorderRadius.circular(10)),
              child: TextButton(
                onPressed: () {},
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      DateHelper.ddMMyyyy(
                          date: todoProvider.todayDate, splitter: '/'),
                      style: TextStyle(
                          fontSize: 15, color: AKColors.kSecondaryColor),
                    ),
                    Icon(
                      Icons.date_range,
                      color: AKColors.kSecondaryColor,
                    )
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
              height: 180.h,
              width: 1.sw,
              decoration: BoxDecoration(
                  border: Border.all(
                    color: AKColors.kMainColor,
                    width: 3,
                  ),
                  borderRadius: BorderRadius.circular(10)),
              child: TextButton(
                onPressed: () async {
                  DateTime? endDate = await myDatePicker(context);
                  todoProvider.changePickedDate(endDate);
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      DateHelper.ddMMyyyy(date: todoProvider.pickedDate),
                      style: TextStyle(
                          fontSize: 15, color: AKColors.kSecondaryColor),
                    ),
                    Icon(
                      Icons.date_range,
                      color: AKColors.kSecondaryColor,
                    )
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            TextButton(
                onPressed: () async {
                  Map<String, dynamic> addTask = {
                    'task': '${taskcontroller.text}',
                    'date': DateTime.now(),
                    'endDate': todoProvider.pickedDate,
                    'status': false,
                    'email': auth.currentUser?.email,
                  };
                  await todoProvider.addDB(addTask);
                  // await todoProvider.getDBdata();
                  if (context.mounted) {
                    MyMessageHelper.snackBar(context,
                        message: 'Task Successfully Added');
                    taskcontroller.clear();
                    todoProvider.dateReset();

                    Navigator.pop(context);
                  }
                },
                child: Container(
                  alignment: Alignment.center,
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  height: 180.h,
                  width: 0.6.sw,
                  decoration: BoxDecoration(
                      border: Border.all(color: AKColors.kMainColor, width: 3),
                      borderRadius: BorderRadius.circular(10)),
                  child: Text(
                    'Submit',
                    style: TextStyle(
                        color: AKColors.kSecondaryColor, fontSize: 25),
                  ),
                ))
          ],
        ),
      ),
    );
  }
}
