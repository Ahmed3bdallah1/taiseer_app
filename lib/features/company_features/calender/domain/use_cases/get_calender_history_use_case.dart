import 'package:fpdart/fpdart.dart';
import 'package:taiseer/core/errors/failure.dart';
import 'package:taiseer/core/use_cases/use_case.dart';
import '../../data/models/calender_history_model.dart';
import '../repositories/calender_repo.dart';

class GetDatesForOrderUseCase
    extends UseCaseParam<List<CalenderHistoryModel>, int> {
  final CalenderRepo myInstallmentRepo;
  GetDatesForOrderUseCase(this.myInstallmentRepo);
  @override
  Future<Either<Failure, List<CalenderHistoryModel>>> call(int param) {
    return myInstallmentRepo.getDayCalenderForOrder(param);
  }
}
