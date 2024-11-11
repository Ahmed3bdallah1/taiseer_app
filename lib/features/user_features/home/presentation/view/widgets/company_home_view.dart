import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:learning/config/app_font.dart';
import 'package:learning/features/user_features/order/presentation/view/widgets/filter_bottom_sheet.dart';
import 'package:learning/features/user_features/user_company/presentation/view/all_companies_screen.dart';
import 'package:learning/ui/shared_widgets/custom_filled_button.dart';
import 'package:learning/ui/shared_widgets/custom_text_field.dart';
import 'package:learning/ui/shared_widgets/fade_in_animation.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:shimmer/shimmer.dart';
import '../../../../../../ui/shared_widgets/custom_outlined_button.dart';
import '../../../../search/presentation/view/search_view.dart';
import '../../../../user_company/presentation/mangers/fetch_company_provider.dart';
import '../../../../user_company/presentation/view/widgets/company_container.dart';

enum FilterTypes { top, less }

final filterProvider = StateProvider<FilterTypes>((ref) => FilterTypes.top);

class UserHomeCompanyView extends StatelessWidget {
  const UserHomeCompanyView({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, _) {
        final companies = ref.watch(fetchUserCompaniesViewProvider);
        // final isShowed = ref.watch(hideNavBarProvider2);
        return Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // isShowed
            //     ? FadeInAnimation(
            //         delay: 1.2,
            //         direction: FadeInDirection.rightToLeft,
            //         fadeOffset: 50,
            //         child: CustomTextField(
            //           formControlName: "name",
            //           hintText: "ادخل اسم الشركة",
            //           onEditDone: () => ref
            //               .read(
            //                   hideNavBarProvider2.notifier)
            //               .state = false,
            //         ),
            //       )
            //     : SizedBox(
            //         height: 56.h,
            //         child: Row(
            //           children: [
            //             Expanded(
            //               child: CustomOutlinedButton(
            //                 onPressed: () => ref
            //                     .read(hideNavBarProvider2
            //                         .notifier)
            //                     .state = true,
            //                 text: "Search".tr,
            //                 height: 48.h,
            //                 isExpanded: true,
            //                 textSize: 14,
            //                 widget: const Icon(
            //                   Icons.search,
            //                   color: AppColor.primary,
            //                 ),
            //               ),
            //             ),
            //             Gap(10.w),
            //             Expanded(
            //               child: CustomFilledButton(
            //                 text: "Request order".tr,
            //                 height: 48.h,
            //                 isExpanded: true,
            //                 widget: const Icon(
            //                   Icons
            //                       .delivery_dining_outlined,
            //                   color: Colors.white,
            //                 ),
            //                 textSize: 14,
            //               ),
            //             )
            //           ],
            //         ),
            //       ),
            SizedBox(
              height: 56.h,
              child: Row(
                children: [
                  Expanded(
                    child: CustomOutlinedButton(
                      onPressed: () => Get.to(() => const SearchUserView()),
                      text: "Search".tr,
                      height: 48.h,
                      isExpanded: true,
                      textSize: 14,
                      widget: const Icon(
                        Icons.search,
                        color: AppColor.primary,
                      ),
                    ),
                  ),
                  Gap(10.w),
                  Expanded(
                    child: CustomFilledButton(
                      onPressed: () => Get.to(() => const AllCompaniesScreen()),
                      text: "Request order".tr,
                      height: 48.h,
                      isExpanded: true,
                      widget: const Icon(
                        Icons.delivery_dining_outlined,
                        color: Colors.white,
                      ),
                      textSize: 14,
                    ),
                  )
                ],
              ),
            ),
            Gap(20.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Shipping companies".tr,
                  style: AppFont.font20W700Black,
                ),
                DropdownButton<FilterTypes>(
                  items: [
                    ...FilterTypes.values.map(
                      (e) => DropdownMenuItem<FilterTypes>(
                        value: e,
                        child: Text(e.name.tr),
                      ),
                    )
                  ],
                  onChanged: (value) {
                    ref.read(filterProvider.notifier).state = value!;
                  },
                  value: ref.watch(filterProvider),
                ),
                // CustomOutlinedButton(
                //   text: "filter".tr,
                //   height: 40.h,
                //   width: 90.w,
                //   textSize: 14,
                //   onPressed: () => showFilterBottomSheet(context,
                //       type: FilterSheetType.filterCompanies),
                //   widget: const Icon(
                //     Icons.filter_alt_outlined,
                //     color: AppColor.primary,
                //     size: 16,
                //   ),
                // )
              ],
            ),
            Gap(20.h),
            companies.customWhen(
                ref: ref,
                refreshable: fetchUserCompaniesViewProvider.future,
                data: (companyModelList) {
                  return ListView.separated(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        return FadeInAnimation(
                          direction: FadeInDirection.rightToLeft,
                          fadeOffset: 40,
                          delay: index.toDouble() + 1,
                          child: CompanyContainer(
                            companyModel: companyModelList[index],
                          ),
                        );
                      },
                      separatorBuilder: (context, index) {
                        return Gap(20.h);
                      },
                      itemCount: companyModelList.length);
                },
                loading: () {
                  return Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Row(
                      //   children: [
                      //     Shimmer.fromColors(
                      //       baseColor: Colors.grey[900]!,
                      //       highlightColor: Colors.green[100]!,
                      //       child: Container(
                      //         height: 40.h,
                      //         width: MediaQuery.of(context).size.width * .4,
                      //         decoration: BoxDecoration(
                      //           color: Colors.grey.withOpacity(.15),
                      //           borderRadius: BorderRadius.circular(35),
                      //         ),
                      //       ),
                      //     ),
                      //     Gap(20.w),
                      //     Shimmer.fromColors(
                      //       baseColor: Colors.grey[900]!,
                      //       highlightColor: Colors.green[100]!,
                      //       child: Container(
                      //         height: 40.h,
                      //         width: MediaQuery.of(context).size.width * .4,
                      //         decoration: BoxDecoration(
                      //           color: Colors.grey.withOpacity(.15),
                      //           borderRadius: BorderRadius.circular(35),
                      //         ),
                      //       ),
                      //     ),
                      //   ],
                      // ),
                      // Gap(20.h),
                      // Shimmer.fromColors(
                      //   baseColor: Colors.grey[900]!,
                      //   highlightColor: Colors.green[100]!,
                      //   child: Container(
                      //     height: 30,
                      //     width: MediaQuery.of(context).size.width * .4,
                      //     decoration: BoxDecoration(
                      //       color: Colors.grey.withOpacity(.15),
                      //       borderRadius: BorderRadius.circular(35),
                      //     ),
                      //   ),
                      // ),
                      // Gap(20.h),
                      ListView.builder(
                        shrinkWrap: true,
                        itemCount: 5,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Shimmer.fromColors(
                              baseColor: Colors.grey[900]!,
                              highlightColor: Colors.green[100]!,
                              child: Container(
                                height: 80,
                                width: MediaQuery.of(context).size.width,
                                decoration: BoxDecoration(
                                  color: Colors.grey.withOpacity(.15),
                                  borderRadius: BorderRadius.circular(15),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ],
                  );
                }),
          ],
        );
      },
    );
  }
}
