import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/entities/calender_day_entity.dart';

final selectedCalenderIndexProvider = StateProvider.autoDispose<int>((ref) {
  return 0;
});

final eventsDataProvider = StateProvider<CalenderDayEntity?>((ref) => null);
final dateTimeProvider = StateProvider<DateTime>((ref) => DateTime.now());