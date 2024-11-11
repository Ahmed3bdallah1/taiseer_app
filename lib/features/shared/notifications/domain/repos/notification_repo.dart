import 'package:fpdart/fpdart.dart';
import '../../../../../core/errors/failure.dart';
import '../entities/notification_entity.dart';

abstract class NotificationRepo {
  Future<Either<Failure, List<NotificationEntity>>> getNotifications(
      Map<String, dynamic> data);
  Future<Either<Failure, bool>> seen(int id);
}
