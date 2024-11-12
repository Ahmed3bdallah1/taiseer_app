import 'package:fpdart/fpdart.dart';
import 'package:taiseer/core/errors/failure.dart';
import 'package:taiseer/features/user_features/home/domain/entities/loan_details_entity.dart';
import 'package:taiseer/features/user_features/home/domain/repositories/loan_details_repo.dart';

import '../../../../../core/use_cases/use_case.dart';

class FetchLoanDetailsUseCase extends UseCaseParam<LoanDetailsEntity, int> {
  final LoanDetailsRepo loanDetailsRepo;

  FetchLoanDetailsUseCase({required this.loanDetailsRepo});

  @override
  Future<Either<Failure, LoanDetailsEntity>> call(int param) async {
    return loanDetailsRepo.getLoanDetails(param);
  }
}
