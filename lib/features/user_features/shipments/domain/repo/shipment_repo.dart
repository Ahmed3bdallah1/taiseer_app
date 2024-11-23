import 'package:fpdart/fpdart.dart';
import 'package:taiseer/features/user_features/shipments/data/models/shipment_model.dart';
import '../../../../../core/errors/failure.dart';

abstract class ShipmentRepo {
  Future<Either<Failure, ShipmentModel>> getLastShipment();
  Future<Either<Failure, ShipmentPaginationModel>> getShipments({required int page});
  Future<Either<Failure, bool>> submitShipment({required Map<String,dynamic> data});
}
