import 'package:learning/core/service/webservice/dio_helper.dart';

import '../../../../../config/api_path.dart';
import '../../../../../models/program_model.dart';

abstract class OrderDataSource {
  Future<OrderModel> getLastOrder();

  Future<bool> submitOrder(Map<String, dynamic> data);

  Future<List<OrderModel>> getOrderHistory(Map<String, dynamic> data);

  Future<FilterModel> getFilterAttr();

  Future<bool> deleteOrder(int id);
}

class OrderDataSourceImp extends OrderDataSource {
  final ApiService apiService;

  OrderDataSourceImp(this.apiService);

  @override
  Future<OrderModel> getLastOrder() async {
    final res = await apiService.get(url: ApiPath.lastOrder);
    return OrderModel.fromJson(res);
  }

  @override
  Future<bool> submitOrder(Map<String, dynamic> data) async {
    final res =
        await apiService.post(url: ApiPath.storeOrder, requestBody: data);
    return res;
  }

  @override
  Future<List<OrderModel>> getOrderHistory(Map<String, dynamic> data) async {
    final res =
        await apiService.post(url: ApiPath.allOrders, requestBody: data);
    return (res as List).map((e) => OrderModel.fromJson(e)).toList();
  }

  @override
  Future<FilterModel> getFilterAttr() async {
    final res = await apiService.get(url: ApiPath.filter);
    return FilterModel.fromJson(res);
  }

  @override
  Future<bool> deleteOrder(int id) async {
    await apiService.get(url: "${ApiPath.deleteOrder}/$id");
    return true;
  }
}
