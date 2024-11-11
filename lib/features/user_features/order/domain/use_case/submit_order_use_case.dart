import 'package:fpdart/fpdart.dart';

import '../../../../../core/errors/failure.dart';
import '../../../../../core/use_cases/use_case.dart';
import '../repo/order_repo.dart';

class SubmitOrderUseCase extends UseCaseParam<bool, Map<String, dynamic>> {
  final OrderRepo orderRepo;

  SubmitOrderUseCase({required this.orderRepo});

  @override
  Future<Either<Failure, bool>> call(Map<String, dynamic> param) {
    return orderRepo.submitOrder(param);
  }
}
