import 'package:fpdart/fpdart.dart';
import '../../../../../core/errors/failure.dart';
import '../../../../../models/user_model.dart';
import '../entities/auth_entity.dart';

abstract class AuthRepo {
  Future<Either<Failure, UserAuthResponseModel>> login(
      Map<String, dynamic> data);

  Future<Either<Failure, UserAuthResponseModel>> register(
      Map<String, dynamic> data);
  Future<Either<Failure, UserModel>> getMyProfile();
  Future<Either<Failure, List<CountryEntity>>> getCountries();
}
