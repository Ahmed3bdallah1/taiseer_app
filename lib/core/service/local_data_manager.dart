import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../../../../config/local_data_manager_key.dart';
import '../../config/api_path.dart';
import '../../main.dart';
import '../../models/user_model.dart';
import '../enum/language.dart';
import 'auth_service.dart';

LocalDataManager dataManager = getIt<LocalDataManager>();

abstract class LocalDataManager {
  T? getValue<T>(String key);

  Future<void> setValue<T>(String key, T value);

  Future deleteValue(String key);

  Future<bool> removeLoggedUser();

  bool contain(String key);

  Future init();

  Future<void> setLanguage(Language lang);

  Language? get getLanguage;

  Future<void> deleteToken();

  Future<void> deleteUser();

  String? getToken();

  UserModel? getUser();

  Future<void> setToken(String userToken);

  Future<void> setUser(UserModel userModel);

  bool getFingerprintEnabled();

  Future<void> setFingerprintEnabled(bool value);

  Future addToFavorite(int id);

  List getFavoriteIds();

  Future<void> setFavoriteIds(List ids);

  Future removeFavorite(int id);

  Future<void> deleteFCMToken();

  String? getFCMToken();

  Future<void> setFCMToken(String? fcmToken);

  Future<void> setAutoDownloadPdf(bool val);

  Future<void> setCanReviewShipment(bool val);

  Future<void> deleteFingerprint();

  bool? isDarkMode();

  bool getQrValue();

  Future<void> setIsDarkMode(bool? value);

  Future<void> setQr(bool value);

  bool get isFirstTime;

  bool get autoDownloadPdf;

  bool get canReviewShipment;

  Future<void> setSecondTime();
}

abstract class GetStorageManager extends LocalDataManager {
  final GetStorage box = GetStorage(ApiPath.baseurl, null, {
    LocalDataManagerKeys.appLanguage: Language.values.first.locale.languageCode,
    LocalDataManagerKeys.autoDownloadPdf: true,
    LocalDataManagerKeys.canEditShipmentAfterAddShipment: true,
  });
  final printLog = false;

  @override
  T? getValue<T>(String key) {
    final T? value = box.read(key);
    if (printLog) Get.log("get Value $key => $value");
    return value;
  }

  @override
  bool contain(String key) {
    return box.hasData(key);
  }

  @override
  Future<void> setValue<T>(String key, T value) async {
    if (printLog) Get.log("set Value $key => $value");
    return box.write(key, value);
  }

  @override
  Future deleteValue(String key) {
    if (printLog) Get.log("Delete Value $key");
    return box.remove(key);
  }
}

class GetStorageManagerImpl extends GetStorageManager {
  @override
  Future<bool> removeLoggedUser() async {
    await Future.wait([
      deleteToken(),
      deleteUser(),
      deleteFingerprint(),
    ]);
    providerContainer.read(userProvider.notifier).state = null;
    return true;
  }

  @override
  Future<void> setLanguage(Language lang) async {
    return setValue(LocalDataManagerKeys.appLanguage, lang.locale.languageCode);
  }

  @override
  Language? get getLanguage {
    return Language.values.firstWhereOrNull((element) =>
            element.locale.languageCode ==
            getValue(LocalDataManagerKeys.appLanguage)) ??
        Language.values.first;
  }

  @override
  Future<void> deleteToken() {
    return deleteValue(LocalDataManagerKeys.token);
  }

  @override
  Future<void> deleteUser() {
    return deleteValue(LocalDataManagerKeys.user);
  }

  @override
  String? getToken() {
    return getValue<String>(LocalDataManagerKeys.token);
  }

  @override
  UserModel? getUser() {
    final res= getValue(LocalDataManagerKeys.user);
    return UserModel.fromJson(res);
  }

  @override
  Future<void> setToken(String userToken) {
    return setValue(LocalDataManagerKeys.token, userToken);
  }

  @override
  Future<void> setUser(UserModel userModel) {
    return setValue(LocalDataManagerKeys.user, userModel.toJson());
  }

  @override
  Future<void> setFingerprintEnabled(bool value) async {
    return setValue(LocalDataManagerKeys.fingerprint, value);
  }

  @override
  Future<void> deleteFingerprint() {
    return deleteValue(LocalDataManagerKeys.fingerprint);
  }

  @override
  Future addToFavorite(int id) {
    return setFavoriteIds(getFavoriteIds()..add(id));
  }

  @override
  List getFavoriteIds() {
    return getValue(LocalDataManagerKeys.favorite) ?? [];
  }

  @override
  Future<void> setFavoriteIds(List ids) {
    return setValue(LocalDataManagerKeys.favorite, ids);
  }

  @override
  Future removeFavorite(int id) {
    return setFavoriteIds(getFavoriteIds()..remove(id));
  }

  @override
  Future<void> deleteFCMToken() {
    return deleteValue(LocalDataManagerKeys.fcmToken);
  }

  @override
  String? getFCMToken() {
    return getValue<String>(LocalDataManagerKeys.fcmToken);
  }

  @override
  Future<void> setFCMToken(String? fcmToken) {
    return setValue(LocalDataManagerKeys.fcmToken, fcmToken);
  }

  @override
  Future<void> setAutoDownloadPdf(bool val) {
    return setValue(LocalDataManagerKeys.autoDownloadPdf, val);
  }

  @override
  bool? isDarkMode() {
    return getValue(LocalDataManagerKeys.isDarkMode);
  }

  @override
  bool getQrValue() {
    return getValue(LocalDataManagerKeys.qr) ?? true;
  }

  @override
  Future<void> setIsDarkMode(bool? value) {
    return setValue(LocalDataManagerKeys.isDarkMode, value);
  }

  @override
  Future<void> setQr(bool value) {
    return setValue(LocalDataManagerKeys.qr, value);
  }

  @override
  bool get isFirstTime => getValue(LocalDataManagerKeys.secondTime) != true;

  @override
  bool get autoDownloadPdf =>
      getValue(LocalDataManagerKeys.autoDownloadPdf) != false;

  @override
  Future<void> setSecondTime() {
    return setValue(LocalDataManagerKeys.secondTime, true);
  }

  @override
  Future<LocalDataManager> init() async {
    await GetStorage.init();
    // box.erase();
    return this;
  }

  @override
  bool get canReviewShipment =>
      getValue(LocalDataManagerKeys.canEditShipmentAfterAddShipment) ?? true;

  @override
  Future<void> setCanReviewShipment(bool val) {
    return setValue(LocalDataManagerKeys.canEditShipmentAfterAddShipment, val);
  }

  @override
  bool getFingerprintEnabled() {
    return getValue(LocalDataManagerKeys.fingerprint) ?? false;
  }
}
