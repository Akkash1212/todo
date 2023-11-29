class DataModel {
  String task;
  String date;
  String endDate;
  bool status;
  String id;

  DataModel(
      {required this.task,
      required this.date,
      required this.endDate,
      this.status = false,
      required this.id});
  factory DataModel.fromMap(Map data) {
    print(data);
    return DataModel(
      id: data['id'],
      task: data['task'],
      date: data['date'],
      endDate: data['endDate'],
      status: data['status'],
    );
  }
}
