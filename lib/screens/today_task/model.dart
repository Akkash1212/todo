class DataModel {
  String task;
  String date;
  String endDate;
  bool status;

  DataModel({
    required this.task,
    required this.date,
    required this.endDate,
    this.status = false,
  });
  factory DataModel.fromMap(Map data) {
    return DataModel(
      task: data['task'],
      date: data['date'],
      endDate: data['endDate'],
      status: data['status'],
    );
  }
}
