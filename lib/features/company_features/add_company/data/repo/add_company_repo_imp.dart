import 'package:dio/dio.dart';
import 'package:fpdart/fpdart.dart';
import 'package:learning/features/company_features/add_company/data/model/add_company_model.dart';

import '../../../../../core/errors/failure.dart';
import '../../domain/repo/add_company_repo.dart';
import '../data_source/add_company_data_source.dart';

class AddCompanyRepoImp extends AddCompanyRepo {
  final AddCompanyDataSource addCompanyDataSource;

  AddCompanyRepoImp({required this.addCompanyDataSource});

  @override
  Future<Either<Failure, AddCompanyModel>> getAddCompanyData() async {
    try {
      final res = await addCompanyDataSource.getAddCompanyData();
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
  Future<Either<Failure, bool>> addCompany({required Map map}) async {
    try {
      final res = await addCompanyDataSource.addCompany(map: map);
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