import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:taiseer/features/user_features/home/presentation/view/widgets/company_home_view.dart';
import 'package:taiseer/features/user_features/user_company/presentation/mangers/search_filter_provider.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:tuple/tuple.dart';

import '../../../../../main.dart';
import '../../../order/domain/entity/order_entity.dart';
import '../../data/model/company_model.dart';
import '../../domain/entity/comment_entity.dart';
import '../../domain/use_case/company_use_case.dart';

final fetchUserCompaniesViewProvider =
    FutureProvider.autoDispose<List<UserCompanyModel2>>((ref) async {
  final attribute = ref.watch(filterProvider);
  final companies = await getIt<FetchUserCompanyUseCase>().call(attribute.name);

  return companies.fold((l) {
    throw l;
  }, (r) {
    return r;
  });
});
