import 'package:learning/core/service/webservice/dio_helper.dart';
import 'package:learning/models/program_model.dart';

import '../../../../../config/api_path.dart';

abstract class LoanDetailsDataSource {
  Future<ProgramModel> getLoanDetails(int id);
}

class LoanDetailsDataSourceImp extends LoanDetailsDataSource {
  final ApiService apiService;
  LoanDetailsDataSourceImp(this.apiService);
  @override
  Future<ProgramModel> getLoanDetails(int id) async {
    final res = await apiService.get(
      url: "${ApiPath.loan}/$id",
    );
    return ProgramModel.fromJson(res);
  }
}
