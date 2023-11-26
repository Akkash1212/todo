import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../helper/date_helper.dart';
import '../screens/today_task/model.dart';

final TextEditingController taskcontroller = TextEditingController();
List<DataModel> getDataList = [];
final fs = FirebaseFirestore.instance;

class TodoProvider extends ChangeNotifier {
  TodoProvider() {
    getDBdata();
  }
  DateTime todayDate = DateTime.now();
  DateTime pickedDate = DateTime.now();
  changePickedDate(DateTime? endDate) {
    pickedDate = endDate ?? DateTime.now();
    notifyListeners();
  }

  dateReset() {
    todayDate = DateTime.now();
    pickedDate = DateTime.now();
    notifyListeners();
  }

  addDB() {
    Map<String, dynamic> addTask = {
      'task': '${taskcontroller.text}',
      'date': DateHelper.ddMMyyyy(date: todayDate),
      'endDate': DateHelper.ddMMyyyy(date: pickedDate),
      'status': false
    };
    print(addTask);
    FirebaseFirestore.instance.collection('todo').add(addTask);
    taskcontroller.clear();
    dateReset();
  }

  getDBdata() async {
    final getdata = await fs.collection('todo').get();
    getDataList = [];

    for (var datas in getdata.docs) {
      print(datas.data());

      getDataList.add(
        DataModel.fromMap(datas.data()),
      );
    }

    notifyListeners();
  }
}
