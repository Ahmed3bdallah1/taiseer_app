import 'package:dio/dio.dart';
import 'package:fpdart/fpdart.dart';
import 'package:learning/core/errors/failure.dart';
import 'package:learning/features/user_features/home/data/data_source/ads_data_source.dart';
import 'package:learning/features/user_features/home/domain/entities/ad_entity.dart';
import 'package:learning/features/user_features/home/domain/repositories/ads_repo.dart';

class AdsRepoImp extends AdsRepo{
  final AdsDataSource adsDataSource;

  AdsRepoImp({required this.adsDataSource});
  @override
  Future<Either<Failure, List<AdEntity>>> getAds() async {
    try {
      final res = await adsDataSource.getBanners();
      return Right(res);
    } catch (e) {
      if (e is DioException) {
        return Left(ServerFailure.fromDioError(e));
      } else {
        return Left(GeneralError(e));
      }
    }
  }

}