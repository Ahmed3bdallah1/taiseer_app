import 'package:animated_size_and_fade/animated_size_and_fade.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:taiseer/config/app_font.dart';
import 'package:taiseer/features/user_features/home/presentation/view/widgets/company_home_view.dart';
import 'package:taiseer/features/user_features/shipments/presentation/view/make_shipment_screen.dart';
import 'package:taiseer/features/user_features/user_company/domain/use_case/company_use_case.dart';
import 'package:taiseer/features/user_features/user_company/presentation/mangers/fetch_company_provider.dart';
import 'package:taiseer/features/user_features/user_company/presentation/view/widgets/company_container.dart';
import 'package:taiseer/ui/shared_widgets/custom_filled_button.dart';
import 'package:tuple/tuple.dart';
import '../../../../../gen/assets.gen.dart';
import '../../../../../main.dart';
import '../../../../../ui/shared_widgets/custom_logo_app_bar.dart';
import '../../../../../ui/shared_widgets/hide_nav_bar_widget.dart';
import '../../../../../ui/shared_widgets/image_or_svg.dart';
import '../../../../../ui/shared_widgets/not_found_widget.dart';
import '../../../../../ui/shared_widgets/select_language_tile.dart';
import '../../data/model/company_details_model.dart';
import '../../data/model/company_model.dart';
import 'widgets/company_shimmer_widget.dart';

final companyDetails = StateProvider<CompanyDetailsModel?>((ref) => null);

class AllCompaniesScreen extends ConsumerStatefulWidget {
  const AllCompaniesScreen({super.key});

  @override
  ConsumerState<AllCompaniesScreen> createState() => _AllCompaniesScreenState();
}

class _AllCompaniesScreenState extends ConsumerState<AllCompaniesScreen> {
  final PagingController<int, UserCompanyModel2> _pagingController =
      PagingController(firstPageKey: 1);

  Future<void> _fetchPage(int pageKey) async {
    final response = await getIt<FetchUserCompanyUseCase>()
        .call(Tuple2(ref.watch(filterProvider).name, pageKey));
    response.fold((l) {
      _pagingController.error = l;
    }, (r) {
      final isLastPage = r.total < 15;
      if (isLastPage) {
        _pagingController.appendLastPage(r.data);
      } else {
        final nextPageKey = pageKey + 1;
        _pagingController.appendPage(r.data, nextPageKey);
      }
    });
  }

