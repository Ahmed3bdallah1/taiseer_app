import 'package:fpdart/fpdart.dart';
import 'package:learning/features/user_features/support/domain/repo/support_repo.dart';
import '../../../../../core/errors/failure.dart';
import '../../../../../core/use_cases/use_case.dart';
import '../entites/support_entity.dart';

class FetchSupportUseCase extends UseCaseNoParam<SupportEntity> {
  final SupportRepo supportRepo;

  FetchSupportUseCase({required this.supportRepo});

  @override
  Future<Either<Failure, SupportEntity>> call() async {
    return supportRepo.getSupport();
  }
}
