import 'package:fpdart/fpdart.dart';
import 'package:taiseer/features/user_features/home/domain/entities/loan_details_entity.dart';
import 'package:taiseer/features/user_features/home/domain/repositories/loan_repo.dart';

import '../../../../../core/errors/failure.dart';
import '../../../../../core/use_cases/use_case.dart';

class FetchLoanUseCase extends UseCaseNoParam<List<LoanDetailsEntity>> {
  final LoanRepo loanRepo;

  FetchLoanUseCase({required this.loanRepo});

  @override
  Future<Either<Failure, List<LoanDetailsEntity>>> call([void param]) async {
    final res = await loanRepo.getLoans();
    return res;
  }
}
