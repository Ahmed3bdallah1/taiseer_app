import 'package:fpdart/fpdart.dart';
import 'package:taiseer/features/user_features/user_company/data/model/company_details_model.dart';
import 'package:tuple/tuple.dart';
import '../../../../../core/errors/failure.dart';
import '../../data/model/company_model.dart';
import '../../data/model/company_pagination_model.dart';
import '../entity/comment_entity.dart';

abstract class UserCompanyRepo {
  Future<Either<Failure, CompanyPaginationModel>> getCompanies({Tuple2? param});

  Future<Either<Failure, CompanyDetailsModel>> getCompanyDetails({required int id});

  Future<Either<Failure, String>> followCompany({required int companyId});

  Future<Either<Failure, List<dynamic>>> searchCompanies2({String? search});

// Future<Either<Failure, Tuple3<List<UserCompanyModel2>, List<CommentsEntity>, List<OrderEntity>>>> searchCompanies({String? search});
}
