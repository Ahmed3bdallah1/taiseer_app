import 'package:learning/features/company_features/add_company/data/data_source/add_company_data_source.dart';
import 'package:learning/features/company_features/add_company/data/repo/add_company_repo_imp.dart';
import 'package:learning/features/company_features/add_company/domain/repo/add_company_repo.dart';
import 'package:learning/features/company_features/add_company/domain/use_case/add_company_use_case.dart';
import 'package:learning/features/company_features/calender/data/data_sources/calender_data_source.dart';
import 'package:learning/features/company_features/calender/data/repositories/calender_repo_impl.dart';
import 'package:learning/features/company_features/calender/domain/repositories/calender_repo.dart';
import 'package:learning/features/shared/forget_password/data/data_sources/forget_password_data_source.dart';
import 'package:learning/features/shared/forget_password/data/repositories/forget_password_repo_impl.dart';
import 'package:learning/features/user_features/home/data/data_source/ads_data_source.dart';
import 'package:learning/features/user_features/home/data/data_source/loan_details_data_source.dart';
import 'package:learning/features/user_features/home/data/repostories/ads_repo_imp.dart';
import 'package:learning/features/user_features/home/data/repostories/loan_details_repo_imp.dart';
import 'package:learning/features/user_features/home/domain/repositories/ads_repo.dart';
import 'package:learning/features/user_features/home/domain/repositories/loan_details_repo.dart';
import 'package:learning/features/user_features/home/domain/use_case/fetch_ads_use_case.dart';
import 'package:learning/features/user_features/home/domain/use_case/fetch_loan_details_use_case.dart';
import 'package:learning/features/shared/notifications/data/data_source/notification_data_source.dart';
import 'package:learning/features/shared/notifications/data/repo/notification_repo_imp.dart';
import 'package:learning/features/shared/notifications/domain/repos/notification_repo.dart';
import 'package:learning/features/shared/notifications/domain/use_case/fetch_notifications_use_case.dart';
import 'package:learning/features/user_features/order/data/data_source/order_data_source.dart';
import 'package:learning/features/user_features/order/data/repo/order_repo_imp.dart';
import 'package:learning/features/user_features/order/domain/repo/order_repo.dart';
import 'package:learning/features/user_features/order/domain/use_case/delete_order_use_case.dart';
import 'package:learning/features/user_features/order/domain/use_case/fetch_last_order_use_case.dart';
import 'package:learning/features/user_features/order/domain/use_case/fetch_order_history_use_case.dart';
import 'package:learning/features/user_features/order/domain/use_case/get_filter_attr_use_case.dart';
import 'package:learning/features/user_features/profile/data/data_sources/update_profile_date_source.dart';
import 'package:learning/features/user_features/support/data/data_source/support_data_source.dart';
import 'package:learning/features/user_features/support/domain/repo/support_repo.dart';
import 'package:learning/features/user_features/support/domain/use_case/fetch_support_use_case.dart';
import 'package:learning/features/shared/verify/data/data_sources/verification_data_source.dart';
import 'package:learning/features/shared/verify/data/repositories/forget_verify_repo_impl.dart';
import 'package:learning/features/shared/verify/data/repositories/verify_repo_impl.dart';
import 'package:learning/features/shared/verify/domain/repositories/verification_repo.dart';
import 'package:learning/features/user_features/user_company/data/data_source/company_data_source.dart';
import 'package:learning/features/user_features/user_company/domain/repo/company_repo.dart';
import 'package:local_auth/local_auth.dart';
import 'core/service/image_picker_cropper.dart';
import 'core/service/local_data_manager.dart';
import 'core/service/localization_service/localization_service.dart';
import 'core/service/webservice/dio_helper.dart';
import 'features/company_features/calender/domain/use_cases/get_calender_history_use_case.dart';
import 'features/company_features/calender/domain/use_cases/get_my_calender_use_case.dart';
import 'features/shared/auth/data/data_sources/auth_data_source.dart';
import 'features/shared/auth/data/repositories/auth_repo_impl.dart';
import 'features/shared/auth/domain/repositories/auth_repo.dart';
import 'features/shared/auth/domain/use_cases/login_user_use_case.dart';
import 'features/shared/auth/domain/use_cases/register_user_use_case.dart';
import 'features/shared/forget_password/domain/repositories/forget_password_repo.dart';
import 'features/user_features/home/data/data_source/loan_data_source.dart';
import 'features/user_features/home/data/repostories/loan_repo_imp.dart';
import 'features/user_features/home/domain/repositories/loan_repo.dart';
import 'features/user_features/home/domain/use_case/fetch_loan_use_case.dart';
import 'features/user_features/order/domain/use_case/submit_order_use_case.dart';
import 'features/shared/notifications/domain/use_case/fetch_seen_use_case.dart';
import 'features/user_features/profile/data/data_sources/upload_file_data_source.dart';
import 'features/user_features/profile/data/repositories/update_profile_repo_impl.dart';
import 'features/user_features/profile/data/repositories/upload_file_repo_impl.dart';
import 'features/user_features/profile/domain/repositories/update_profile_repo.dart';
import 'features/user_features/profile/domain/repositories/upload_file_repo.dart';
import 'features/user_features/profile/domain/use_cases/update_profile_use_case.dart';
import 'features/user_features/profile/domain/use_cases/upload_file_use_case.dart';
import 'features/user_features/support/data/repo/support_repo_imp.dart';
import 'features/user_features/user_company/data/repo/company_repo_imp.dart';
import 'features/user_features/user_company/domain/use_case/company_use_case.dart';
import 'main.dart';

