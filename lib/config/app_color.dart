import 'package:flutter/material.dart';
import 'package:get/get.dart';
export 'package:learning/helper/responsive.dart';
export 'package:learning/helper/riverpod.dart';

abstract class AppColor {
  static Color get white => Get.isDarkMode ? Colors.black : Colors.white;

  static Color get nearlyWhite =>
      Get.isDarkMode ? const Color(0xff232323) : Colors.white;

  static Color get grey3 =>
      Get.isDarkMode ? const Color(0xff777777) : Colors.white;

  static Color get grey_3 =>
      Get.isDarkMode ? const Color(0xff929898) : const Color(0xffD9D9D9);

  static Color get gray_3 =>
      Get.isDarkMode ? const Color(0xff777777) : const Color(0xffD9D9D9);

  static Color get whiteOrGrey =>
      Get.isDarkMode ? const Color(0xff929898) : Colors.white;

  static Color get black => Get.isDarkMode ? Colors.white : Colors.black;
  static const Color green = Color(0xff29B866);
  static const Color green1 = Color(0xff29CD00);
  static Color danger = const Color(0xffE34E00);
  static Color danger2 = Colors.red;
  static Color orange = Colors.orange;
  static Color gold = Color(0xffFFFF00);
  static const Color primary = Color(0xff1481dc);
  static const Color primaryWhite = Color(0xffF7F5FF);
  static const Color primary2 = Color(0xff13828E);
  static const Color primary3 = Color(0xff12133B);
  static const Color primary4 = Color(0xff241180);

  static Color get shipmentTileColor =>
      Get.isDarkMode ? const Color(0xff2f2f2f) : Colors.white;

  static const Color primaryDark = Color(0xff2EC1D1);

  static Color get backGround =>
      Get.isDarkMode ? const Color(0xff303030) : const Color(0xffEAEAEA);

  static Color get disabled =>
      Get.isDarkMode ? const Color(0xff9EACAD) : const Color(0xffC0CDCE);

  static Color get grey2 =>
      Get.isDarkMode ? const Color(0xff929898) : const Color(0xff656969);

  static Color get grey1 =>
      Get.isDarkMode ? const Color(0xffeaf3ff) : const Color(0xffd0d9e5);
  static const unselectedNavBar = Color(0xff707070);
}
