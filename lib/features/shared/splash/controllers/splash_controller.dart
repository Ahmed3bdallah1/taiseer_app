import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/service/auth_service.dart';
import '../../../../core/service/local_data_manager.dart';

enum SplashNavigate { home, getStarted, boarding, login }

final splashNavigateProvider = Provider.autoDispose<SplashNavigate>((ref) {
  SplashNavigate splashNavigate = SplashNavigate.home;
  if (dataManager.getToken() != null) {
    splashNavigate = SplashNavigate.home;
  } else if (dataManager.isFirstTime) {
    splashNavigate = SplashNavigate.getStarted;
  } else {
    splashNavigate = SplashNavigate.login;
  }
  return splashNavigate;
});

// final newUpdateProvider = FutureProvider.autoDispose<bool>((ref) async {
//   final shorebirdCodePush = ShorebirdCodePush();
//   final isUpdateAvailable =
//       await shorebirdCodePush.isNewPatchAvailableForDownload();
//   if (isUpdateAvailable) {
//     ref.read(isUpdateAvailableProvider.notifier).state = true;
//     await shorebirdCodePush.downloadUpdateIfAvailable();
//   }
//   return isUpdateAvailable;
// });

final isUpdateAvailableProvider = StateProvider.autoDispose<bool>((ref) {
  return false;
});

final splashProvider = FutureProvider.autoDispose<SplashNavigate>((ref) async {
  final hasUser = await ref.read(fetchUserProvider.future);
  if (!hasUser) await Future.delayed(const Duration(seconds: 2));
  final res = ref.read(splashNavigateProvider);
  if (res == SplashNavigate.home) {
    if (dataManager.getFingerprintEnabled() == true) {
      return SplashNavigate.login;
    } else {
      return SplashNavigate.home;
    }
  } else {
    return res;
  }
});

final hasInternetProvider2 = StateProvider<bool>((ref) => true);

final fuckInternetOk = Provider<bool>((ref) {
  final a1 = ref.watch(hasInternetProvider);
  final a2 = ref.watch(hasInternetProvider2);
  if (a1.isLoading) {
    return true;
  } else if (a1.hasValue) {
    if (a1.value!) {
      return a2;
    } else {
      return false;
    }
  } else {
    return a2;
  }
});
final connectivity = Connectivity();

final hasInternetProvider = StreamProvider<bool>((ref) async* {
  ref.listenSelf((previous, next) {
    if (previous?.value == false && next.value == true) {
      ref.invalidate(hasInternetProvider2);
    }
  });
  final connectivityResult = await connectivity.checkConnectivity();
  yield connectivityResult.isOnline;
  yield* connectivity.onConnectivityChanged.map((event) {
    return event.isOnline;
  });
});

extension on List<ConnectivityResult> {
  bool get isOffline {
    return contains(ConnectivityResult.none);
  }

  bool get isOnline {
    return !isOffline;
  }
}
