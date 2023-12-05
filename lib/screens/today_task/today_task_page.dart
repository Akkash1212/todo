import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/constant/ak_colors.dart';
import 'package:todo/helper/date_helper.dart';
import 'package:todo/main.dart';
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

  // final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    final todoProvider = Provider.of<TodoProvider>(context);

    return Scaffold(
      resizeToAvoidBottomInset: true,
      // key: scaffoldKey,
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
          'Today Task ',
          style: TextStyle(
              color: AKColors.kMainColor,
              fontSize: 28,
              fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
              onPressed: () {
                FirebaseAuth.instance.signOut();
              },
              icon: Icon(
                Icons.logout,
                color: AKColors.kMainColor,
              )),
        ],
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection('todo')
                    .orderBy('endDate')
                    .where('email', isEqualTo: '${auth.currentUser?.email}')
                    .snapshots(),
                builder: (_, snapshot) {
                  if (!snapshot.hasData) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  } else {
                    final docs = snapshot.data!.docs;
                    print(docs);
                    return ListView(
                        children: docs.map((e) {
                      Map<String, dynamic> data =
                          e.data() as Map<String, dynamic>;
                      Timestamp endDate = data['endDate'];
                      Timestamp date = data['date'];

                      Map<String, dynamic> taskData = {
                        ...data,
                        "docId": e.id,
                        "endDate": endDate.toDate().toString(),
                        "date": date.toDate().toString(),
                      };
                      print(taskData);

                      return TaskTail(dataModel: DataModel.fromMap(taskData));
                    }).toList());
                  }
                },
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
