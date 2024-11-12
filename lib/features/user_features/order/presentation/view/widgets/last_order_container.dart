import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:taiseer/features/user_features/order/presentation/view/widgets/custom_stepper_widget.dart';
import 'package:taiseer/ui/shared_widgets/image_or_svg.dart';
import '../../../../../../config/app_font.dart';
import '../../../../user_company/presentation/view/widgets/company_container.dart';
import '../../../domain/entity/order_entity.dart';

class LastOrderContainer extends StatelessWidget {
  final OrderEntity orderEntity;

  const LastOrderContainer({
    super.key,
    required this.orderEntity,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: AppColor.primary.withOpacity(.4), width: 1.8),
        borderRadius: BorderRadius.circular(14.r),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 26, vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Text(
                      "order number".tr,
                      style: AppFont.font14W500Black,
                    ),
                    Text(
                      " : ${orderEntity.id.toString()}",
                      style: AppFont.font16W700Black,
                    )
                  ],
                ),
                Row(
                  children: [
                    RichText(
                        text: TextSpan(children: [
                      TextSpan(
                          text: orderEntity.subTotal,
                          style: AppFont.font16W600Black),
                      TextSpan(text: " ".tr, style: AppFont.font15W700Black),
                      TextSpan(text: "SR".tr, style: AppFont.font14W500Black),
                    ])),
                  ],
                )
              ],
            ),
            Gap(10.h),
            CustomStepperWidget(status: orderEntity.status.id),

            /// add company container
            // CompanyContainer(companyModel: orderEntity.companyModel)
            // if (orderEntity.status.id == 2)
            //   InkWell(
            //     // onTap: () => Get.to(),
            //     child: Container(
            //       width: 150.w,
            //       decoration: BoxDecoration(
            //         color: Colors.indigoAccent,
            //         borderRadius: BorderRadius.circular(20),
            //       ),
            //       child: Padding(
            //         padding: const EdgeInsets.symmetric(
            //             vertical: 10, horizontal: 15),
            //         child: Row(
            //           mainAxisAlignment: MainAxisAlignment.center,
            //           children: [
            //             Text(
            //               "Installment".tr,
            //               style: AppFont.font14W500White,
            //             ),
            //             const Gap(10),
            //             const Icon(
            //               CupertinoIcons.arrow_up_left,
            //               color: Colors.white,
            //             )
            //           ],
            //         ),
            //       ),
            //     ),
            //   )
          ],
        ),
      ),
    );
  }
}
