import 'package:dio/dio.dart';
import 'package:fpdart/fpdart.dart';
import 'package:learning/features/user_features/order/domain/entity/order_entity.dart';
import 'package:learning/models/program_model.dart';
import '../../../../../core/errors/failure.dart';
import '../../domain/repo/order_repo.dart';
import '../data_source/order_data_source.dart';

class OrderRepoImp extends OrderRepo {
  final OrderDataSource orderDataSource;

  OrderRepoImp({required this.orderDataSource});

  @override
  Future<Either<Failure, OrderEntity>> getLastOrder() async {
    try {
      final res = await orderDataSource.getLastOrder();
      return Right(OrderEntity.fromOrderModel(res));
    } catch (e) {
      if (e is DioException) {
        return Left(ServerFailure.fromDioError(e));
      } else {
        return Left(GeneralError(e));
      }
    }
  }

  @override
  Future<Either<Failure, bool>> submitOrder(Map<String, dynamic> data) async {
    try {
      final res = await orderDataSource.submitOrder(data);
      return Right(res);
    } catch (e) {
      if (e is DioException) {
        return Left(ServerFailure.fromDioError(e));
      } else {
        return Left(GeneralError(e));
      }
    }
  }

  @override
  Future<Either<Failure, List<OrderEntity>>> getOrderHistory(
      Map<String, dynamic> data) async {
    try {
      final res = await orderDataSource.getOrderHistory(data);
      return Right(
          (res as List).map((e) => OrderEntity.fromOrderModel(e)).toList());
    } catch (e) {
      if (e is DioException) {
        return Left(ServerFailure.fromDioError(e));
      } else {
        return Left(GeneralError(e));
      }
    }
  }

  @override
  Future<Either<Failure, FilterModel>> getFilterAttr() async {
    try {
      final res = await orderDataSource.getFilterAttr();
      return Right(res);
    } catch (e) {
      if (e is DioException) {
        return Left(ServerFailure.fromDioError(e));
      } else {
        return Left(GeneralError(e));
      }
    }
  }

  @override
  Future<Either<Failure, bool>> deleteOrder(int id) async {
    try {
      final res = await orderDataSource.deleteOrder(id);
      return Right(res);
    } catch (e) {
      if (e is DioException) {
        return Left(ServerFailure.fromDioError(e));
      } else {
        return Left(GeneralError(e));
      }
    }
  }
}
