import 'package:fpdart/fpdart.dart';
import 'package:learning/features/user_features/home/domain/entities/ad_entity.dart';

import '../../../../../core/errors/failure.dart';

abstract class AdsRepo {
  Future<Either<Failure, List<AdEntity>>> getAds();
}