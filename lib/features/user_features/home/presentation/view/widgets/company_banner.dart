import 'package:flutter/cupertino.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import '../../../../../../config/app_font.dart';
import '../../../../../../core/service/localization_service/localization_service.dart';
import '../../../../../../ui/shared_widgets/image_or_svg.dart';
import '../../../../user_company/data/model/company_details_model.dart';

class CompanyDetailsBanner extends StatelessWidget {
  final CompanyDetailsModel companyModel;

  const CompanyDetailsBanner({super.key, required this.companyModel});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: AppColor.white,
          border: Border.all(color: AppColor.grey1),
          borderRadius: BorderRadius.circular(24.r)),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                border: Border.all(color: AppColor.grey1),
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Padding(
                padding: const EdgeInsets.all(14),
                child: Row(
                  children: [
                    ImageOrSvg(
                      companyModel.logo, height: 65.h,
                      isCompanyImage: true,
                      width: 65.h,
                      // assetImageOnNull: Assets.onboard.vector,
                      pickImageOnNull: true,
                    ),
                    Gap(10.w),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          localeService.isArabic
                              ? companyModel.nameAr ?? ""
                              : companyModel.nameEn ?? "",
                          style: AppFont.font20W600Black,
                          textAlign: TextAlign.center,
                        ),
                        Gap(14.h),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            ...companyModel.typeActivityCompanies.map(
                              (e) => Wrap(
                                spacing: 6.w,
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                        color: AppColor.primary.withOpacity(.2),
                                        border:
                                            Border.all(color: AppColor.primary),
                                        borderRadius:
                                            BorderRadius.circular(12.r)),
                                    child: Padding(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: 12.w,
                                        vertical: 2.h,
                                      ),
                                      child: Text(
                                        localeService.isArabic
                                            ? e.typeActivities?.infoAr ?? ""
                                            : e.typeActivities?.infoEn ?? "",
                                        style: AppFont.font10w400Primary,
                                      ),
                                    ),
                                  ),
                                  Gap(2.w)
                                ],
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Gap(10.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12.r),
                    border: Border.all(color: AppColor.grey1),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(
                              CupertinoIcons.star,
                              color: AppColor.orange,
                            ),
                            Gap(30.w),
                            Text(
                              companyModel.averageRating!=null?companyModel.averageRating.toString().substring(0,3):"0",
                              style: AppFont.font20W600Black,
                            )
                          ],
                        ),
                        Gap(10.h),
                        Text(
                          "Ratings".tr,
                          style: AppFont.font14W600Black,
                        )
                      ],
                    ),
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12.r),
                    border: Border.all(color: AppColor.grey1),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            const Icon(
                              CupertinoIcons.hand_thumbsup,
                              color: AppColor.green,
                            ),
                            Gap(30.w),
                            Text(
                              companyModel.followersCount.toString(),
                              style: AppFont.font20W600Black,
                            )
                          ],
                        ),
                        Gap(10.h),
                        Text(
                          "Likes".tr,
                          style: AppFont.font14W600Black,
                        )
                      ],
                    ),
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12.r),
                    border: Border.all(color: AppColor.grey1),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            const Icon(
                              FontAwesomeIcons.ship,
                              color: AppColor.primary,
                            ),
                            Gap(30.w),
                            Text(
                              companyModel.typeActivityCompanies[0].companyId
                                  .toString(),
                              style: AppFont.font20W600Black,
                            )
                          ],
                        ),
                        Gap(10.h),
                        Text(
                          "Shipments".tr,
                          style: AppFont.font14W600Black,
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
