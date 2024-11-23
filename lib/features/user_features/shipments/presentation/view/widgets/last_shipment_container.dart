import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:taiseer/features/user_features/shipments/data/models/shipment_model.dart';
import 'package:taiseer/features/user_features/shipments/presentation/view/widgets/shipment_dialog.dart';
import '../../../../../../config/app_font.dart';
import 'custom_stepper_widget.dart';
import '../../../../user_company/presentation/view/widgets/company_container.dart';

class LastShipmentContainer extends StatelessWidget {
  final ShipmentModel shipment;

  const LastShipmentContainer({
    super.key,
    required this.shipment,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        showShipmentDialog(context,order: shipment);
      },
      child: Container(
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
                        " : ${shipment.id.toString()}",
                        style: AppFont.font16W700Black,
                      )
                    ],
                  ),
                  Row(
                    children: [
                      RichText(
                          text: TextSpan(children: [
                        TextSpan(
                            text: shipment.expectedDeliveryDate,
                            style: AppFont.font16W600Black),
                      ])),
                    ],
                  )
                ],
              ),
              Gap(10.h),
              const CustomStepperWidget(status: 1),
              /// add company container
              CompanyContainer(companyModel: shipment.company!)
            ],
          ),
        ),
      ),
    );
  }
}
