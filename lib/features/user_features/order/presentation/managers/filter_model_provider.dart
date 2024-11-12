import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:taiseer/features/user_features/order/domain/use_case/get_filter_attr_use_case.dart';
import 'package:taiseer/models/program_model.dart';
import '../../../../../main.dart';

final fetchFilterModelProvider = FutureProvider<FilterModel>((ref) async {
  final filter = await getIt<GetFilterAttrUseCase>()();
  return filter.fold((l) {
    throw l;
  }, (r) {
    return r;
  });
});
