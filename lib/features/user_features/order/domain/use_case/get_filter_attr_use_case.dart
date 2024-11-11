import 'package:fpdart/fpdart.dart';
import 'package:learning/models/program_model.dart';

import '../../../../../core/errors/failure.dart';
import '../../../../../core/use_cases/use_case.dart';
import '../repo/order_repo.dart';

class GetFilterAttrUseCase extends UseCaseNoParam<FilterModel> {
  final OrderRepo orderRepo;

  GetFilterAttrUseCase({required this.orderRepo});

  @override
  Future<Either<Failure, FilterModel>> call() {
    return orderRepo.getFilterAttr();
  }
}
