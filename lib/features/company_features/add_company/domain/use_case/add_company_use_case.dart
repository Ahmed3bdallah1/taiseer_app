import 'package:fpdart/fpdart.dart';
import 'package:taiseer/features/company_features/add_company/data/model/add_company_model.dart';

import '../../../../../core/errors/failure.dart';
import '../../../../../core/use_cases/use_case.dart';
import '../repo/add_company_repo.dart';

class FetchAddCompanyUseCase extends UseCaseNoParam<AddCompanyModel> {
  final AddCompanyRepo addCompanyRepo;

  FetchAddCompanyUseCase({required this.addCompanyRepo});

  @override
  Future<Either<Failure, AddCompanyModel>> call([void param]) async {
    final res = await addCompanyRepo.getAddCompanyData();
    return res;
  }
}

class AddCompanyUseCase extends UseCaseParam<bool, Map> {
  final AddCompanyRepo addCompanyRepo;

  AddCompanyUseCase({required this.addCompanyRepo});

  @override
  Future<Either<Failure, bool>> call(param) async {
    final res = await addCompanyRepo.addCompany(map: param);
    return res;
  }
}
