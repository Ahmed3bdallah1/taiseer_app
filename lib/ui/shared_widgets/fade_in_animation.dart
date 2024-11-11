import 'package:flutter/material.dart';

enum FadeInDirection { topToBottom, bottomToTop, leftToRight, rightToLeft }

class FadeInAnimation extends StatefulWidget {
  const FadeInAnimation(
      {super.key,
      required this.child,
      required this.delay,
      required this.direction,
      this.fadeOffset});

  final Widget child;
  final double delay;
  final double? fadeOffset;
  final FadeInDirection direction;

  @override
  State<FadeInAnimation> createState() => _FadeInAnimationState();
}

class _FadeInAnimationState extends State<FadeInAnimation>
    with TickerProviderStateMixin {
  late AnimationController controller;
  late Animation<double> opacityAnimation;
  late Animation<double> inAnimation;

  @override
  void initState() {
    super.initState();

    controller = AnimationController(
        duration: Duration(milliseconds: (500 * widget.delay).round()),
        vsync: this);
    inAnimation =
        Tween<double>(begin: -(widget.fadeOffset??.2), end: 0).animate(controller)
          ..addListener(() {
            setState(() {});
          });

    opacityAnimation = Tween<double>(begin: 0, end: 1).animate(controller)
      ..addListener(() {
        setState(() {});
      });
  }

  @override
  Widget build(BuildContext context) {
    controller.forward();
    return Transform.translate(
      offset: switch (widget.direction) {
        FadeInDirection.leftToRight => Offset(inAnimation.value, 0),
        FadeInDirection.rightToLeft => Offset(-inAnimation.value, 0),
        FadeInDirection.topToBottom => Offset(0, inAnimation.value),
        FadeInDirection.bottomToTop => Offset(0, 0 - inAnimation.value),
      },
      child: Opacity(
        opacity: opacityAnimation.value,
        child: widget.child,
      ),
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}
