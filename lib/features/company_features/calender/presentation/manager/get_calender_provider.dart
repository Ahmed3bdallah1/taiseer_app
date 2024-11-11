import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:learning/main.dart';
import '../../data/models/calender_history_model.dart';
import '../../domain/entities/calender_day_entity.dart';
import '../../domain/use_cases/get_calender_history_use_case.dart';
import '../../domain/use_cases/get_my_calender_use_case.dart';

final fetchCompanyCalenderHistoryProvider =
    FutureProvider.autoDispose<List<CalenderDayEntity>>((ref) async {
  final res = await getIt<GetMyCalenderUseCase>().call();
  return res.fold((l) => throw l, (r) => r);
});

final fetchDatesForOrderProvider = FutureProvider.autoDispose
    .family<List<CalenderHistoryModel>, int>((ref, dd) async {
  final res = await getIt<GetDatesForOrderUseCase>()(dd);
  return res.fold((l) => throw l, (r) => r);
});
