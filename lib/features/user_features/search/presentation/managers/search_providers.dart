import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:tuple/tuple.dart';
import '../../../../../main.dart';
import '../../../order/domain/entity/order_entity.dart';
import '../../../user_company/data/model/company_model.dart';
import '../../../user_company/domain/entity/comment_entity.dart';
import '../../../user_company/domain/use_case/company_use_case.dart';

// final fetchSearchUserCompanyProvider = FutureProvider.autoDispose
//     .family<Tuple3<List<UserCompanyModel>, List<CommentsEntity>, List<OrderEntity>>, FormControl>((ref, search) async {
//   final loans = await getIt<FetchSearchCompanyUseCase>().call(search.value);
//
//   return loans.fold((l) {
//     throw l;
//   }, (r) {
//     return r;
//   });
// });

final fetchUserSearchProvider = FutureProvider.autoDispose.family<List<dynamic>, FormControl>((ref, search) async {
  final loans = await getIt<FetchSearchUseCase>().call(search.value);

  return loans.fold((l) {
    throw l;
  }, (r) {
    return r;
  });
});