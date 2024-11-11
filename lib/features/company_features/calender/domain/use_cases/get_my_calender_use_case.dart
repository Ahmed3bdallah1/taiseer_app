import 'package:fpdart/fpdart.dart';
import 'package:learning/core/errors/failure.dart';
import 'package:learning/core/use_cases/use_case.dart';
import '../entities/calender_day_entity.dart';
import '../repositories/calender_repo.dart';

class GetMyCalenderUseCase
    extends UseCaseNoParam<List<CalenderDayEntity>> {
  final CalenderRepo myInstallmentRepo;
  GetMyCalenderUseCase(this.myInstallmentRepo);
  @override
  Future<Either<Failure, List<CalenderDayEntity>>> call() {
    return myInstallmentRepo.getCalender();
  }
}
