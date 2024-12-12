import 'package:dio/dio.dart';
import 'package:fpdart/fpdart.dart';
import 'package:tuple/tuple.dart';
import '../../../../../core/errors/failure.dart';
import '../../domain/entity/comment_entity.dart';
import '../../domain/repo/company_repo.dart';
import '../data_source/company_data_source.dart';
import '../model/company_details_model.dart';
import '../model/company_model.dart';
import '../model/company_pagination_model.dart';

class UserCompanyRepoImp extends UserCompanyRepo {
  final UserCompanyDataSource companyDataSource;

  UserCompanyRepoImp({required this.companyDataSource});

  @override
  Future<Either<Failure, CompanyPaginationModel>> getCompanies({Tuple2? param}) async {
    try {
      final res = await companyDataSource.getCompanies(param: param);
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
  Future<Either<Failure, CompanyDetailsModel>> getCompanyDetails({required int id}) async {
    try {
      final res = await companyDataSource.getCompanyDetails(id: id);
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
  Future<Either<Failure, String>> followCompany({required int companyId}) async {
    try {
      final res = await companyDataSource.followCompany(id: companyId);
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
// @override
// Future<Either<Failure, Tuple3<List<UserCompanyModel>, List<CommentsEntity>, List<OrderEntity>>>> searchCompanies({String? search}) async {
//   try {
//     final res = await companyDataSource.searchCompanies(search: search);
//     return Right(res);
//   } catch (e) {
//     if (e is DioException) {
//       return Left(ServerFailure.fromDioError(e));
//     } else {
//       return Left(GeneralError(e));
//     }
//   }
// }
}
