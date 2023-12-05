import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../helper/date_helper.dart';
import '../screens/today_task/model.dart';

List<DataModel> getDataList = [];
final fs = FirebaseFirestore.instance;

class TodoProvider extends ChangeNotifier {
  // TodoProvider() {
  //   getDBdata();
  // }
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

  addDB(Map<String, dynamic> addData) {
    FirebaseFirestore.instance.collection('todo').add(addData);
  }

  toggleComplete({required DataModel dataModel}) {
    dataModel.status = !dataModel.status;
    fs
        .collection('todo')
        .doc(dataModel.id)
        .update({"status": !dataModel.status});
  }

  deleteTask({required DataModel dataModel}) {
    fs.collection('todo').doc(dataModel.id).delete();
  }

  // getDBdata() async {
  //   final getdata = await fs.collection('todo').get();
  //   getDataList = [];
  //
  //   for (var datas in getdata.docs) {
  //     print(datas.data());
  //
  //     getDataList.add(
  //       DataModel.fromMap({...datas.data(), 'id': datas.id}),
  //     );
  //   }
  //
  //   notifyListeners();
  // }
}
