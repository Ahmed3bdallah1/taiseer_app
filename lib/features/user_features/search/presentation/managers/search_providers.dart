import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reactive_forms/reactive_forms.dart';
import '../../../../../main.dart';
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