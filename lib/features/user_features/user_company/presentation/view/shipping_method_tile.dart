import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:get/get_common/get_reset.dart';
import 'package:taiseer/config/app_font.dart';
import 'package:taiseer/ui/shared_widgets/image_or_svg.dart';
import '../../../../../core/service/localization_service/localization_service.dart';
import '../../domain/entity/shipping_methods_entity.dart';

class ShippingMethodTile extends StatelessWidget {
  final bool hideSelectedItem;
  final bool isSelected;
  final void Function()? onTap;
  final Color? color;
  final double? radius;
  final ShippingMethodsEntity shippingMethodsEntity;

  const ShippingMethodTile({
    super.key,
    required this.shippingMethodsEntity,
    this.hideSelectedItem = true,
    this.color,
    this.radius,
    this.onTap,
    this.isSelected = false,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsetsDirectional.only(top: 5, bottom: 5),
      child: hideSelectedItem
          ? Container(
              height: 80,
              width: 80,
              decoration: BoxDecoration(
                color: color,
                // image: DecorationImage(
                //     image:
                //         AssetImage(shippingMethodsEntity.backgroundImage ?? ""),
                //     fit: BoxFit.fill,
                //     opacity: .6),
                borderRadius: BorderRadius.circular(radius ?? 12.r),
              ),
              child: Stack(
                children: [
                  Positioned.fill(
                      child: ImageOrSvg(
                    shippingMethodsEntity.typeActivities?.imageBack ?? "",
                    // pickImageOnNull: false,
                    //     isCompanyImage: true,
                    fit: BoxFit.fill,
                  )),
                  Positioned(
                    top: 10,
                    right: 10,
                    child: ImageOrSvg(
                      shippingMethodsEntity.typeActivities?.imageFront ?? "",
                      color: AppColor.white,
                    ),
                  ),
                  Positioned(
                    bottom: 10,
                    right: 10,
                    child: Text(
                      localeService.isArabic
                          ? shippingMethodsEntity.typeActivities?.infoAr ?? ""
                          : shippingMethodsEntity.typeActivities?.infoEn ?? "",
                      style: AppFont.font12W600White,
                    ),
                  ),
                ],
              ),
            )
          : InkWell(
              onTap: onTap,
              child: Container(
                height: 80,
                width: 80,
                decoration: BoxDecoration(
                    color: color,
                    // image: DecorationImage(
                    //     image: AssetImage(
                    //         shippingMethodsEntity.backgroundImage ?? ""),
                    //     fit: BoxFit.fill,
                    //     opacity: .6),
                    borderRadius: BorderRadius.circular(radius ?? 12.r),
                    boxShadow: [
                      isSelected == true
                          ? const BoxShadow(
                              blurRadius: 2,
                              spreadRadius: 2,
                              color: AppColor.primary,
                            )
                          : const BoxShadow()
                    ]),
                child: Stack(
                  children: [
                    Positioned.fill(
                        child: ImageOrSvg(
                      shippingMethodsEntity.typeActivities?.imageBack ?? "",
                      // pickImageOnNull: true,
                      fit: BoxFit.fill,
                    )),
                    Positioned(
                      top: 10,
                      right: 10,
                      child: ImageOrSvg(
                        shippingMethodsEntity.typeActivities?.imageFront ?? "",
                        color: AppColor.white,
                      ),
                    ),
                    PositionedDirectional(
                      bottom: 10,
                      end: 10,
                      child: Text(
                        shippingMethodsEntity.typeActivities?.nameAr ?? "",
                        style: AppFont.font12W600White,
                      ),
                    ),
                    Positioned(
                      top: 10,
                      left: 10,
                      child: isSelected == false
                          ? Icon(
                              size: 14,
                              CupertinoIcons.circle,
                              color: AppColor.white,
                            )
                          : const Icon(
                              size: 14,
                              Icons.circle,
                              color: AppColor.primary,
                            ),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}

class FastShippingMethodTile extends StatelessWidget {
  final bool isSelected;
  final void Function()? onTap;
  final Color? color;
  final double? radius;

  const FastShippingMethodTile({
    super.key,
    this.color,
    this.radius,
    this.onTap,
    this.isSelected = false,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsetsDirectional.only(top: 5, bottom: 5, end: 5),
      child: InkWell(
        onTap: onTap,
        child: Container(
          height: 80,
          width: 80,
          decoration: BoxDecoration(
              color: AppColor.whiteOrGrey,
              borderRadius: BorderRadius.circular(radius ?? 12.r),
              border: Border.all(color: Colors.grey),
              boxShadow: [
                isSelected == true
                    ? const BoxShadow(
                        blurRadius: 2,
                        spreadRadius: 2,
                        color: AppColor.primary,
                      )
                    : const BoxShadow()
              ]),
          child: Stack(
            children: [
              Positioned(
                top: 10,
                right: 10,
                child: Icon(
                  FontAwesomeIcons.truckFast,
                  color: AppColor.black,
                  size: 20,
                ),
              ),
              Positioned(
                bottom: 10,
                right: 10,
                child: Text(
                  "Fast Shipping".tr,
                  style: AppFont.font10w400Black,
                ),
              ),
              Positioned(
                top: 10,
                left: 10,
                child: isSelected == false
                    ? Icon(
                        size: 14,
                        CupertinoIcons.circle,
                        color: AppColor.black,
                      )
                    : const Icon(
                        size: 14,
                        Icons.circle,
                        color: AppColor.primary,
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
