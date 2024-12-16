import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:taiseer/config/app_font.dart';
import 'package:taiseer/features/user_features/home/presentation/managers/fetch_ads_provider.dart';
import 'package:taiseer/features/user_features/home/presentation/view/widgets/company_banner.dart';
import 'package:taiseer/features/user_features/home/presentation/view/widgets/silder_item_widget.dart';
import 'package:taiseer/features/user_features/shipments/presentation/view/make_shipment_screen.dart';
import 'package:taiseer/features/user_features/user_company/data/model/company_details_model.dart';
import 'package:taiseer/features/user_features/user_company/presentation/mangers/fetch_company_provider.dart';
import 'package:taiseer/main.dart';
import 'package:taiseer/ui/shared_widgets/custom_filled_button.dart';
import 'package:taiseer/ui/shared_widgets/custom_outlined_button.dart';
import 'package:taiseer/ui/shared_widgets/custom_logo_app_bar.dart';
import 'package:taiseer/ui/shared_widgets/image_or_svg.dart';
import 'package:taiseer/ui/shared_widgets/loading_widget.dart';
import 'package:taiseer/ui/ui.dart';
import '../../../../../core/service/localization_service/localization_service.dart';
import '../../../../../ui/shared_widgets/container_button.dart';
import '../../../../../ui/shared_widgets/custom_slider.dart';
import '../../../user_company/data/model/company_model.dart';
import '../../../user_company/domain/use_case/company_use_case.dart';
import '../../../user_company/presentation/view/shipping_method_tile.dart';
import '../../../user_company/presentation/view/widgets/comment_container.dart';

class DetailsScreen extends ConsumerStatefulWidget {
  final UserCompanyModel2 userCompanyModel2;

  const DetailsScreen({super.key, required this.userCompanyModel2});

