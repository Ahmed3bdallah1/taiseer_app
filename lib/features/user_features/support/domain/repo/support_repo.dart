import 'package:fpdart/fpdart.dart';
import 'package:taiseer/core/errors/failure.dart';
import '../entites/support_entity.dart';

abstract class SupportRepo {
  Future<Either<Failure, SupportEntity>> getSupport();
}
