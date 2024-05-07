import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';
import 'package:vloo/app/data/configs/app_theme.dart';
import 'package:vloo/app/data/configs/sizing.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField(
      {super.key,
      this.node,
      this.enabled,
      this.errorText,
      this.autoFocus,
      this.prefixIcon,
      this.onChangeFtn,
      this.initialValue,
      this.validatorFtn,
      this.textAlignment,
      required this.name,
      required this.hint,
      this.isPass = false,
      this.textCapitalization = TextCapitalization.none,
      this.isSuffixIcon = false,
      required this.textInputType,
      this.width = double.infinity,
      this.textInputAction = TextInputAction.done,
      this.readOnly,
      this.onTap,
      this.maxLines,
      this.textcontoller,
      this.onSubmitFtn,
      this.helperText,
      this.helperStyle,
      this.suffixIcon,
      this.show = false,
      this.onTapEye});
  final String name;
  final int? maxLines;
  final TextEditingController? textcontoller;
  final String? hint, helperText, errorText, initialValue;
  final TextStyle? helperStyle;
  final bool? isPass, show, readOnly, enabled, autoFocus, isSuffixIcon;
  final double? width;
  final FocusNode? node;
  final Widget? prefixIcon, suffixIcon;
  final TextInputType? textInputType;
  final TextInputAction? textInputAction;
  final TextCapitalization textCapitalization;
  final VoidCallback? onTap, onTapEye;
  final TextAlign? textAlignment;

  final String? Function(String?)? validatorFtn;
  final String? Function(String?)? onChangeFtn;
  final String? Function(String?)? onSubmitFtn;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
      return FormBuilderTextField(
        textAlign: textAlignment ?? TextAlign.start,
        cursorColor: AppColor.secondaryColor,
        style: TextStyle(fontSize: 16.w, color: Colors.white),
        autocorrect: false,
        controller: textcontoller,
        onTap: onTap,
        textCapitalization: textCapitalization,
        enabled: enabled ?? true,
        initialValue: initialValue,
        name: name,
        autofocus: autoFocus ?? false,
        textInputAction: textInputAction,
        keyboardType: textInputType == TextInputType.number
            ? const TextInputType.numberWithOptions(
                signed: true,
                decimal: true,
              )
            : textInputType,
        focusNode: node,
        readOnly: readOnly ?? false,
        obscureText: show ?? false,
        maxLines: maxLines ?? 1,
        decoration: InputDecoration(
          helperMaxLines: 2,
          helperStyle: helperStyle,
          helperText: helperText,
          errorText: errorText,
          prefixIcon: textInputType == TextInputType.number
              ? prefixIcon
              : Container(
                  width: constraints.maxWidth * 0.05,
                  margin: EdgeInsets.only(
                      left: constraints.maxWidth * 0.05,
                      right: 10.h,
                      top: 5.h,
                      bottom: 5.h),
                  child: prefixIcon, // _myIcon is a 48px-wide widget.
                ),
          suffixIcon: isPass!
              ? IconButton(
                  splashRadius: 8,
                  onPressed: onTapEye,
                  icon: Icon(
                    show! ? Icons.visibility_off : Icons.visibility,
                    size: 20.sp,
                    color: AppColor.secondaryColor,
                  ),
                ).marginOnly(right: 10.w)
              : suffixIcon,
          contentPadding:
              EdgeInsets.symmetric(horizontal: 15.w, vertical: 15.h),
          hintText: hint,
          hintStyle: TextStyle(fontSize: 18.sp, color: AppColor.hintTextColor),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(25.sp),
            borderSide: const BorderSide(
              color: AppColor.appLightBlue,
            ),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(25.sp),
            borderSide: const BorderSide(
              color: AppColor.appLightBlue,
            ),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(25.sp),
            borderSide: const BorderSide(
              color: AppColor.appLightBlue,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(25.sp),
            borderSide: const BorderSide(
              color: AppColor.secondaryColor,
              width: 2,
            ),
          ),
          disabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(25.sp),
            borderSide: BorderSide(
              width: 2,
              color: AppColor.hintTextColor,
            ),
          ),
        ),
        validator: validatorFtn,
        onChanged: onChangeFtn,
        onSubmitted: onSubmitFtn,
      );
    });
  }
}