  @override
  ConsumerState<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends ConsumerState<DetailsScreen> {
  // final controller = ScrollController();
  CompanyDetailsModel? companyDetailsModel;

  @override
  Widget build(BuildContext context) {
    final companyData = ref.watch(
        fetchUserCompanyDetailsViewProvider(widget.userCompanyModel2.id));
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.startTop,
      backgroundColor: AppColor.primaryWhite,
      body: companyData.customWhen(
          ref: ref,
          skipLoadingOnRefresh: true,
          refreshable:
              fetchUserCompanyDetailsViewProvider(widget.userCompanyModel2.id)
                  .future,
          data: (companyModel) {
            companyDetailsModel = companyModel;
            return SafeArea(
              child: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.only(bottom: 50.h),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 300.h,
                        width: MediaQuery.of(context).size.width,
                        child: Stack(
                          children: [
                            SizedBox(
                              height: 160.h,
                              width: MediaQuery.of(context).size.width,
                              child: ImageOrSvg(
                                companyModel.cover ?? "",
                                isCompanyImage: true,
                                pickImageOnNull: true,
                                fit: BoxFit.fitWidth,
                              ),
                            ),
                            Positioned(
                              top: 0,
                              left: 0,
                              right: 0,
                              child: CustomLogoAppbar(
                                applyPadding: true,
                                // scrollController: controller,
                                customTitleWidget: Text(
                                  localeService.isArabic
                                      ? companyModel.nameAr ?? ""
                                      : companyModel.nameEn ?? "",
                                  // companyModel.nameAr ?? "",
                                ),
                                // hideActions: true,
                                buttonWidget: Padding(
                                  padding: EdgeInsetsDirectional.only(start: 8.0),
                                  child: ContainerButton(
                                    color: Colors.transparent,
                                    size: 50,
                                    iconColor: AppColor.primary,
                                    icon: Icons.notifications_active_rounded,
                                    onTap: () {
                                      // UIHelper.showAlert("success".tr,type: DialogType.success,);
                                      UIHelper.showGlobalSnackBar(
                                        text: "Coming soon".tr,
                                      );
                                      ref.invalidate(
                                          fetchUserCompanyDetailsViewProvider(
                                              widget.userCompanyModel2.id));
                                    },
                                  ),
                                ),
                              ),
                            ),
                            Positioned(
                                top: 100.h,
                                left: 20.w,
                                right: 20.w,
                                child: CompanyDetailsBanner(
                                    companyModel: companyModel))
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 20.w, vertical: 6.h),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                const Icon(
                                  CupertinoIcons
                                      .slider_horizontal_below_rectangle,
                                  color: AppColor.primary,
                                ),
                                Gap(5.w),
                                Text(
                                  "Sponsors ".tr,
                                  style: AppFont.font18W700Black,
                                ),
                                Text(
                                  localeService.isArabic
                                      ? companyModel.nameAr ?? ""
                                      : companyModel.nameEn ?? "",
                                  style: AppFont.font18W700Black,
                                )
                              ],
                            ),
                            CustomSlider(
                              ref
                                  .watch(fetchAdsProvider)
                                  .value!
                                  .map((e) => SliderItem(e))
                                  .toList(),
                              // height: 170.h,
                              autoPlay: true,
                              onPageChanged: (index, _) {
                                ref.read(sliderIndexProvider.notifier).state =
                                    index;
                              },
                            ),
                            Gap(20.h),
                            Row(
                              children: [
                                const Icon(
                                  CupertinoIcons.info,
                                  color: AppColor.primary,
                                ),
                                Gap(5.w),
                                Text(
                                  "About company".tr,
                                  style: AppFont.font18W700Black,
                                ),
                              ],
                            ),
                            Gap(10.h),
                            Text(
                              localeService.isArabic
                                  ? companyModel.aboutAr ?? ""
                                  : companyModel.aboutEn ?? "",
                              style: AppFont.font14W500Grey2,
                              textAlign: TextAlign.start,
                            ),
                            Gap(20.h),
                            Row(
                              children: [
                                const Icon(
                                  CupertinoIcons.info,
                                  color: AppColor.primary,
                                ),
                                Gap(5.w),
                                Text(
                                  "Shipping Options".tr,
                                  style: AppFont.font18W700Black,
                                ),
                              ],
                            ),
                            Gap(10.h),
                            SizedBox(
                              height: 90,
                              child: ListView.separated(
                                scrollDirection: Axis.horizontal,
                                itemBuilder: (context, index) {
                                  return ShippingMethodTile(
                                      color: AppColor.grey2,
                                      shippingMethodsEntity: companyModel
                                          .typeActivityCompanies[index]);
                                },
                                separatorBuilder: (context, index) {
                                  return const Gap(10);
                                },
                                itemCount:
                                    companyModel.typeActivityCompanies.length ??
                                        0,
                              ),
                            ),
                            Gap(20.h),
                            if (companyModel.rating.isNotEmpty)
                              Column(
                                children: [
                                  Row(
                                    children: [
                                      const Icon(
                                        Icons.comment,
                                        color: AppColor.primary,
                                      ),
                                      Gap(5.w),
                                      Text(
                                        "Users's opinions".tr,
                                        style: AppFont.font18W700Black,
                                      ),
                                    ],
                                  ),
                                  Gap(10.h),
                                  SizedBox(
                                    height: 150,
                                    child: ListView.separated(
                                        scrollDirection: Axis.horizontal,
                                        itemCount: companyModel.rating.length,
                                        separatorBuilder: (context, index) {
                                          return const Gap(10);
                                        },
                                        itemBuilder: (context, index) {
                                          if (companyModel.rating.isEmpty) {
                                            return Gap(10);
                                          }
                                          return CommentContainer(
                                              shippingMethods: companyModel
                                                  .typeActivityCompanies,
                                              commentsEntity:
                                                  companyModel.rating[index]);
                                        }),
                                  )
                                ],
                              )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          }),
      bottomSheet: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            Expanded(
              flex: 2,
              child: CustomFilledButton(
                  text: "Order".tr,
                  onPressed: () {
                    companyDetailsModel == null
                        ? null
                        : Get.to(() => MakeShipmentScreen(
                              companyDetailsModel: companyDetailsModel!,
                              companyModel: widget.userCompanyModel2,
                            ));
                  }),
            ),
            const Gap(10),
            Expanded(
              flex: 1,
              child: CustomOutlinedButton(
                // widget: Icon(
                //   companyDetailsModel?.isFollowed == 1
                //       ? Icons.remove
                //       : Icons.add,
                //   color: AppColor.primary,
                // ),
                textSize: 15.sp,
                text: companyDetailsModel?.isFollowed == 1
                    ? "Un Follow".tr
                    : "Follow".tr,
                onPressed: () async {
                  final res = await getIt<FollowCompanyUseCase>()
                      .call(companyDetailsModel?.id ?? 0);
                  res.fold((l) {
                    UIHelper.showGlobalSnackBar(
                        text: l.message.tr, color: AppColor.danger);
                  }, (r) {
                    UIHelper.showGlobalSnackBar(
                        text: r.tr, color: AppColor.green);
                    ref.invalidate(fetchUserCompanyDetailsViewProvider);
                  });
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
