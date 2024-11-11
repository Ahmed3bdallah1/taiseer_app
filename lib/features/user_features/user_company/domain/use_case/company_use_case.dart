import 'package:fpdart/fpdart.dart';
import 'package:tuple/tuple.dart';
import '../../../../../core/errors/failure.dart';
import '../../../../../core/use_cases/use_case.dart';
import '../../../order/domain/entity/order_entity.dart';
import '../../data/model/company_model.dart';
import '../entity/comment_entity.dart';
import '../repo/company_repo.dart';

class FetchUserCompanyUseCase
    extends UseCaseParam<List<UserCompanyModel>, String> {
  final UserCompanyRepo companyRepo;

  FetchUserCompanyUseCase({required this.companyRepo});

  @override
  Future<Either<Failure, List<UserCompanyModel>>> call(
      String param) async {
    final res = await companyRepo.getCompanies();
    return res;
  }
}

class FetchSearchCompanyUseCase
    extends UseCaseParam<Tuple3<List<UserCompanyModel>, List<CommentsEntity>, List<OrderEntity>>, String?> {
  final UserCompanyRepo companyRepo;

  FetchSearchCompanyUseCase({required this.companyRepo});

  @override
  Future<Either<Failure, Tuple3<List<UserCompanyModel>, List<CommentsEntity>, List<OrderEntity>>>> call(param) async {
    final res = await companyRepo.searchCompanies(search: param);
    print(res);
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
