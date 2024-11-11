import 'package:fpdart/fpdart.dart';
import 'package:learning/core/use_cases/use_case.dart';
import 'package:learning/features/user_features/order/domain/entity/order_entity.dart';
import '../../../../../core/errors/failure.dart';
import '../repo/order_repo.dart';

class FetchOrderHistoryUseCase
    extends UseCaseParam<List<OrderEntity>, Map<String, dynamic>> {
  final OrderRepo orderRepo;

  FetchOrderHistoryUseCase({required this.orderRepo});

  @override
  Future<Either<Failure, List<OrderEntity>>> call(
      Map<String, dynamic> param) async {
    return orderRepo.getOrderHistory(param);
  }
}
