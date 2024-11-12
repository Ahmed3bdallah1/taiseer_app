import 'package:fpdart/fpdart.dart';
import 'package:taiseer/features/shared/notifications/domain/repos/notification_repo.dart';
import '../../../../../core/errors/failure.dart';
import '../../../../../core/use_cases/use_case.dart';
import '../entities/notification_entity.dart';

class FetchNotificationUseCase
    extends UseCaseParam<List<NotificationEntity>, Map<String, dynamic>> {
  final NotificationRepo notificationRepo;

  FetchNotificationUseCase({required this.notificationRepo});

  @override
  Future<Either<Failure, List<NotificationEntity>>> call(
      Map<String, dynamic> param) async {
    final res = await notificationRepo.getNotifications(param);
    return res;
  }
}
