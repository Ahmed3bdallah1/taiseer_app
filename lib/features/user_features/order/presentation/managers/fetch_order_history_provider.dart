import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:taiseer/features/user_features/order/domain/use_case/fetch_order_history_use_case.dart';
import '../../../../../main.dart';
import '../../domain/entity/order_entity.dart';
import 'history_filter_notifier_provider.dart';

final fetchOrderHistoryProvider =
    FutureProvider.autoDispose<List<OrderEntity>>((ref) async {
  final attribute = ref.watch(historyProvider);
  final history = await getIt<FetchOrderHistoryUseCase>().call(attribute);

  return history.fold((l) {
    throw l;
  }, (r) {
    return r;
  });
});
