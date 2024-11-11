import 'package:learning/core/service/webservice/dio_helper.dart';

import '../../domain/entities/ad_entity.dart';

abstract class AdsDataSource{
  Future<List<AdEntity>> getBanners();
}

class AdsDataSourceImp extends AdsDataSource{
  final ApiService apiService;

  AdsDataSourceImp({required this.apiService});
  @override
  Future<List<AdEntity>> getBanners() async{
    await Future.delayed(const Duration(seconds: 2));
    return ads;
  }
}