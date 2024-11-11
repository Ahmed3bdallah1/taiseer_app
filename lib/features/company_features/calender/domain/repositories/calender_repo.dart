import 'package:fpdart/fpdart.dart';
import 'package:learning/core/errors/failure.dart';
import '../../data/models/calender_history_model.dart';
import '../entities/calender_day_entity.dart';

abstract class CalenderRepo {
  Future<Either<Failure, List<CalenderDayEntity>>> getCalender();
  Future<Either<Failure, List<CalenderHistoryModel>>> getDayCalenderForOrder(
      int id);
}
