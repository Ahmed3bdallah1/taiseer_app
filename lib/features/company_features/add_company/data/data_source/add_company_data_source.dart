import 'package:taiseer/features/company_features/add_company/data/model/add_company_model.dart';

import '../../../../../core/service/webservice/dio_helper.dart';

abstract class AddCompanyDataSource {
  Future<AddCompanyModel> getAddCompanyData();

  Future<bool> addCompany({required Map map});
}

class AddCompanyDataSourceImp extends AddCompanyDataSource {
  final ApiService apiService;

  AddCompanyDataSourceImp(this.apiService);

  @override
  Future<AddCompanyModel> getAddCompanyData() async {
    await Future.delayed(const Duration(seconds: 2));
    return addCompanyModel;
  }

  @override
  Future<bool> addCompany({required Map map}) async {
    await Future.delayed(const Duration(seconds: 2));
    return true;
  }
}
