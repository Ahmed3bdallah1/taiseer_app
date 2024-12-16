import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../../../../../../config/app_color.dart';
import '../../../../../../gen/assets.gen.dart';
import '../../../../../../ui/shared_widgets/image_or_svg.dart';
import '../../../../user_company/data/model/company_model.dart';
import '../../../../user_company/presentation/view/widgets/company_container.dart';

class ShipmentHeaderWidget extends StatelessWidget {
  final bool isGlobal;
  final UserCompanyModel2 companyModel;

  const ShipmentHeaderWidget(
      {super.key, required this.isGlobal, required this.companyModel});

  @override
  Widget build(BuildContext context) {
    return isGlobal
        ? SizedBox(
      height: 70,
      child: ListView.separated(
        itemCount: 5,
        scrollDirection: Axis.horizontal,
        separatorBuilder: (context, index) {
          return const Gap(2);
        },
        itemBuilder: (context, index) {
          return Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: index % 2 == 0
                  ? AppColor.grey1.withOpacity(.5)
                  : AppColor.grey_3.withOpacity(.5),
              borderRadius: BorderRadius.circular(12),
            ),
            child: ImageOrSvg(Assets.onboard.vector,
                isLocal: true, width: 60, height: 60),
          );
        },
      ),
    )
        : CompanyContainer(companyModel: companyModel);
  }
}
