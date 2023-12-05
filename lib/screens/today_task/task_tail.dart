import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/constant/ak_colors.dart';
import 'package:todo/helper/date_helper.dart';
import 'package:todo/provider/todoprovider.dart';

import 'model.dart';

class TaskTail extends StatelessWidget {
  TaskTail({super.key, required this.dataModel});
  final DataModel dataModel;
  final GlobalKey globalKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    final todoProvider = Provider.of<TodoProvider>(context);
    return Dismissible(
      key: globalKey,
      onDismissed: (details) {
        todoProvider.deleteTask(dataModel: dataModel);
      },
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        padding: EdgeInsets.symmetric(horizontal: 5),
        height: 60,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          color: AKColors.kBoxBackgroundColor,
          borderRadius: BorderRadius.circular(5),
        ),
        child: Row(
          children: [
            Expanded(
              flex: 8,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      dataModel.task,
                      style: TextStyle(
                          fontSize: 22,
                          color: dataModel.status
                              ? AKColors.kSecondaryColor
                              : AKColors.kMainColor,
                          decoration: dataModel.status
                              ? TextDecoration.lineThrough
                              : null),
                    ),
                    Text(
                      DateHelper.ddMMyyyy(date: dataModel.endDate),
                      style: TextStyle(
                          fontSize: 18, color: AKColors.kSecondaryColor),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                child: IconButton(
                  onPressed: () {
                    todoProvider.toggleComplete(dataModel: dataModel);
                  },
                  splashRadius: 20,
                  icon: Icon(
                    dataModel.status
                        ? Icons.check_box_outlined
                        : Icons.check_box_outline_blank,
                    color: dataModel.status
                        ? AKColors.kSecondaryColor
                        : AKColors.kMainColor,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
