import 'dart:io';

import 'package:dio/dio.dart';

import '../../../../../config/api_path.dart';
import '../../../../../core/service/webservice/dio_helper.dart';
import '../models/upload_file_model.dart';

abstract class UploadFileDataSource {
  Future<UploadFileModel> uploadFile(File file);
}

class UploadFileDataSourceImpl implements UploadFileDataSource {
  final ApiService _apiService;

  UploadFileDataSourceImpl(this._apiService);

  @override
  Future<UploadFileModel> uploadFile(File file) async {
    final res = await _apiService.post(
      url: ApiPath.upload,
      receiveTimeout: null,
      sendTimeOut: null,
      ignoreError: true,
      returnDataOnly: false,
      requestBody: FormData.fromMap({
        'image': await MultipartFile.fromFile(file.path),
        'name': "profile"
      }),
    );
    return UploadFileModel.fromJson(res);
  }
}
