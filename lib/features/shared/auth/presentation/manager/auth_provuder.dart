import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:taiseer/features/company_features/company_root/view/company_root_view.dart';
import 'package:taiseer/features/shared/auth/presentation/view/login_page.dart';
import 'package:taiseer/models/user_model.dart';
import '../../../../../core/service/auth_service.dart';
import '../../../../../core/service/local_data_manager.dart';
import '../../../../../main.dart';
import '../../../../user_features/root/view/root_view.dart';
import '../../../verify/domain/repositories/verification_repo.dart';
import '../../../verify/presentation/pages/verify_view.dart';
import '../../domain/entities/auth_entity.dart';
import '../../domain/use_cases/login_user_use_case.dart';
import '../../domain/use_cases/register_user_use_case.dart';

final authNotifierProvider =
    StateNotifierProvider.autoDispose<AuthNotifier, bool>((ref) {
  return AuthNotifier(ref);
});

class AuthNotifier extends StateNotifier<bool> {
  AuthNotifier(this.ref) : super(false);
  Ref ref;

  Future login(Map<String, dynamic> data) async {
    state = true;
    try {
      final res = await getIt<LoginUserUseCase>()(data);
      res.fold((l) {
        throw l;
      }, (r) {
        handleUser(r, data);
      });
    } finally {
      state = false;
    }
  }

  Future register(Map<String, dynamic> data,bool? isRegister) async {
    state = true;
    try {
      final res = await getIt<RegisterUserUseCase>()(data);
      res.fold((l) {
        throw l;
      }, (r) {
        if(isRegister == true){
          Get.to(()=>const LoginPage());
        }
        handleUser(r, data);
      });
    } finally {
      state = false;
    }
  }

  handleUser(UserAuthResponseModel user, Map<String, dynamic> data,
      {bool checkIsVerified = false}) async {
    if (user.token != null && user.user != null) {
      await dataManager.setUser(user.user!);
      await dataManager.setToken(user.token!);
    }
    ref.read(userProvider.notifier).state = user.user;
    if (checkIsVerified && user.user?.emailVerifiedAt == null) {
      return Get.offAll(() => VerifyView(
              repo: getIt<VerificationRepo>(
            param1: user.user?.email,
          )));
    } else {
      return Get.offAll(
          () => isCompany ? const CompanyRootView() : const RootView());
    }
  }
}

final fingerprintControllerProvider = StateProvider.autoDispose<bool>((ref) {
  return dataManager.getFingerprintEnabled();
});

final fetchCountryProvider = FutureProvider<List<CountryEntity>>((ref) async {
  final countries = await getIt<FetchCountriesUseCase>().call();
  return countries.fold((l) {
    print(l.message);
    throw l;
  }, (r) {
    return r;
  });
});
