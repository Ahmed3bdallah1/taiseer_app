import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';

import '../../features/user_features/root/view/root_view.dart';
import 'container_button.dart';

class CustomLogoAppbar extends ConsumerStatefulWidget
    implements PreferredSizeWidget {
  final ScrollController? scrollController;
  final bool hideBackButton;
  final Widget customTitleWidget;
  final bool isCenterTitle;
  final bool hideActions;
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
                        widget.buttonWidget ??
                            ContainerButton(
                              size: 60,
                              color: Colors.transparent,
                              icon: widget.icon ??
                                  Icons.notifications_active_outlined,
                              onTap: widget.onTap,
                            )
                      ])),
      ),
    );
  }
}
