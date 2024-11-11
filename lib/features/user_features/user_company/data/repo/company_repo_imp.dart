import 'package:dio/dio.dart';
import 'package:fpdart/fpdart.dart';
import 'package:tuple/tuple.dart';
import '../../../../../core/errors/failure.dart';
import '../../../order/domain/entity/order_entity.dart';
import '../../domain/entity/comment_entity.dart';
import '../../domain/repo/company_repo.dart';
import '../data_source/company_data_source.dart';
import '../model/company_model.dart';

class UserCompanyRepoImp extends UserCompanyRepo {
  final UserCompanyDataSource companyDataSource;

  UserCompanyRepoImp({required this.companyDataSource});

  @override
  Future<Either<Failure, List<UserCompanyModel>>> getCompanies({Map? map}) async {
    try {
      final res = await companyDataSource.getCompanies(map: map);
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
  Future<Either<Failure, Tuple3<List<UserCompanyModel>, List<CommentsEntity>, List<OrderEntity>>>> searchCompanies({String? search}) async {
    try {
      final res = await companyDataSource.searchCompanies(search: search);
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
  Future<Either<Failure, List<dynamic>>> searchCompanies2({String? search}) async {
    try {
      final res = await companyDataSource.searchCompanies2(search: search);
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
