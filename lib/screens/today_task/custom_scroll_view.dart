import 'package:flutter/material.dart';

class CustomScrollView extends StatelessWidget {
  const CustomScrollView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: 300,
        width: 200,
        color: Colors.yellowAccent[400],
      ),
    );
  }
}
