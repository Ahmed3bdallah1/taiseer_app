import 'package:taiseer/core/service/webservice/dio_helper.dart';
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
    final status = data['status'];
    final res = await apiService.get(
      url: '${ApiPath.notifications}$status',
    );
    final List<NotificationModel> list =
        (res as List).map((e) => NotificationModel.fromJson(e)).toList();
    return list;
  }

  @override
  Future<bool> seen(int id) async {
    await apiService.get(
      url: '${ApiPath.seen}/$id',
    );
    return true;
  }
}
