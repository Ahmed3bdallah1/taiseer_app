import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:learning/features/shared/auth/domain/repositories/auth_repo.dart';

import '../../features/shared/auth/domain/use_cases/login_user_use_case.dart';
import '../../features/shared/auth/domain/use_cases/register_user_use_case.dart';
import '../../main.dart';
import '../../models/user_model.dart';
import 'local_data_manager.dart';

final userProvider = StateProvider<UserModel?>((ref) {
  ref.listenSelf((previous, next) {
    if ((previous?.id != next?.id) || (next == null)) {}
  });
  return null;
});

final isNeedToCompleteProfile = Provider.autoDispose<bool>((ref) {
  final profile = ref.watch(userProvider);
  return [
    profile?.name,
    profile?.phone,
    profile?.birthday,
    profile?.address,
    profile?.imageIdBack,
    profile?.imageIdFront,
  ].contains(null);
});
final isInReviewProvider = Provider.autoDispose<bool>((ref) {
  if (ref.watch(isNeedToCompleteProfile)) {
    return false;
  } else {
    return ref.watch(userProvider)?.isVerified != 1;
  }
});
final canSubmitOrder = Provider.autoDispose<bool>((ref) {
  return ref.watch(isInReviewProvider) == false &&
      ref.watch(isNeedToCompleteProfile) == false;
});

final userIdProvider = Provider<int?>((ref) {
  return ref.watch(userProvider)?.id;
});

final fetchUserProvider = FutureProvider.autoDispose<bool>((ref) async {
  final token = dataManager.getToken();
  if (token != null) {
    final res = await getIt<AuthRepo>().getMyProfile();
    return res.fold((error) async {
      if (error.message == "notfound") {
        await dataManager.removeLoggedUser();
        return false;
      } else {
        ref.read(userProvider.notifier).state = null;
        throw error;
      }
    }, (user) async {
      ref.read(userProvider.notifier).state = user;
      return true;
    });
  } else {
    return false;
  }
});

class AuthService {
  AuthService._();

  static final AuthService instance = AuthService._();

  factory AuthService() => instance;

  Future<bool> login(
      Map<String, dynamic> data, BuildContext context, WidgetRef ref) async {
    final res = await getIt<LoginUserUseCase>()(data);
    return res.fold((l) async {
      ref.read(userProvider.notifier).state = null;
      throw l;
    }, (res) async {
      ref.read(userProvider.notifier).state = res.user;
      return true;
    });
  }

  Future<bool> register(
      Map<String, dynamic> data, BuildContext context, WidgetRef ref) async {
    final res = await getIt<RegisterUserUseCase>()(data);
    return res.fold((l) async {
      ref.read(userProvider.notifier).state = null;
      throw l;
    }, (res) async {
      ref.read(userProvider.notifier).state = res.user;
      return true;
    });
  }
}
