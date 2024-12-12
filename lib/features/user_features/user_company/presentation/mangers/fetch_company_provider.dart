import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:taiseer/features/user_features/home/presentation/view/widgets/company_home_view.dart';
import 'package:taiseer/features/user_features/user_company/data/model/company_details_model.dart';
import 'package:taiseer/features/user_features/user_company/presentation/mangers/search_filter_provider.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:tuple/tuple.dart';
import '../../../../../main.dart';
import '../../data/model/company_model.dart';
import '../../data/model/company_pagination_model.dart';
import '../../domain/entity/comment_entity.dart';
import '../../domain/use_case/company_use_case.dart';

final fetchUserCompaniesViewProvider =
    FutureProvider.autoDispose.family<CompanyPaginationModel,int?>((ref,id) async {
  final attribute = ref.watch(filterProvider);
  print(attribute.name);
  final companies = await getIt<FetchUserCompanyUseCase>().call(Tuple2(attribute.name,id??1));

  return companies.fold((l) {
    throw l;
  }, (r) {
    return r;
  });
});

final fetchUserCompanyDetailsViewProvider =
    FutureProvider.autoDispose.family<CompanyDetailsModel,int>((ref,id) async {
  final companyDetails = await getIt<FetchUserCompanyDetailsUseCase>().call(id);

  return companyDetails.fold((l) {
    throw l;
  }, (r) {
    return r;
  });
});
