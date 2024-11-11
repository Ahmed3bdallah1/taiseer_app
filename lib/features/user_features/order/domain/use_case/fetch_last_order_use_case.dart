import 'package:fpdart/fpdart.dart';
import 'package:learning/core/use_cases/use_case.dart';
import 'package:learning/features/user_features/order/domain/entity/order_entity.dart';
import '../../../../../core/errors/failure.dart';
import '../repo/order_repo.dart';

class FetchLastOrderUseCase extends UseCaseNoParam<OrderEntity> {
  final OrderRepo orderRepo;

  FetchLastOrderUseCase({required this.orderRepo});

  @override
  Future<Either<Failure, OrderEntity>> call() async {
    return orderRepo.getLastOrder();
  }
}
