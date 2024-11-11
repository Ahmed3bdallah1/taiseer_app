import 'package:flutter/material.dart';
import 'package:learning/config/app_color.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class LoadingWidget extends StatelessWidget {
  const LoadingWidget(
      {super.key, this.color = AppColor.primary, this.size = 30});

  final Color color;
  final double size;

  @override
  Widget build(BuildContext context) {
    responsiveInit(context);
    return Center(
      child: LoadingAnimationWidget.inkDrop(
        color: color,
        size: size,
      ),
    );
  }
}
