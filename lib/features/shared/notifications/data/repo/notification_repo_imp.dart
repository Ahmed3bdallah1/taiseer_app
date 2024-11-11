import 'package:dio/dio.dart';
import 'package:fpdart/fpdart.dart';
import '../../../../../core/errors/failure.dart';
import '../../domain/entities/notification_entity.dart';
import '../../domain/repos/notification_repo.dart';
import '../data_source/notification_data_source.dart';

class NotificationRepoImp extends NotificationRepo {
  final NotificationDataSource notificationDataSource;

  NotificationRepoImp({required this.notificationDataSource});

  @override
  Future<Either<Failure, List<NotificationEntity>>> getNotifications(
      Map<String, dynamic> data) async {
    try {
      final res = await notificationDataSource.getNotification(data);
      return Right(res
          .map((json) => NotificationEntity.fromNotificationModel(json))
          .toList());
    } catch (e) {
      if (e is DioException) {
        return Left(ServerFailure.fromDioError(e));
      } else {
        return Left(GeneralError(e));
      }
    }
  }

  @override
  Future<Either<Failure, bool>> seen(int id) async {
    try {
      final res = await notificationDataSource.seen(id);
      return Right(res);
    } catch (e) {
      if (e is DioException) {
        return Left(ServerFailure.fromDioError(e));
      } else {
        return Left(GeneralError(e));
      }
    }
  }
}
