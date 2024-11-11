import 'package:learning/core/service/webservice/dio_helper.dart';
import 'package:learning/models/program_model.dart';

import '../../../../../config/api_path.dart';

abstract class LoanDataSource {
  Future<List<ProgramModel>> getLoans();
}

class LoanDataSourceImp extends LoanDataSource {
  final ApiService apiService;
  LoanDataSourceImp(this.apiService);

  @override
  Future<List<ProgramModel>> getLoans() async {
    final res = await apiService.get(
      url: ApiPath.loans,
    );
    return (res as List).map((e) => ProgramModel.fromJson(e)).toList();
  }
}
