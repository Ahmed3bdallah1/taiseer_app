import 'package:dio/dio.dart';
import 'package:fpdart/fpdart.dart';
import '../../../../../core/errors/failure.dart';
import '../../../../../models/user_model.dart';
import '../../domain/entities/auth_entity.dart';
import '../../domain/repositories/auth_repo.dart';
import '../data_sources/auth_data_source.dart';

class AuthRepoImpl extends AuthRepo {
  final AuthDataSource dataSource;

  AuthRepoImpl(this.dataSource);

  @override
  Future<Either<Failure, UserAuthResponseModel>> login(
      Map<String, dynamic> data) async {
    try {
      final res = await dataSource.login(data);
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
  Future<Either<Failure, UserAuthResponseModel>> register(
      Map<String, dynamic> data) async {
    try {
      final res = await dataSource.register(data);
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
  Future<Either<Failure, UserModel>> getMyProfile() async {
    try {
      final res = await dataSource.getMyProfile();
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
  Future<Either<Failure, List<CountryEntity>>> getCountries() async {
    try {
      final res = await dataSource.getCountries();
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
