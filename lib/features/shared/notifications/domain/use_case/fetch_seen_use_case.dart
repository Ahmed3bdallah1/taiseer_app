import 'package:fpdart/fpdart.dart';
import '../../../../../core/errors/failure.dart';
import '../../../../../core/use_cases/use_case.dart';
import '../repos/notification_repo.dart';

class SeenNotificationUseCase extends UseCaseParam<bool, int> {
  final NotificationRepo notificationRepo;

  SeenNotificationUseCase({required this.notificationRepo});

  @override
  Future<Either<Failure, bool>> call(param) async {
    final res = await notificationRepo.seen(param);
    return res;
  }
}
