import 'package:flutter/material.dart';
import 'package:taiseer/ui/shared_widgets/image_or_svg.dart';

import '../../config/app_color.dart';
import '../../gen/assets.gen.dart';

class LogoWidget extends StatelessWidget {
  const LogoWidget({
    this.colorText,
    this.colorImage,
    super.key,
  });

  final Color? colorText;
  final Color? colorImage;

  @override
  Widget build(BuildContext context) {
    responsiveInit(context);
    return ImageOrSvg(Assets.base.tayseerLogo.path,isLocal: true,height: 100.h,);
  }
}
