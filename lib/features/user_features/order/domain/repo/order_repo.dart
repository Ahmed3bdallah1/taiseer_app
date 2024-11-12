import 'package:fpdart/fpdart.dart';
import 'package:taiseer/features/user_features/order/domain/entity/order_entity.dart';
import 'package:taiseer/models/program_model.dart';
import '../../../../../core/errors/failure.dart';

abstract class OrderRepo {
  Future<Either<Failure, OrderEntity>> getLastOrder();
  Future<Either<Failure, bool>> submitOrder(Map<String, dynamic> data);
  Future<Either<Failure, FilterModel>> getFilterAttr();
  Future<Either<Failure, List<OrderEntity>>> getOrderHistory(
      Map<String, dynamic> data);
  Future<Either<Failure, bool>> deleteOrder(int id);
}
