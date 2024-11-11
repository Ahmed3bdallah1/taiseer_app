import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:learning/features/shared/auth/domain/repositories/auth_repo.dart';
import 'package:learning/models/user_model.dart';

import '../../../../../../core/service/auth_service.dart';
import '../../../../../../main.dart';

final refreshProfileProvider =
    FutureProvider.autoDispose<UserModel>((ref) async {
  ref.listenSelf((previous, next) {
    if (next.value is UserModel) {
      ref.read(userProvider.notifier).state = next.value;
    }
  });
  final res = await getIt<AuthRepo>().getMyProfile();
  return res.fold((l) => throw l, (r) => r);
});
