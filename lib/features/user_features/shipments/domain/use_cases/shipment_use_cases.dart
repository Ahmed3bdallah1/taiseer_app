import 'package:fpdart/fpdart.dart';
import 'package:taiseer/core/errors/failure.dart';
import 'package:taiseer/features/user_features/shipments/data/models/shipment_model.dart';
import 'package:taiseer/features/user_features/shipments/domain/repo/shipment_repo.dart';
import 'package:tuple/tuple.dart';
import '../../../../../core/use_cases/use_case.dart';

class FetchShipmentsUseCase extends UseCaseParam<ShipmentPaginationModel, Tuple2<int,String>> {
  final ShipmentRepo shipmentRepo;

  FetchShipmentsUseCase({required this.shipmentRepo});

  @override
  Future<Either<Failure, ShipmentPaginationModel>> call(Tuple2<int,String> param) {
    return shipmentRepo.getShipments(page: param);
  }
}

class FetchLastShipmentUseCase extends UseCaseNoParam<ShipmentModel> {
  final ShipmentRepo shipmentRepo;

  FetchLastShipmentUseCase({required this.shipmentRepo});

  @override
  Future<Either<Failure, ShipmentModel>> call() async {
    return shipmentRepo.getLastShipment();
  }
}

class SubmitShipmentUseCase extends UseCaseParam<bool, Map<String, dynamic>> {
  final ShipmentRepo shipmentRepo;

  SubmitShipmentUseCase({required this.shipmentRepo});

  @override
  Future<Either<Failure, bool>> call(Map<String, dynamic> param) {
    return shipmentRepo.submitShipment(data: param);
  }
}

class SubmitRateUseCase extends UseCaseParam<bool, Map<String, dynamic>> {
  final ShipmentRepo shipmentRepo;

  SubmitRateUseCase({required this.shipmentRepo});

  @override
  Future<Either<Failure, bool>> call(Map<String, dynamic> param) {
    return shipmentRepo.submitRate(data: param);
  }
}
