import 'package:fpdart/fpdart.dart';
import 'package:taiseer/features/user_features/user_company/data/model/company_details_model.dart';
import 'package:tuple/tuple.dart';
import '../../../../../core/errors/failure.dart';
import '../../../../../core/use_cases/use_case.dart';
import '../../data/model/company_model.dart';
import '../../data/model/company_pagination_model.dart';
import '../entity/comment_entity.dart';
import '../repo/company_repo.dart';

class FetchUserCompanyUseCase
    extends UseCaseParam<CompanyPaginationModel, Tuple2<String,int>> {
  final UserCompanyRepo companyRepo;

  FetchUserCompanyUseCase({required this.companyRepo});

  @override
  Future<Either<Failure, CompanyPaginationModel>> call(Tuple2 param) async {
    final res = await companyRepo.getCompanies(param: param);
    return res;
  }
}

class FetchUserCompanyDetailsUseCase extends UseCaseParam<CompanyDetailsModel, int> {
  final UserCompanyRepo companyRepo;

  FetchUserCompanyDetailsUseCase({required this.companyRepo});

  @override
  Future<Either<Failure, CompanyDetailsModel>> call(int param) async {
    final res = await companyRepo.getCompanyDetails(id: param);
    return res;
  }
}

class FetchSearchUseCase extends UseCaseParam<List<dynamic>, String?> {
  final UserCompanyRepo companyRepo;

  FetchSearchUseCase({required this.companyRepo});

  @override
  Future<Either<Failure, List<dynamic>>> call(param) async {
    final res = await companyRepo.searchCompanies2(search: param);
    return res;
  }
}

class FollowCompanyUseCase extends UseCaseParam<String, int> {
  final UserCompanyRepo companyRepo;

  FollowCompanyUseCase({required this.companyRepo});

  @override
  Future<Either<Failure, String>> call(int param) async {
    final res = await companyRepo.followCompany(companyId: param);
    return res;
  }
}

// class FetchSearchCompanyUseCase
//     extends UseCaseParam<Tuple3<List<UserCompanyModel2>, List<CommentsEntity>, List<OrderEntity>>, String?> {
//   final UserCompanyRepo companyRepo;
//
//   FetchSearchCompanyUseCase({required this.companyRepo});
//
//   @override
//   Future<Either<Failure, Tuple3<List<UserCompanyModel2>, List<CommentsEntity>, List<OrderEntity>>>> call(param) async {
//     final res = await companyRepo.searchCompanies(search: param);
//     print(res);
//     return res;
//   }
// }
