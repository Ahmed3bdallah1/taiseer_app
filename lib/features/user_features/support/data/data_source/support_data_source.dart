import 'package:taiseer/config/api_path.dart';
import 'package:taiseer/core/service/webservice/dio_helper.dart';

import '../../domain/entites/support_entity.dart';

abstract class SupportDataSource {
  Future<SupportEntity> getSupport();
}

class SupportDataSourceImp extends SupportDataSource {
  final ApiService apiService;

  SupportDataSourceImp({required this.apiService});
  @override
  Future<SupportEntity> getSupport() async {
    final res = await apiService.get(
        url: ApiPath.support, returnDataOnly: false);
    SupportEntity supportEntity = SupportEntity.fromJson(res["details"]);
    return supportEntity;
  }
}
