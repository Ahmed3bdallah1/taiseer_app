import 'package:fpdart/fpdart.dart';
import 'package:learning/features/user_features/home/domain/entities/ad_entity.dart';
import 'package:learning/features/user_features/home/domain/repositories/ads_repo.dart';
import '../../../../../core/errors/failure.dart';
import '../../../../../core/use_cases/use_case.dart';

class FetchAdsUseCase extends UseCaseNoParam<List<AdEntity>> {
  final AdsRepo adsRepo;

  FetchAdsUseCase({required this.adsRepo});

  @override
  Future<Either<Failure, List<AdEntity>>> call([void param]) async {
    final res = await adsRepo.getAds();
    return res;
  }
}
