import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:learning/features/user_features/support/domain/use_case/fetch_support_use_case.dart';
import '../../../../../main.dart';
import '../../domain/entites/support_entity.dart';

final fetchSupportProvider =
    FutureProvider.autoDispose<SupportEntity>((ref) async {
  final support = await getIt<FetchSupportUseCase>().call();

  return support.fold((l) {
    throw l;
  }, (r) {
    return r;
  });
});
