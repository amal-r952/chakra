import 'package:flutter/material.dart';

import '../utils/app_colors.dart';
import '../utils/font_family.dart';
import 'build_textfield_widget.dart';

class BuildTextFieldWithHeadingWidget extends StatefulWidget {
  final bool? showCounterText;
  final int? maxLength;
  final TextCapitalization? textCapitalization;
  final int? styleType;
  final bool? isRequired;
  final int? maxLines;
  final double? headingSize;
  final FontWeight? headingWeight;
  final String heading;
  final bool? enable;
  final bool? showBorder;
  final TextEditingController controller;
  final String contactHintText;
  final TextInputType? textInputType;
  final TextInputAction? textInputAction;
  final bool? isPasswordField;
  final Function(String?) validation;
  final double? distance;
  final Color? hintColor;
  final Color? fillColor;
  final bool showErrorBorderAlways;

  const BuildTextFieldWithHeadingWidget({
    super.key,
    required this.heading,
    this.isRequired,
    this.fillColor,
    this.headingSize,
    this.headingWeight,
    this.hintColor,
    this.maxLines,
    this.styleType,
    required this.controller,
    required this.contactHintText,
    this.textInputType,
    this.textInputAction,
    this.isPasswordField = false,
    required this.validation,
    this.enable,
    this.showBorder,
    this.distance,
    required this.showErrorBorderAlways,
    this.textCapitalization,
    this.showCounterText,
    this.maxLength,
  });

  @override
  State<BuildTextFieldWithHeadingWidget> createState() =>
      _BuildTextFieldWithHeadingWidgetState();
}

class _BuildTextFieldWithHeadingWidgetState
    extends State<BuildTextFieldWithHeadingWidget> {
  bool isObscure = true;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              " ${widget.heading}",
              style: widget.styleType == null
                  ? Theme.of(context).textTheme.displayMedium?.copyWith(
                        fontSize: 12,
                        fontWeight: FontWeight.w300,
                        fontFamily: FontFamily.gothamBook,
                      )
                  : Theme.of(context).textTheme.displayMedium?.copyWith(
                        fontSize: widget.headingSize ?? 12,
                        fontWeight: FontWeight.w300,
                        fontFamily: FontFamily.gothamBook,
                      ),
            ),
            if (widget.isRequired != null && widget.isRequired == true)
              const SizedBox(width: 4),
            if (widget.isRequired != null && widget.isRequired == true)
              Text(
                "(Required)",
                style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                      fontSize: 11,
                      fontFamily: FontFamily.gothamBook,
                      fontWeight: FontWeight.w500,
                      color: AppColors.mainAccentColor,
                    ),
              ),
          ],
        ),
        SizedBox(height: widget.distance ?? 8),
        BuildTextField(
          showCounterText: widget.showCounterText,
          maxLength: widget.maxLength,
          textCapitalization: widget.textCapitalization,
          showAlwaysErrorBorder: widget.showErrorBorderAlways,
          enable: widget.enable,
          maxLines: widget.maxLines ?? 1,
          filled: true,
          validation: widget.validation,
          borderRadius: 5,
          keyboardType: widget.textInputType,
          textEditingController: widget.controller,
          showBorder: widget.showBorder ?? false,
          hintText: widget.contactHintText,
        ),
      ],
    );
  }
}
