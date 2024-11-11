import '../../../../../config/api_path.dart';
import '../../../../../core/service/webservice/dio_helper.dart';

abstract class UpdateProfileDataSource {
  Future<String> updateProfile(Map<String, dynamic> data);
}

class UpdateProfileDataSourceImpl extends UpdateProfileDataSource {
  final ApiService apiService;

  UpdateProfileDataSourceImpl(this.apiService);

  @override
  Future<String> updateProfile(Map<String, dynamic> data) async {
    final res = await apiService.post(
        url: ApiPath.updateProfile, requestBody: data, returnDataOnly: false);
    return res['message'];
  }
}
