import 'package:fpdart/fpdart.dart';
import '../../../../../core/errors/failure.dart';
import '../../../../../core/use_cases/use_case.dart';
import '../repo/order_repo.dart';

class FetchDeleteOrderUseCase extends UseCaseParam<bool, int> {
  final OrderRepo orderRepo;

  FetchDeleteOrderUseCase({required this.orderRepo});

  @override
  Future<Either<Failure, bool>> call(int param) async {
    return orderRepo.deleteOrder(param);
  }
}
