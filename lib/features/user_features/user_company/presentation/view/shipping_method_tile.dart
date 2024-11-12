import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:taiseer/config/app_font.dart';
import 'package:taiseer/ui/shared_widgets/image_or_svg.dart';
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
                    fit: BoxFit.fill,
                  )),
                  Positioned(
                    top: 10,
                    right: 10,
                    child: ImageOrSvg(
                      shippingMethodsEntity.typeActivities?.imageFront??"",
                      color: AppColor.white,
                    ),
                  ),
                  Positioned(
                    bottom: 10,
                    right: 10,
                    child: Text(
                      shippingMethodsEntity.typeActivities?.infoAr ?? "",
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
                          fit: BoxFit.fill,
                        )),
                    Positioned(
                      top: 10,
                      right: 10,
                      child: ImageOrSvg(
                        shippingMethodsEntity.typeActivities?.imageFront??"",
                        color: AppColor.white,
                      ),
                    ),
                    Positioned(
                      bottom: 10,
                      right: 10,
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
  final ShippingMethodsEntity shippingMethodsEntity;

  const FastShippingMethodTile({
    super.key,
    this.color,
    this.radius,
    this.onTap,
    this.isSelected = false,
    required this.shippingMethodsEntity,
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
                child: ImageOrSvg(
                  shippingMethodsEntity.typeActivities?.imageFront??"",
                  color: AppColor.white,
                ),
              ),
              Positioned(
                bottom: 10,
                right: 10,
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
