import '../../data/models/calender_history_model.dart';

class CalenderDayEntity {
  String date;
  List<CalenderHistoryModel> installment;
  CalenderDayEntity({required this.date, required this.installment});
}
