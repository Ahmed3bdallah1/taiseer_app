import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:taiseer/config/app_font.dart';
import 'package:taiseer/core/service/localization_service/localization_service.dart';
import 'package:taiseer/features/user_features/home/domain/entities/loan_details_entity.dart';
import 'package:taiseer/features/user_features/home/presentation/view/details_screen.dart';
import 'package:taiseer/features/user_features/shipments/data/models/shipment_model.dart';
import 'package:taiseer/ui/shared_widgets/container_button.dart';
import 'package:taiseer/ui/shared_widgets/image_or_svg.dart';
import '../../../../../../gen/assets.gen.dart';
import '../../../data/model/company_model.dart';

class CompanyContainer extends StatelessWidget {
  final bool? isDisabled;
  final bool? hideButton;
  final UserCompanyModel2 companyModel;
  final ShipmentModel? shipmentModel;

  const CompanyContainer(
      {super.key,
      required this.companyModel,
      this.isDisabled,
      this.hideButton,
      this.shipmentModel});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: isDisabled == true
          ? () {}
          : () {
              Get.to(
                DetailsScreen(userCompanyModel2: companyModel),
              );
            },
      child: Container(
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          color: AppColor.whiteOrGrey,
          borderRadius: BorderRadius.circular(12.r),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 16.h),
          child: Row(
            children: [
              ImageOrSvg(
                companyModel.logo ?? "",
                isCompanyImage: true,
                height: 60.h,
                width: 60.h,
              ),
              Gap(10.w),
              Expanded(
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          localeService.isArabic
                              ? companyModel.nameAr
                              : companyModel.nameEn,
                          style: AppFont.font16W600Black,
                        ),
                        Container(
                          decoration: BoxDecoration(
                              color: Colors.black,
                              borderRadius: BorderRadius.circular(12)),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 4, vertical: 3),
                            child: Row(
                              children: [
                                Text(
                                  companyModel.averageRating
                                      .toString()
                                      .substring(0, 3),
                                  style: AppFont.font12W600White,
                                ),
                                Gap(4.w),
                                Icon(
                                  CupertinoIcons.star_fill,
                                  color: AppColor.gold,
                                  size: 15,
                                )
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                    Gap(10.h),
                    if (shipmentModel != null)
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          ...shipmentModel!.typeActivity!.map(
                            (e) => Container(
                              decoration: BoxDecoration(
                                  color: AppColor.primary.withOpacity(.15),
                                  borderRadius: BorderRadius.circular(12.r),
                                  border: Border.all(color: AppColor.primary)),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 12, vertical: 2),
                                child: Text(
                                  localeService.isArabic
                                      ? e.infoAr ?? ""
                                      : e.infoEn ?? "",
                                  style: AppFont.font10w400Primary,
                                ),
                              ),
                            ),
                          ),
                          if (shipmentModel!.typeActivity!.isEmpty)
                            Row(
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                      color: AppColor.primary.withOpacity(.15),
                                      borderRadius: BorderRadius.circular(12.r),
                                      border:
                                          Border.all(color: AppColor.primary)),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 12, vertical: 2),
                                    child: Text(
                                      shipmentModel?.status ?? "",
                                      style: AppFont.font10w400Primary,
                                    ),
                                  ),
                                ),
                                Gap(10.w),
                                Container(
                                  decoration: BoxDecoration(
                                      color: AppColor.green.withOpacity(.15),
                                      borderRadius: BorderRadius.circular(12.r),
                                      border: Border.all(color: AppColor.green)),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 12, vertical: 2),
                                    child: Text(
                                      shipmentModel?.company?.email ?? "",
                                      style: AppFont.font10w400Primary
                                          .copyWith(color: AppColor.green),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                        ],
                      ),
                    if (companyModel.typeActivityCompanies!.isNotEmpty)
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          ...companyModel.typeActivityCompanies!.map(
                            (e) => Container(
                              decoration: BoxDecoration(
                                  color: AppColor.primary.withOpacity(.15),
                                  borderRadius: BorderRadius.circular(12.r),
                                  border: Border.all(color: AppColor.primary)),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 12, vertical: 2),
                                child: Text(
                                  localeService.isArabic
                                      ? e.typeActivities?.infoAr ?? ""
                                      : e.typeActivities?.infoEn ?? "",
                                  style: AppFont.font10w400Primary,
                                ),
                              ),
                            ),
                          )
                        ],
                      )
                  ],
                ),
              ),
              if (hideButton == false) Gap(10.w),
              if (hideButton == false)
                ContainerButton(
                  size: 55.h,
                  icon: Icons.arrow_forward_ios,
                  color: AppColor.grey1.withOpacity(.3),
                )
            ],
          ),
        ),
      ),
    );
  }
}
