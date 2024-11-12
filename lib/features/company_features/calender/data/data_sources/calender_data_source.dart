import 'package:taiseer/core/service/webservice/dio_helper.dart';
import '../../../../../config/api_path.dart';
import '../../domain/entities/calender_day_entity.dart';
import '../models/calender_history_model.dart';

abstract class CalenderDataSource {
  Future<List<CalenderDayEntity>> getCalender();
  Future<List<CalenderHistoryModel>> getDayCalenderForOrder(int id);
}

class CalenderDataSourceImpl extends CalenderDataSource {
  final ApiService apiService;
  CalenderDataSourceImpl(this.apiService);

  @override
  Future<List<CalenderDayEntity>> getCalender() async {
    final res = await apiService.get(url: ApiPath.installment);
    if (res is List) {
      return [];
    } else {
      final data = (res as Map)
          .entries
          .map((e) => CalenderDayEntity(
              date: "${e.key}",
              installment: (e.value as List)
                  .map((e) => CalenderHistoryModel.fromJson(e))
                  .toList()))
          .toList();
      return data;
    }
  }

  @override
  Future<List<CalenderHistoryModel>> getDayCalenderForOrder(int id) async {
    final res = await apiService.get(url: "${ApiPath.installment}/$id");
    final data =
        (res as List).map((e) => CalenderHistoryModel.fromJson(e)).toList();
    return data;
  }
}
