class DataModel {
  String task;
  DateTime date;
  DateTime endDate;
  bool status;
  String id;
  String email;

  DataModel(
      {required this.task,
      required this.date,
      required this.endDate,
      this.status = false,
      required this.id,
      required this.email});
  factory DataModel.fromMap(Map data) {
    DateTime date = DateTime.parse(data['date']);
    DateTime endDate = DateTime.parse(data['endDate']);

    return DataModel(
        id: data['docId'],
        task: data['task'],
        date: date,
        endDate: endDate,
        status: data['status'],
        email: data['email']);
  }
}
