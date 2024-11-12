import 'package:dio/dio.dart';
import 'package:fpdart/fpdart.dart';
import 'package:taiseer/core/errors/failure.dart';

import '../../domain/entities/calender_day_entity.dart';
import '../../domain/repositories/calender_repo.dart';
import '../data_sources/calender_data_source.dart';
import '../models/calender_history_model.dart';

class CalenderRepoImpl extends CalenderRepo {
  final CalenderDataSource dataSource;
  CalenderRepoImpl(this.dataSource);
  @override
  Future<Either<Failure, List<CalenderDayEntity>>> getCalender() async {
    try {
      final res = await dataSource.getCalender();
      return Right(res);
    } catch (e) {
      if (e is DioException) {
        return Left(ServerFailure.fromDioError(e));
      } else {
        return Left(GeneralError(e));
      }
    }
  }

  @override
  Future<Either<Failure, List<CalenderHistoryModel>>> getDayCalenderForOrder(
      int id) async {
    try {
      final res = await dataSource.getDayCalenderForOrder(id);
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
