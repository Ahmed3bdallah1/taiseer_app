import 'package:dio/dio.dart';
import 'package:fpdart/fpdart.dart';
import 'package:taiseer/core/errors/failure.dart';
import 'package:taiseer/features/user_features/home/data/data_source/loan_data_source.dart';
import 'package:taiseer/features/user_features/home/domain/entities/loan_details_entity.dart';
import '../../domain/repositories/loan_repo.dart';

class LoanRepoImp extends LoanRepo {
  final LoanDataSource loanDataSource;

  LoanRepoImp({required this.loanDataSource});

  @override
  Future<Either<Failure, List<LoanDetailsEntity>>> getLoans() async {
    try {
      final res = await loanDataSource.getLoans();
      return Right(
          res.map((ele) => LoanDetailsEntity.fromProgram(ele)).toList());
    } catch (e) {
      if (e is DioException) {
        return Left(ServerFailure.fromDioError(e));
      } else {
        return Left(GeneralError(e));
      }
    }
  }
}
