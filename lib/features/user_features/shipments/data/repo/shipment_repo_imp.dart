import 'package:dio/dio.dart';
import 'package:fpdart/fpdart.dart';
import 'package:taiseer/core/errors/failure.dart';
import 'package:taiseer/features/user_features/shipments/data/data_source/shipment_data_source.dart';
import 'package:taiseer/features/user_features/shipments/data/models/shipment_model.dart';
import 'package:taiseer/features/user_features/shipments/domain/repo/shipment_repo.dart';
import 'package:tuple/tuple.dart';

class ShipmentRepoImp extends ShipmentRepo {
  final ShipmentDataSource shipmentDataSource;

  ShipmentRepoImp({required this.shipmentDataSource});

  @override
  Future<Either<Failure, ShipmentModel>> getLastShipment() async {
    try {
      final response = await shipmentDataSource.getLastShipment();
      return Right(response);
    } catch (e) {
      if (e is DioException) {
        return Left(ServerFailure.fromDioError(e));
      } else {
        return Left(GeneralError(e));
      }
    }
  }

  @override
  Future<Either<Failure, ShipmentPaginationModel>> getShipments(
      {required Tuple2<int,String> page}) async {
    try {
      final response = await shipmentDataSource.getShipment(param: page);
      return Right(response);
    } catch (e) {
      if (e is DioException) {
        return Left(ServerFailure.fromDioError(e));
      } else {
        return Left(GeneralError(e));
      }
    }
  }

  @override
  Future<Either<Failure, bool>> submitShipment({required Map<String, dynamic> data}) async {
    try {
      final response = await shipmentDataSource.submitShipment(data);
      return Right(response);
    } catch (e) {
      if (e is DioException) {
        return Left(ServerFailure.fromDioError(e));
      } else {
        return Left(GeneralError(e));
      }
    }
  }

  @override
  Future<Either<Failure, bool>> submitRate({required Map<String, dynamic> data}) async {
    try {
      final response = await shipmentDataSource.submitRate(data);
      return Right(response);
    } catch (e) {
      if (e is DioException) {
        return Left(ServerFailure.fromDioError(e));
      } else {
        return Left(GeneralError(e));
      }
    }
  }
}
