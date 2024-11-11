import 'package:dio/dio.dart';
import 'package:fpdart/fpdart.dart';
import 'package:learning/core/errors/failure.dart';
import 'package:learning/features/user_features/home/data/data_source/loan_details_data_source.dart';
import 'package:learning/features/user_features/home/domain/entities/loan_details_entity.dart';
import '../../domain/repositories/loan_details_repo.dart';

class LoanDetailsRepoImp extends LoanDetailsRepo {
  final LoanDetailsDataSource detailsDataSource;

  LoanDetailsRepoImp({required this.detailsDataSource});

  @override
  Future<Either<Failure, LoanDetailsEntity>> getLoanDetails(int id) async {
    try {
      final res = await detailsDataSource.getLoanDetails(id);
      return Right(LoanDetailsEntity.fromProgram(res));
    } catch (e) {
      if (e is DioException) {
        return Left(ServerFailure.fromDioError(e));
      } else {
        return Left(GeneralError(e));
      }
    }
  }
}
