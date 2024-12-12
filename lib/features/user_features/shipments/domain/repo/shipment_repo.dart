import 'package:fpdart/fpdart.dart';
import 'package:taiseer/features/user_features/shipments/data/models/shipment_model.dart';
import 'package:tuple/tuple.dart';
import '../../../../../core/errors/failure.dart';

abstract class ShipmentRepo {
  Future<Either<Failure, ShipmentModel>> getLastShipment();
  Future<Either<Failure, ShipmentPaginationModel>> getShipments({required Tuple2<int,String> page});
  Future<Either<Failure, bool>> submitShipment({required Map<String,dynamic> data});
  Future<Either<Failure, bool>> submitRate({required Map<String,dynamic> data});
}
