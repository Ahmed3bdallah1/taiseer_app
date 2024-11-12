import 'package:easy_stepper/easy_stepper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:taiseer/config/app_color.dart';

class CustomStepperWidget extends StatefulWidget {
  final int status;

  const CustomStepperWidget({super.key, required this.status});

  @override
  State<CustomStepperWidget> createState() => _CustomStepperWidgetState();
}

class _CustomStepperWidgetState extends State<CustomStepperWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
      ),
      child: EasyStepper(
        activeStep: widget.status,
        // activeStepBackgroundColor: Colors.yellow,
        enableStepTapping: false,
        lineStyle: LineStyle(
          lineLength: 50.w,
          lineSpace: 0,
          lineThickness: 3,
          lineType: LineType.normal,
          defaultLineColor: AppColor.grey2,
          finishedLineColor: AppColor.primary,
        ),
        // activeStepTextColor: Colors.black87,
        // finishedStepTextColor: Colors.black87,
        internalPadding: 0,
        // showLoadingAnimation: true,
        stepRadius: 15,
        // showStepBorder: false,
        steps: [
          EasyStep(
            customStep: CircleAvatar(
              backgroundColor:
                  widget.status >= 0 ? AppColor.primary4 : Colors.white,
              child: const Center(
                  child: Icon(
                Icons.circle,
                color: AppColor.primary,
                size: 18,
              )),
            ),
          ),
          EasyStep(
            customStep: CircleAvatar(
              backgroundColor:
                  widget.status >= 1 ? AppColor.primary4 : Colors.white,
              child: Center(
                  child: Icon(
                Icons.circle,
                color: widget.status >= 1 ? AppColor.primary : AppColor.grey2,
                size: 18,
              )),
            ),
          ),
          EasyStep(
            customStep: CircleAvatar(
              backgroundColor:
                  widget.status >= 2 ? AppColor.primary4 : Colors.white,
              child: Center(
                  child: Icon(
                Icons.circle,
                color: widget.status >= 2 ? AppColor.primary : AppColor.grey2,
                size: 18,
              )),
            ),
          ),
          EasyStep(
            customStep: CircleAvatar(
              backgroundColor:
                  widget.status == 3 ? AppColor.primary4 : Colors.white,
              child: Center(
                  child: Icon(
                Icons.circle,
                color: widget.status >= 3 ? AppColor.primary : AppColor.grey2,
                size: 18,
              )),
            ),
          ),
        ],
      ),
    );
  }
}
