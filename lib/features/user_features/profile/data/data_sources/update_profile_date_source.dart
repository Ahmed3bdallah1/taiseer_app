import 'package:dio/dio.dart';

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
    final file = data["image"];
    final fileMultipart = await MultipartFile.fromFile(file!.path,
        filename: file.path.split('/').last);
    final formData = FormData.fromMap({
      "first_name": data["first_name"],
      "last_name": data["last_name"],
      "image": fileMultipart,
      "email": data["email"],
      "phone": data["phone"],
    });
    final res = await apiService.post(
        url: ApiPath.updateProfile, requestBody: formData, returnDataOnly: false);
    return res['message'];
  }
}
