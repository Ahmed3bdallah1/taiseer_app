import 'package:fpdart/fpdart.dart';
import 'package:tuple/tuple.dart';
import '../../../../../core/errors/failure.dart';
import '../../../order/domain/entity/order_entity.dart';
import '../../data/model/company_model.dart';
import '../entity/comment_entity.dart';

abstract class UserCompanyRepo {
  Future<Either<Failure, List<UserCompanyModel>>> getCompanies({Map? map});

  Future<Either<Failure, Tuple3<List<UserCompanyModel>, List<CommentsEntity>, List<OrderEntity>>>> searchCompanies({String? search});

  Future<Either<Failure, List<dynamic>>> searchCompanies2({String? search});
}