Future setupLocator() async {
  //DATABASE
  getIt.registerSingleton<LocalDataManager>(
      await GetStorageManagerImpl().init());

  //NETWORK
  getIt.registerSingleton<ApiService>(ApiService());
  //LOCALIZATION
  getIt.registerSingleton<LocaleService>(
      LocaleService(getIt<LocalDataManager>()));
  //IMAGE PICKER
  getIt.registerLazySingleton<ImagePickerService>(
      () => ImagePickerServiceImpl());

  getIt.registerLazySingleton<LocalAuthentication>(() => LocalAuthentication());

  // register Loan entity
  getIt.registerLazySingleton<LoanDataSource>(
      () => LoanDataSourceImp(getIt<ApiService>()));
  getIt.registerLazySingleton<LoanRepo>(
      () => LoanRepoImp(loanDataSource: getIt<LoanDataSource>()));
  getIt.registerLazySingleton<FetchLoanUseCase>(
      () => FetchLoanUseCase(loanRepo: getIt<LoanRepo>()));

  // register notifications entity
  getIt.registerLazySingleton<NotificationDataSource>(
      () => NotificationDataSourceImp(apiService: getIt<ApiService>()));
  getIt.registerLazySingleton<NotificationRepo>(() => NotificationRepoImp(
      notificationDataSource: getIt<NotificationDataSource>()));
  getIt.registerLazySingleton<FetchNotificationUseCase>(() =>
      FetchNotificationUseCase(notificationRepo: getIt<NotificationRepo>()));
  getIt.registerLazySingleton<SeenNotificationUseCase>(() =>
      SeenNotificationUseCase(notificationRepo: getIt<NotificationRepo>()));

  // register Loan details entity
  getIt.registerLazySingleton<LoanDetailsDataSource>(
      () => LoanDetailsDataSourceImp(getIt<ApiService>()));
  getIt.registerLazySingleton<LoanDetailsRepo>(() =>
      LoanDetailsRepoImp(detailsDataSource: getIt<LoanDetailsDataSource>()));
  getIt.registerLazySingleton<FetchLoanDetailsUseCase>(
      () => FetchLoanDetailsUseCase(loanDetailsRepo: getIt<LoanDetailsRepo>()));

  // register history entity
  getIt.registerLazySingleton<FetchOrderHistoryUseCase>(
      () => FetchOrderHistoryUseCase(orderRepo: getIt<OrderRepo>()));
  getIt.registerLazySingleton<GetFilterAttrUseCase>(
      () => GetFilterAttrUseCase(orderRepo: getIt<OrderRepo>()));

  // register last order entity
  getIt.registerLazySingleton<OrderDataSource>(
      () => OrderDataSourceImp(getIt<ApiService>()));
  getIt.registerLazySingleton<OrderRepo>(
      () => OrderRepoImp(orderDataSource: getIt<OrderDataSource>()));
  getIt.registerLazySingleton<FetchLastOrderUseCase>(
      () => FetchLastOrderUseCase(orderRepo: getIt<OrderRepo>()));
  getIt.registerLazySingleton<FetchDeleteOrderUseCase>(
      () => FetchDeleteOrderUseCase(orderRepo: getIt<OrderRepo>()));

  // register support entity
  getIt.registerLazySingleton<SupportDataSource>(
      () => SupportDataSourceImp(apiService: getIt<ApiService>()));
  getIt.registerLazySingleton<SupportRepo>(
      () => SupportRepoImp(supportDataSource: getIt<SupportDataSource>()));
  getIt.registerLazySingleton<FetchSupportUseCase>(
      () => FetchSupportUseCase(supportRepo: getIt<SupportRepo>()));

  // register ads entity
  getIt.registerLazySingleton<AdsDataSource>(
      () => AdsDataSourceImp(apiService: getIt<ApiService>()));
  getIt.registerLazySingleton<AdsRepo>(
      () => AdsRepoImp(adsDataSource: getIt<AdsDataSource>()));
  getIt.registerLazySingleton<FetchAdsUseCase>(
      () => FetchAdsUseCase(adsRepo: getIt<AdsRepo>()));

  // register company
  getIt.registerLazySingleton<UserCompanyDataSource>(
      () => UserCompanyDataSourceImp(getIt<ApiService>()));
  getIt.registerLazySingleton<UserCompanyRepo>(() =>
      UserCompanyRepoImp(companyDataSource: getIt<UserCompanyDataSource>()));
  getIt.registerLazySingleton<FetchUserCompanyUseCase>(
      () => FetchUserCompanyUseCase(companyRepo: getIt<UserCompanyRepo>()));
  getIt.registerLazySingleton<FetchSearchCompanyUseCase>(
      () => FetchSearchCompanyUseCase(companyRepo: getIt<UserCompanyRepo>()));
  getIt.registerLazySingleton<FetchSearchUseCase>(
      () => FetchSearchUseCase(companyRepo: getIt<UserCompanyRepo>()));

  // register company calender
  getIt.registerLazySingleton<CalenderDataSource>(
      () => CalenderDataSourceImpl(getIt<ApiService>()));
  getIt.registerLazySingleton<CalenderRepo>(
      () => CalenderRepoImpl(getIt<CalenderDataSource>()));
  getIt.registerLazySingleton<GetDatesForOrderUseCase>(
      () => GetDatesForOrderUseCase(getIt<CalenderRepo>()));
  getIt.registerLazySingleton<GetMyCalenderUseCase>(
      () => GetMyCalenderUseCase(getIt<CalenderRepo>()));

  // register add company
  getIt.registerLazySingleton<AddCompanyDataSource>(
      () => AddCompanyDataSourceImp(getIt<ApiService>()));
  getIt.registerLazySingleton<AddCompanyRepo>(() =>
      AddCompanyRepoImp(addCompanyDataSource: getIt<AddCompanyDataSource>()));
  getIt.registerLazySingleton<FetchAddCompanyUseCase>(
      () => FetchAddCompanyUseCase(addCompanyRepo: getIt<AddCompanyRepo>()));
  getIt.registerLazySingleton<AddCompanyUseCase>(
      () => AddCompanyUseCase(addCompanyRepo: getIt<AddCompanyRepo>()));

  //register order
  getIt.registerLazySingleton<SubmitOrderUseCase>(
      () => SubmitOrderUseCase(orderRepo: getIt<OrderRepo>()));
  getIt.registerLazySingleton<FetchCountriesUseCase>(
      () => FetchCountriesUseCase(getIt<AuthRepo>()));

  // Verification
  getIt.registerLazySingleton<VerificationDataSource>(
      () => VerifiyDataSourceImpl(getIt<ApiService>()));

  getIt.registerFactoryParam<VerificationRepo, String, String?>(
      (param1, param2) => VerifyRepoImpl(
            dataSource: getIt<VerificationDataSource>(),
            sendTo: param1,
          ));
//auth
  ////
  getIt.registerLazySingleton<AuthDataSource>(
      () => AuthDataSourceImpl(getIt<ApiService>()));
  getIt.registerLazySingleton<AuthRepo>(
      () => AuthRepoImpl(getIt<AuthDataSource>()));
  getIt.registerLazySingleton<LoginUserUseCase>(
      () => LoginUserUseCase(getIt<AuthRepo>()));
  getIt.registerLazySingleton<RegisterUserUseCase>(
      () => RegisterUserUseCase(getIt<AuthRepo>()));

  getIt.registerLazySingleton<VerificationDataSource>(
      instanceName: "checkphone",
      () => CheckPhoneDataSourceImpl(getIt<ApiService>()));

//Forget Password
  getIt.registerLazySingleton<VerificationDataSource>(
      instanceName: "forget",
      () => ForgetVerifiyDataSourceImpl(getIt<ApiService>()));

  getIt.registerLazySingleton<ForgetDataSource>(
      () => ForgetDataSourceImpl(getIt<ApiService>()));

  getIt.registerFactoryParam<VerificationRepo, String, Map<String, dynamic>>(
      instanceName: "checkphone",
      (param1, param2) => CheckPhoneRepo(
            data: param2,
            dataSource: getIt<VerificationDataSource>(
              instanceName: "checkphone",
            ),
            sendTo: param1,
          ));

  getIt.registerFactoryParam<VerificationRepo, String, String?>(
      instanceName: "forget",
      (param1, param2) => ForgetVerificationRepo(
            dataSource: getIt<VerificationDataSource>(
              instanceName: "forget",
            ),
            sendTo: param1,
          ));

  getIt.registerFactoryParam<ForgetPasswordRepo, String, String?>(
      (param1, param2) => ForgetPasswordRepoImpl(
            dataSource: getIt<ForgetDataSource>(),
            code: param1,
            sendTo: param2!,
          ));
// upload
  getIt.registerLazySingleton<UploadFileDataSource>(
      () => UploadFileDataSourceImpl(getIt<ApiService>())); // upload
  getIt.registerLazySingleton<UploadFileRepo>(
      () => UploadFileRepoImpl(getIt<UploadFileDataSource>()));
  getIt.registerLazySingleton<UploadFileUseCase>(
      () => UploadFileUseCase(getIt<UploadFileRepo>()));
  //update_profile
  getIt.registerLazySingleton<UpdateProfileDataSource>(
      () => UpdateProfileDataSourceImpl(getIt<ApiService>()));
  getIt.registerLazySingleton<UpdateProfileRepo>(
      () => UpdateProfileRepoImpl(getIt<UpdateProfileDataSource>()));
  getIt.registerLazySingleton<UpdateProfileUseCase>(
      () => UpdateProfileUseCase(getIt<UpdateProfileRepo>()));
}
