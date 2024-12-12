import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:taiseer/features/user_features/shipments/data/models/shipment_model.dart';
import 'package:taiseer/features/user_features/shipments/domain/use_cases/shipment_use_cases.dart';
import 'package:tuple/tuple.dart';

import '../../../../../main.dart';

final fetchShipmentsProvider = FutureProvider.autoDispose.family<ShipmentPaginationModel, Tuple2<int,String>>((ref, page) async {
  final shipments = await getIt<FetchShipmentsUseCase>().call(page);

  return shipments.fold((l) {
    throw l;
  }, (r) {
    return r;
  });
});

final fetchLastShipmentProvider = FutureProvider.autoDispose<ShipmentModel>((ref) async {
  final shipment = await getIt<FetchLastShipmentUseCase>().call();

  return shipment.fold((l) {
    throw l;
  }, (r) {
    return r;
  });
});


enum FilterShipmentProviderEnums {
  New,
  accepted,
  in_transit,
  delivered,
  rejected,
  closed
}
