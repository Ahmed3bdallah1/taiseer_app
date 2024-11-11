import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

import '../../config/app_font.dart';
import '../../features/user_features/root/view/root_view.dart';
import 'container_button.dart';

class CustomAppBar extends ConsumerStatefulWidget
    implements PreferredSizeWidget {
  const CustomAppBar({
    super.key,
    required this.title,
    this.hideBackButton = false,
    this.customWidget,
    this.actionWidget,
    this.enableDrag = false,
    this.scrollController,
    this.customBackFunction,
    this.isCenterTitle = true,
    this.customTitleWidget,
  });

  final String title;
  final Widget? customTitleWidget;
  final ScrollController? scrollController;
  final bool hideBackButton;
  final bool enableDrag;
  final bool isCenterTitle;
  final Widget? actionWidget;
  final void Function()? customBackFunction;
  final List<Widget>? customWidget;

  @override
  ConsumerState<CustomAppBar> createState() => _CustomAppBarState();

  @override
  Size get preferredSize => Size.fromHeight(75.h);
}

@override
class _CustomAppBarState extends ConsumerState<CustomAppBar> {
  final transparentAppBar = StateProvider.autoDispose<bool>((ref) {
    return true;
  });

  @override
  void initState() {
    if (widget.enableDrag && widget.scrollController != null) {
      widget.scrollController!.addListener(() {
        if (widget.scrollController!.position.pixels < 0) {
          ref.read(transparentAppBar.notifier).state = false;
        } else if (widget.scrollController!.position.pixels > 20) {
          ref.read(transparentAppBar.notifier).state = false;
        } else {
          ref.read(transparentAppBar.notifier).state = true;
        }
      });
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    responsiveInit(context);
    return SafeArea(
      top: true,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
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
              centerTitle: widget.isCenterTitle,
              title: widget.customTitleWidget ??
                  Text(
                    widget.title,
                    style: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.bold),
                  ),
              leading: widget.hideBackButton || widget.isCenterTitle == false
                  ? null
                  : ContainerButton(
                      icon: Icons.arrow_back_outlined,
                      color: Colors.blueGrey.shade100,
                      onTap: () => Get.back(),
                    ),
            )),
      ),
    );
  }
}

class CustomAppBar2 extends ConsumerStatefulWidget
    implements PreferredSizeWidget {
  const CustomAppBar2(
      {super.key,
      required this.title,
      this.hideBackButton = false,
      this.backgroundColor,
      this.showHomeBackButton = false,
      this.customWidget,
      this.actionWidget,
      this.enableDrag = false,
      this.scrollController,
      this.customBackFunction});

  final String title;
  final Color? backgroundColor;
  final ScrollController? scrollController;
  final bool hideBackButton;
  final bool showHomeBackButton;
  final bool enableDrag;
  final Widget? actionWidget;
  final void Function()? customBackFunction;
  final List<Widget>? customWidget;

  @override
  ConsumerState<CustomAppBar2> createState() => _CustomAppBarState2();

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

@override
class _CustomAppBarState2 extends ConsumerState<CustomAppBar2> {
  final transparentAppBar = StateProvider.autoDispose<bool>((ref) {
    return true;
  });

  @override
  void initState() {
    if (widget.enableDrag &&
        widget.scrollController != null &&
        widget.backgroundColor != null) {
      widget.scrollController!.addListener(() {
        if (widget.scrollController!.position.pixels < 0) {
          ref.read(transparentAppBar.notifier).state = false;
        } else if (widget.scrollController!.position.pixels > 20) {
          ref.read(transparentAppBar.notifier).state = false;
        } else {
          ref.read(transparentAppBar.notifier).state = true;
        }
      });
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    responsiveInit(context);
    return GestureDetector(
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
        centerTitle: false,
        backgroundColor:
            ref.watch(transparentAppBar) ? widget.backgroundColor : null,
        title: Text(
          widget.title,
          style: AppFont.font20W600Black,
        ),
        actions: [
          if (widget.actionWidget != null) ...[
            widget.actionWidget!,
            Gap(16.w),
          ],
        ],
      ),
    );
  }
}
