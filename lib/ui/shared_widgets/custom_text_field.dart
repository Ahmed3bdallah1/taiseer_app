import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:reactive_forms/reactive_forms.dart';

import '../../config/app_font.dart';

enum TextFieldType { text, selectable }

class CustomTextField<T> extends StatelessWidget {
  const CustomTextField({
    super.key,
    this.hintText,
    this.formControlName,
    this.autofillHints,
    this.inputType = TextInputType.text,
    this.style = 1,
    this.inputFormatter,
    this.paddingFromTop = false,
    this.onEditDone,
    this.onTap,
    this.obscure = false,
    this.maxLines = 1,
    this.control,
    this.iconDataPrefix,
    this.iconColor = Colors.grey,
    this.iconButton,
    this.type = TextFieldType.text,
    this.items,
    this.onChanged,
    this.focusNode,
    this.borderRadius,
    this.hideSelectableIconIfIgnore = true,
    this.ignore = false,
    this.labelText,
    this.prefixText,
    this.suffixText,
  });

  final Iterable<String>? autofillHints;
  final String? formControlName;
  final FormControl<T>? control;
  final String? hintText;
  final String? labelText;
  final int style;
  final Widget? iconButton;
  final bool obscure;
  final bool ignore;
  final FocusNode? focusNode;
  final int maxLines;
  final VoidCallback? onEditDone;
  final bool paddingFromTop;
  final List<TextInputFormatter>? inputFormatter;
  final TextInputType inputType;
  final void Function()? onTap;
  final TextFieldType type;
  final List<DropdownMenuItem<T>>? items;
  final String? prefixText;
  final String? suffixText;
  final Widget? iconDataPrefix;
  final Color iconColor;
  final ReactiveFormFieldCallback<T>? onChanged;
  final BorderRadius? borderRadius;
  final bool hideSelectableIconIfIgnore;

  @override
  Widget build(BuildContext context) {
    responsiveInit(context);
    final validation = {
      ValidationMessage.email: (controller) => ValidationMessage.email.tr,
      ValidationMessage.required: (controller) => ValidationMessage.required.tr,
      ValidationMessage.number: (controller) => ValidationMessage.number.tr,
      ValidationMessage.minLength: (controller) =>
          ValidationMessage.minLength.tr,
      ValidationMessage.maxLength: (controller) =>
          ValidationMessage.maxLength.tr,
      ValidationMessage.mustMatch: (controller) =>
          ValidationMessage.mustMatch.tr,
    };
    final InputDecoration decoration = InputDecoration(
      contentPadding: const EdgeInsetsDirectional.only(start: 8),
      labelStyle: AppFont.labelTextField,
      filled: false,
      suffixIcon: iconButton,
      prefixIcon: iconDataPrefix,
      hintText: hintText,
      prefixText: prefixText,
      suffixText: suffixText,
      prefixStyle: AppFont.textFiled,
      suffixStyle: AppFont.textFiled,
      hintStyle: AppFont.hintTextField,
      border: const OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(8.0)),
        borderSide: BorderSide(
          color: AppColor.primary,
        ),
      ),
      disabledBorder: OutlineInputBorder(
        borderRadius: const BorderRadius.all(Radius.circular(8.0)),
        borderSide: BorderSide(color: AppColor.grey1, width: 2),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: const BorderRadius.all(Radius.circular(8.0)),
        borderSide: BorderSide(color: AppColor.grey1, width: 2),
      ),
      focusedBorder: const OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(8.0)),
        borderSide: BorderSide(
          color: AppColor.primary,
        ),
      ),
      constraints: BoxConstraints(
        minHeight: 46.h,
      ),
    );
    final wid = type == TextFieldType.text
        ? ReactiveTextField<T>(
            autofillHints: autofillHints,
            focusNode: focusNode,
            contextMenuBuilder: (context, editableTextState) {
              final items = editableTextState.contextMenuButtonItems;
              return AdaptiveTextSelectionToolbar.buttonItems(
                anchors: editableTextState.contextMenuAnchors,
                buttonItems: items,
              );
            },
            // onTapOutside: (controller) {
            //   FocusManager.instance.primaryFocus?.unfocus();
            // },
            textInputAction: inputType == TextInputType.multiline
                ? TextInputAction.newline
                : null,
            formControl: control,
            onEditingComplete: onEditDone == null
                ? (x) => FocusScope.of(context).nextFocus()
                : (controller) {
                    onEditDone?.call();
                  },
            onTap: onTap == null
                ? null
                : (controller) {
                    onTap!.call();
                  },
            keyboardType: inputType,
            maxLines: maxLines,
            inputFormatters: [
              ...?inputFormatter,
              if (inputType == TextInputType.phone)
                FilteringTextInputFormatter.digitsOnly
            ],
            obscureText: obscure,
            style: AppFont.textFiled,
            textAlignVertical: iconButton != null
                ? TextAlignVertical.center
                : TextAlignVertical.top,
            formControlName: formControlName,
            decoration: decoration,
            validationMessages: validation,
            onChanged: onChanged,
          )
        : ReactiveDropdownField<T>(
            iconEnabledColor: AppColor.primary,
            iconDisabledColor: AppColor.disabled,
            itemHeight: kMinInteractiveDimension,
            isDense: false,
            icon: ignore && hideSelectableIconIfIgnore
                ? const SizedBox.shrink()
                : null,
            formControl: formControlName != null ? null : control,
            onTap: onTap == null
                ? null
                : (controller) {
                    onTap!.call();
                  },
            onChanged: onChanged,
            style: AppFont.textFiled,
            formControlName: formControlName,
            decoration: decoration,
            items: items!,
            validationMessages: validation,
          );
    return Column(
      children: [
        if (labelText != null)
          Align(
            alignment: const AlignmentDirectional(-1, 0),
            child: Text(
              labelText!,
              style: AppFont.font14W500Black,
              textAlign: TextAlign.start,
            ),
          ),
        Gap(10.h),
        InkWell(
          onTap: ignore ? onTap : null,
          child: IgnorePointer(
            ignoring: ignore,
            child: wid,
          ),
        ),
      ],
    );
  }
}
