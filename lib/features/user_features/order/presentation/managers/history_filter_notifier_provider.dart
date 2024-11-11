import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:learning/config/app_translation.dart';

final historyProvider = StateNotifierProvider.autoDispose<HistoryFilterNotifier,
    Map<String, dynamic>>((ref) {
  return HistoryFilterNotifier();
});

class HistoryFilterNotifier extends StateNotifier<Map<String, dynamic>> {
  HistoryFilterNotifier()
      : super({'order_status': null, 'sort': 'desc', 'program_type_id': null});

  final titles = {
    'order_status': null,
    'sort': 'desc',
    'program_type_id': null
  };

  updateFilter(FilterAttributes filter) {
    titles[filter.key] = filter.title;
    _updateState({...state, filter.key: filter.value});
  }

  _updateState(Map<String, dynamic> newState) {
    if (!mapEquals(state, newState)) {
      state = newState;
    }
  }
}
