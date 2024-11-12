import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:taiseer/features/user_features/order/domain/entity/order_entity.dart';
import 'package:taiseer/features/user_features/order/domain/use_case/fetch_last_order_use_case.dart';
import '../../../../../main.dart';

final fetchLastOrderProvider =
    FutureProvider.autoDispose<OrderEntity>((ref) async {
  final lastOrder = await getIt<FetchLastOrderUseCase>().call();

  return lastOrder.fold((l) {
    throw l;
  }, (r) {
    return r;
  });
});
