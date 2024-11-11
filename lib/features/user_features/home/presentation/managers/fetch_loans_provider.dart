import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:learning/features/user_features/home/domain/entities/loan_details_entity.dart';
import 'package:learning/features/user_features/home/domain/use_case/fetch_loan_details_use_case.dart';
import 'package:learning/main.dart';
import '../../domain/use_case/fetch_loan_use_case.dart';

final fetchLoanProvider =
    FutureProvider.family<List<LoanDetailsEntity>, dynamic>((ref, _) async {
  final loans = await getIt<FetchLoanUseCase>().call();

  return loans.fold((l) {
    throw l;
  }, (r) {
    return r;
  });
});

final fetchLoanDetailsProvider =
    FutureProvider.family.autoDispose<LoanDetailsEntity, int>((ref, id) async {
  final loans = await getIt<FetchLoanDetailsUseCase>().call(id);

  return loans.fold((l) {
    throw l;
  }, (r) {
    return r;
  });
});
