import 'package:taiseer/core/service/webservice/dio_helper.dart';
import 'package:taiseer/gen/assets.gen.dart';
import '../../../../../config/api_path.dart';
import '../../domain/entities/notification_entity.dart';

abstract class NotificationDataSource {
  Future<List<NotificationModel>> getNotification(Map<String, dynamic> data);
  Future<bool> seen(int id);
}

class NotificationDataSourceImp extends NotificationDataSource {
  final ApiService apiService;

  NotificationDataSourceImp({required this.apiService});

  @override
  Future<List<NotificationModel>> getNotification(
      Map<String, dynamic> data) async {
    // final status = data['status'];
    // final res = await apiService.get(
    //   url: '${ApiPath.notifications}$status',
    // );
    // final List<NotificationModel> list =
    //     (res as List).map((e) => NotificationModel.fromJson(e)).toList();
    await Future.delayed(const Duration(seconds: 2));
    return generateDummyNotificationList(10);
  }

  @override
  Future<bool> seen(int id) async {
    await apiService.get(
      url: '${ApiPath.seen}/$id',
    );
    return true;
  }
}

List<NotificationModel> generateDummyNotificationList(int count) {
  List<NotificationModel> dummyList = [];

  for (int i = 1; i <= count; i++) {
    dummyList.add(NotificationModel(
      id: i,
      customerId: i + 100,
      title: 'Shipment $i',
      logo: Assets.base.fingerScan,
      description: 'Description $i',
      type: 'Type $i',
      seen: i % 2,
      related: i + 200,
      createdAt: '2024-12-16',
      updatedAt: '2024-12-16',
    ));
  }

  return dummyList;
}
