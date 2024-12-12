import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:taiseer/config/app_font.dart';
import 'package:taiseer/features/user_features/shipments/presentation/view/widgets/custom_stepper_widget.dart';
import 'package:taiseer/gen/assets.gen.dart';
import 'package:taiseer/ui/shared_widgets/custom_filled_button.dart';
import 'package:taiseer/ui/shared_widgets/custom_outlined_button.dart';

// void showOrderDialog(BuildContext context,{OrderEntity? order}) {
//   showDialog(
//     context: context,
//     builder: (BuildContext context) {
//       return Dialog(
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(12),
//         ),
//         child: Container(
//           width: MediaQuery.of(context).size.width,
//           padding: const EdgeInsets.all(16.0),
//           child: Column(
//             mainAxisSize: MainAxisSize.min,
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Row(
//                 children: [
//                   CircleAvatar(
//                       radius: 30,
//                       child: Image.asset(Assets.base.personal.path)),
//                   Gap(6.w),
//                   Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Row(
//                         children: [
//                           Text('Ahmed Al-Sayed',
//                               style: AppFont.font16W600Black),
//                           const Gap(10),
//                           const Text('12gh7s#')
//                         ],
//                       ),
//                       const Gap(6),
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           Container(
//                             height: 20,
//                             width: 60,
//                             decoration: BoxDecoration(
//                                 color: AppColor.green1.withOpacity(.3),
//                                 border: Border.all(color: AppColor.green1),
//                                 borderRadius: BorderRadius.circular(12)),
//                           ),
//                           Gap(10),
//                           Container(
//                             height: 20,
//                             width: 60,
//                             decoration: BoxDecoration(
//                                 color: AppColor.green1.withOpacity(.3),
//                                 border: Border.all(color: AppColor.green1),
//                                 borderRadius: BorderRadius.circular(12)),
//                           ),
//                           Gap(10),
//                           Container(
//                             height: 20,
//                             width: 60,
//                             decoration: BoxDecoration(
//                                 color: AppColor.green1.withOpacity(.3),
//                                 border: Border.all(color: AppColor.green1),
//                                 borderRadius: BorderRadius.circular(12)),
//                           ),
//                         ],
//                       )
//                     ],
//                   ),
//                 ],
//               ),
//               Gap(10.h),
//               const CustomStepperWidget(status: 2),
//               Gap(10.h),
//               Row(
//                 children: [
//                   const Flexible(
//                     child: Text(
//                       'Package description goes here. More details will be handled by the company representative.',
//                       maxLines: 6,
//                       overflow: TextOverflow.ellipsis,
//                     ),
//                   ),
//                   const SizedBox(width: 8),
//                   ClipRRect(
//                     borderRadius: BorderRadius.circular(8.0),
//                     child: Image.network(
//                       'https://via.placeholder.com/50',
//                       height: 100,
//                       width: 100,
//                       fit: BoxFit.cover,
//                     ),
//                   ),
//                 ],
//               ),
//               Padding(
//                 padding: EdgeInsets.symmetric(vertical: 10.h),
//                 child: Divider(
//                   color: AppColor.grey1,
//                   thickness: 1,
//                 ),
//               ),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Expanded(
//                     child: CustomFilledButton(
//                       onPressed: () {
//                         Navigator.of(context).pop();
//                       },
//                       height: 50,
//                       text: 'Track'.tr,
//                       isExpanded: true,
//                       widget: Icon(CupertinoIcons.location),
//                     ),
//                   ),
//                   Gap(10.w),
//                   Expanded(
//                     child: CustomOutlinedButton(
//                       onPressed: () {
//                         Navigator.of(context).pop();
//                       },
//                       height: 50,
//                       isExpanded: true,
//                       text: "Details".tr,
//                       widget: Icon(Icons.info_outline),
//                     ),
//                   ),
//                 ],
//               ),
//             ],
//           ),
//         ),
//       );
//     },
//   );
// }
