import 'package:flutter/material.dart';
import 'package:todo/constant/ak_colors.dart';

import 'model.dart';

class TaskTail extends StatelessWidget {
  const TaskTail({super.key, required this.dataModel});
  final DataModel dataModel;

  @override
  Widget build(BuildContext context) {
    return Container(
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
                    dataModel.endDate,
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
                  dataModel.status = !dataModel.status;
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
    );
  }
}
