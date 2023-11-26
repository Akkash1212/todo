import 'package:flutter/material.dart';
import 'package:todo/constant/ak_colors.dart';

class TaskTail extends StatefulWidget {
  TaskTail(
      {super.key,
      required this.task,
      required this.endDate,
      this.isChecked = false});
  final String task;
  final String endDate;
  bool isChecked;

  @override
  State<TaskTail> createState() => _TaskTailState();
}

class _TaskTailState extends State<TaskTail> {
  bool get isChecked => widget.isChecked;
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
                    widget.task,
                    style: TextStyle(
                        fontSize: 22,
                        color: isChecked
                            ? AKColors.kSecondaryColor
                            : AKColors.kMainColor,
                        decoration:
                            isChecked ? TextDecoration.lineThrough : null),
                  ),
                  Text(
                    widget.endDate,
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
                  widget.isChecked = !widget.isChecked;
                  setState(() {});
                },
                splashRadius: 20,
                icon: Icon(
                  isChecked
                      ? Icons.check_box_outlined
                      : Icons.check_box_outline_blank,
                  color: isChecked
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
