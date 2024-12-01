import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';

import '../../config/app_color.dart';
import '../../features/user_features/root/view/root_view.dart';
import '../ui.dart';
import 'container_button.dart';

class CustomLogoAppbar extends ConsumerStatefulWidget
    implements PreferredSizeWidget {
  final ScrollController? scrollController;
  final bool hideBackButton;
  final Widget customTitleWidget;
  final bool isCenterTitle;
  final bool hideActions;
  final bool applyPadding;
  final void Function()? onTap;
  final IconData? icon;
  final Widget? buttonWidget;

  const CustomLogoAppbar({
    super.key,
    this.scrollController,
    required this.customTitleWidget,
    this.hideBackButton = false,
    this.hideActions = false,
    this.isCenterTitle = true,
    this.applyPadding = true,
    this.onTap,
    this.icon,
    this.buttonWidget,
  });

  @override
  ConsumerState<CustomLogoAppbar> createState() => _CustomLogoAppbarState();

  @override
  // TODO: implement preferredSize
  Size get preferredSize => const Size.fromHeight(80);
}

class _CustomLogoAppbarState extends ConsumerState<CustomLogoAppbar> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: true,
      child: Padding(
        padding: const EdgeInsetsDirectional.only(top: 10, bottom: 10, end: 20),
        child: GestureDetector(
            onTap: widget.scrollController == null
                ? null
                : () {
                    if (widget.scrollController?.hasClients == true) {
                      widget.scrollController?.animateTo(
                        0,
                        duration: const Duration(milliseconds: 500),
                        curve: Curves.easeInOut,
                      );
                      ref.read(hideNavBarProvider.notifier).state = false;
                    }
                  },
            child: AppBar(
                backgroundColor: Colors.transparent,
                centerTitle: widget.isCenterTitle,
                title: widget.customTitleWidget,
                leadingWidth: widget.hideBackButton ? 0 : 50,
                leading: widget.hideBackButton
                    ? const SizedBox()
                    : InkWell(
                        onTap: () => Get.back(),
                        child: const Icon(Icons.arrow_back_rounded)),
                actions: widget.hideActions
                    ? []
                    : [
                        if (widget.applyPadding)
                          Padding(
                            padding: const EdgeInsets.all(5),
                            child: widget.buttonWidget ??
                                ContainerButton(
                                  color: Colors.transparent,
                                  size: 50,
                                  iconColor: AppColor.primary,
                                  icon: Icons.notifications_active_rounded,
                                  onTap: widget.onTap ??
                                      () {
                                        UIHelper.showGlobalSnackBar(
                                          text: "Coming soon".tr,
                                        );
                                      },
                                ),
                          ),
                        if (!widget.applyPadding)
                          ContainerButton(
                            color: Colors.transparent,
                            size: 50,
                            iconColor: AppColor.primary,
                            icon: Icons.notifications_active_rounded,
                            onTap: widget.onTap ??
                                () {
                                  UIHelper.showGlobalSnackBar(
                                    text: "Coming soon".tr,
                                  );
                                },
                          ),
                      ])),
      ),
    );
  }
}
