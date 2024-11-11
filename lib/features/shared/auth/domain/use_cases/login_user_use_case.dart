import 'package:fpdart/fpdart.dart';
import '../../../../../core/errors/failure.dart';
import '../../../../../core/use_cases/use_case.dart';
import '../../../../../models/user_model.dart';
import '../entities/auth_entity.dart';
import '../repositories/auth_repo.dart';

class LoginUserUseCase
    extends UseCaseParam<UserAuthResponseModel, Map<String, dynamic>> {
  final AuthRepo authRepo;

  LoginUserUseCase(this.authRepo);

  @override
  Future<Either<Failure, UserAuthResponseModel>> call(
      Map<String, dynamic> param) {
    return authRepo.login(param);
  }
}

class FetchCountriesUseCase extends UseCaseNoParam<List<CountryEntity>> {
  final AuthRepo authRepo;

  FetchCountriesUseCase(this.authRepo);

  @override
  Future<Either<Failure, List<CountryEntity>>> call() {
    return authRepo.getCountries();
  }
}