  final ScrollController scrollController = ScrollController();
  late final AutoDisposeStateProvider<bool> hideNavBarProvider2;
  UserCompanyModel2? companyModel;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _pagingController.addPageRequestListener((pageKey) {
      _fetchPage(pageKey);
    });
    hideNavBarProvider2 = StateProvider.autoDispose<bool>((ref) {
      return false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.primaryWhite,
      appBar: CustomLogoAppbar(
        customTitleWidget: ImageOrSvg(
          Assets.base.tayseerLogo.path,
          isLocal: true,
          height: 65.h,
        ),
        scrollController: scrollController,
        isCenterTitle: false,
        hideBackButton: false,
        buttonWidget: const Padding(
          padding: EdgeInsets.only(bottom: 8, top: 2),
          child: SelectLanguageTile(),
        ),
      ),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16),
            child: Column(
              children: [
                AnimatedSizeAndFade.showHide(
                    show: !ref.watch(hideNavBarProvider2),
                    child: Row(
                      children: [
                        Gap(10.w),
                        Text(
                          "Our Sponsored Companies".tr,
                          style: AppFont.font18W700Black,
                        ),
                      ],
                    )),
                Gap(10.h),
                Expanded(
                  child: HideNavBarWidget(
                    customProvider: hideNavBarProvider2,
                    child: Consumer(builder: (context, ref, _) {
                      final historyList =
                          ref.watch(fetchUserCompaniesViewProvider(1));
                      final res = ref
                          .watch(fetchUserCompanyDetailsViewProvider(
                              companyModel?.id ?? 0))
                          .valueOrNull;
                      Future.delayed(const Duration(seconds: 1)).then((_) {
                        ref.read(companyDetails.notifier).state = res;
                      });
                      return historyList.customWhen(
                          ref: ref,
                          refreshable: fetchUserCompaniesViewProvider(1).future,
                          data: (companyData) {
                            if (companyData.data.isEmpty) {
                              return NotFoundWidget(
                                  title: "No Companies right now.!".tr);
                            }
                            companyModel = companyData.data.first;
                            return Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 16),
                              child: PagedListView<int, UserCompanyModel2>.separated(
                                pagingController: _pagingController,
                                separatorBuilder: (context, index) => Gap(10.h),
                                builderDelegate: PagedChildBuilderDelegate<UserCompanyModel2>(
                                  itemBuilder: (context, company, index) {
                                    return CompanyContainer(companyModel: company);
                                  },
                                  animateTransitions: true,
                                  firstPageProgressIndicatorBuilder: (context) {
                                    return const Column(
                                      children: [
                                        CompanyShimmerWidget(),
                                        CompanyShimmerWidget(),
                                        CompanyShimmerWidget(),
                                        CompanyShimmerWidget(),
                                        CompanyShimmerWidget(),
                                        CompanyShimmerWidget(),
                                      ],
                                    );
                                  },
                                  firstPageErrorIndicatorBuilder: (context) =>
                                      Center(
                                          child: Text('Error loading data'.tr)),
                                  newPageErrorIndicatorBuilder: (context) =>
                                      Center(
                                          child: Text(
                                              'Error loading more data'.tr)),
                                ),
                              ),
                            );
                          },
                      );
                    }),
                  ),
                ),
                // Expanded(
                //   child: HideNavBarWidget(
                //     customProvider: hideNavBarProvider2,
                //     child: Consumer(builder: (context, ref, _) {
                //       final companies =
                //           ref.watch(fetchUserCompaniesViewProvider(1));
                //       final res= ref
                //           .watch(fetchUserCompanyDetailsViewProvider(
                //           companyModel?.id ?? 0))
                //           .valueOrNull;
                //       Future.delayed(const Duration(seconds: 1)).then((_){
                //         ref.read(companyDetails.notifier).state = res;
                //       });
                //       return companies.customWhen(
                //           ref: ref,
                //           refreshable: fetchUserCompaniesViewProvider(1).future,
                //           data: (companiesData) {
                //             if (companiesData.isEmpty) {
                //               return NotFoundWidget(
                //                   title: "No Companies right now.!".tr);
                //             }
                //             companyModel = companiesData.first;
                //             return Padding(
                //               padding:
                //                   const EdgeInsets.symmetric(horizontal: 20),
                //               child: ListView.separated(
                //                   itemBuilder: (context, index) {
                //                     return CompanyContainer(
                //                         companyModel: companiesData[index]);
                //                   },
                //                   separatorBuilder: (context, index) {
                //                     return const Gap(10);
                //                   },
                //                   itemCount: companiesData.length),
                //             );
                //           },
                //           loading: () {
                //             return ListView.builder(
                //               shrinkWrap: true,
                //               itemCount: 6,
                //               itemBuilder: (context, index) {
                //                 return Shimmer.fromColors(
                //                   baseColor: Colors.grey[900]!,
                //                   highlightColor: Colors.green[100]!,
                //                   child: Container(
                //                     height: 100,
                //                     width: MediaQuery.of(context).size.width,
                //                     decoration: BoxDecoration(
                //                       color: Colors.grey.withOpacity(.15),
                //                       borderRadius: BorderRadius.circular(35),
                //                     ),
                //                   ),
                //                 );
                //               },
                //             );
                //           });
                //     }),
                //   ),
                // )
              ],
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              height: 150,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.transparent, AppColor.black.withOpacity(.6)],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: CustomFilledButton(
                    onPressed: () async {
                      if (ref.watch(companyDetails) != null) {
                        Get.to(() => MakeShipmentScreen(
                            isGlobal: true,
                            companyDetailsModel: ref.watch(companyDetails)!,
                            companyModel: companyModel!));
                      }
                    },
                    text: "Skip".tr,
                    color: Colors.white,
                    fontColor: Colors.black,
                    isValid: ref.watch(companyDetails) != null,
                    height: 48.h,
                    isExpanded: true,
                    textSize: 14,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
