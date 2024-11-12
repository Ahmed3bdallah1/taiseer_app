import 'package:taiseer/config/api_path.dart';

import '../../../../../core/service/webservice/dio_helper.dart';

abstract class VerificationDataSource {
  Future<bool> verify(String code, {String? emailOrPhone});

  Future<bool> resend({String? emailOrPhone});

  Future<bool> send({String? emailOrPhone});
}

class VerifiyDataSourceImpl implements VerificationDataSource {
  final ApiService apiService;

  VerifiyDataSourceImpl(this.apiService);

  @override
  Future<bool> verify(String code, {String? emailOrPhone}) async {
    final res = await apiService
        .post(url: ApiPath.verifyOTP, requestBody: {"otp": code});
    return res;
  }

  @override
  Future<bool> resend({String? emailOrPhone}) async {
    return send(emailOrPhone: emailOrPhone);
  }

  @override
  Future<bool> send({String? emailOrPhone}) async {
    final res = await apiService.post(url: ApiPath.sendOTP);
    return res;
  }
}

class ForgetVerifiyDataSourceImpl implements VerificationDataSource {
  final ApiService apiService;

  ForgetVerifiyDataSourceImpl(this.apiService);

  @override
  Future<bool> verify(String code, {String? emailOrPhone}) async {
    final res = await apiService.post(
        url: ApiPath.validateOTPForgetPassword,
        requestBody: {"otp": code, "phone": emailOrPhone});
    return res;
  }

  @override
  Future<bool> resend({String? emailOrPhone}) async {
    return send(emailOrPhone: emailOrPhone);
  }

  @override
  Future<bool> send({String? emailOrPhone}) async {
    final res =
        await apiService.post(url: ApiPath.forgetPassword, requestBody: {
      'phone': '$emailOrPhone',
    });
    return res;
  }
}

class CheckPhoneDataSourceImpl implements VerificationDataSource {
  final ApiService apiService;

  CheckPhoneDataSourceImpl(this.apiService);

  @override
  Future<bool> verify(String code, {String? emailOrPhone}) async {
    final res = await apiService.post(
        url: ApiPath.verifyForRegister,
        requestBody: {"otp": code, 'phone': emailOrPhone});
    return res;
  }

  @override
  Future<bool> resend({String? emailOrPhone}) async {
    return send(emailOrPhone: emailOrPhone);
  }

  @override
  Future<bool> send({String? emailOrPhone, Map<String, dynamic>? data}) async {
    final res = await apiService
        .post(url: ApiPath.checkPhone, requestBody: {'phone': emailOrPhone});
    return res;
  }
}
