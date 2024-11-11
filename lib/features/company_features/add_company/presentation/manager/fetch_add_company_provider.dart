import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:learning/features/company_features/add_company/data/model/add_company_model.dart';
import 'package:learning/features/company_features/add_company/domain/use_case/add_company_use_case.dart';
import 'package:learning/main.dart';

final fetchAddCompanyProvider = FutureProvider<AddCompanyModel>((ref) async {
  final loans = await getIt<FetchAddCompanyUseCase>().call();

  return loans.fold((l) {
    throw l;
  }, (r) {
    return r;
  });
});
