import 'package:flutter/material.dart';
import 'package:todo/constant/ak_colors.dart';

class LoginTextField extends StatelessWidget {
  const LoginTextField(
      {super.key,
      this.controller,
      this.isError = false,
      this.hintText = 'Enter Task',
      this.onchange,
      this.label = 'lable'});
  final TextEditingController? controller;
  final bool isError;
  final String hintText;
  final ValueChanged? onchange;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(
            10,
          ),
          border:
              Border.all(width: 2, color: isError ? Colors.red : Colors.grey)),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          hintText: hintText,
          border: InputBorder.none,
        ),
        onChanged: onchange,
      ),
    );
  }
}
