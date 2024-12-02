import 'package:taiseer/features/user_features/shipments/data/models/shipment_model.dart';
import '../../../../../config/api_path.dart';
import '../../../../../core/service/webservice/dio_helper.dart';

abstract class ShipmentDataSource {
  Future<ShipmentModel> getLastShipment();
  Future<bool> submitShipment(Map<String, dynamic> data);
  Future<ShipmentPaginationModel> getShipment({int? param});
  Future<bool> submitRate(Map<String, dynamic> data);
}

class ShipmentDataSourceImp extends ShipmentDataSource {
  final ApiService apiService;

  ShipmentDataSourceImp(this.apiService);

  @override
  Future<ShipmentPaginationModel> getShipment({int? param}) async {
    final res = await apiService.get(url: "${ApiPath.getShipments}?page=$param", returnDataOnly: false);
    ShipmentPaginationModel shipment = ShipmentPaginationModel.fromJson(res["shipments"]);
    return shipment;
  }

  @override
  Future<ShipmentModel> getLastShipment() async {
    final res = await apiService.get(url: "${ApiPath.getShipments}?page=1", returnDataOnly: false);
    ShipmentPaginationModel shipment = ShipmentPaginationModel.fromJson(res["shipments"]);
    if (shipment.lastPage != 1) {
      final res = await apiService.get(url: "${ApiPath.getShipments}?page=${shipment.lastPage}", returnDataOnly: false);
      ShipmentPaginationModel shipment2 = ShipmentPaginationModel.fromJson(res["shipments"]);
      return shipment2.data.last;
    } else {
      return shipment.data.last;
    }
  }

  @override
  Future<bool> submitShipment(Map<String, dynamic> data) async {
    await apiService.post(url: ApiPath.submitShipment, returnDataOnly: false,requestBody: data);
    return true;
  }

  @override
  Future<bool> submitRate(Map<String, dynamic> data) async {
    await apiService.post(url: ApiPath.submitRating, returnDataOnly: false,requestBody: data);
    return true;
  }
}
