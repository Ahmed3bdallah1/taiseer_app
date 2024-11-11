import 'package:fpdart/fpdart.dart';
import 'package:learning/features/company_features/add_company/data/model/add_company_model.dart';
import '../../../../../core/errors/failure.dart';

abstract class AddCompanyRepo {
  Future<Either<Failure, AddCompanyModel>> getAddCompanyData();

  Future<Either<Failure, bool>> addCompany({required Map map});
}