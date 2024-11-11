import 'package:dio/dio.dart';
import 'package:fpdart/fpdart.dart';
import 'package:learning/core/errors/failure.dart';
import 'package:learning/features/user_features/support/domain/repo/support_repo.dart';
import '../../domain/entites/support_entity.dart';
import '../data_source/support_data_source.dart';

class SupportRepoImp extends SupportRepo {
  final SupportDataSource supportDataSource;

  SupportRepoImp({required this.supportDataSource});

  @override
  Future<Either<Failure, SupportEntity>> getSupport() async {
    try {
      final res = await supportDataSource.getSupport();
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
