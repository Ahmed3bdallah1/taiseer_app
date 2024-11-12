import 'package:fpdart/fpdart.dart';
import 'package:taiseer/features/user_features/home/domain/entities/loan_details_entity.dart';

import '../../../../../core/errors/failure.dart';

abstract class LoanDetailsRepo {
  Future<Either<Failure, LoanDetailsEntity>> getLoanDetails(int id);
}
