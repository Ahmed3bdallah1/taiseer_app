import 'dart:math';

import 'package:taiseer/core/service/local_data_manager.dart';

import '../../../../../config/api_path.dart';
import '../../../../../core/service/webservice/dio_helper.dart';
import '../../../../../models/user_model.dart';
import '../../domain/entities/auth_entity.dart';

abstract class AuthDataSource {
  Future<UserAuthResponseModel> login(Map<String, dynamic> data);

  Future<UserAuthResponseModel> register(Map<String, dynamic> data);

  Future<UserModel> getMyProfile();

  Future<List<CountryEntity>> getCountries();
}

class AuthDataSourceImpl extends AuthDataSource {
  final ApiService apiService;

  AuthDataSourceImpl(this.apiService);

  @override
  Future<UserAuthResponseModel> login(Map<String, dynamic> data) async {
    final res = await apiService.post(
        url: ApiPath.login, requestBody: data, returnDataOnly: false);
    return UserAuthResponseModel(
        token: res['token'], user: UserModel.fromJson(res['data']));
  }

  @override
  Future<UserAuthResponseModel> register(Map<String, dynamic> data) async {
    final res = await apiService.post(
        url: ApiPath.userRegister, requestBody: data, returnDataOnly: false);
    return UserAuthResponseModel(
        token: res['token'], user: UserModel.fromJson(res['data']));
  }

  @override
  Future<UserModel> getMyProfile() async {
    final user = dataManager.getUser();
    final res = await apiService.get(url: "${ApiPath.user}${user?.id ?? 0}");
    return UserModel.fromJson(res);
  }

  @override
  Future<List<CountryEntity>> getCountries() async {
    // await Future.delayed(const Duration(seconds: 2));
    // return countries;
    final countries = await apiService.get<List>(url: ApiPath.countries);
    return countries.map((e) => CountryEntity.fromJson({...e,
      'number_length':11
    })).toList();
  }
}
