import 'package:flutter/material.dart';

import '../utils/app_colors.dart';
import '../utils/font_family.dart';
import '../utils/utils.dart';
import 'build_text_widget.dart';

class BuildElevatedButton extends StatelessWidget {
  final double? elavation;
  final TextStyle? textStyle;
  final String? txt;
  final Function? onTap;
  final Color? backgroundColor;
  final double? borderRadiusBottomLeft;
  final double? borderRadiusBottomRight;
  final double? borderRadiusTopLeft;
  final double? borderRadiusTopRight;
  final double? width;
  final double? height;
  final double? borderThickness;
  final Color? borderColor; // Added border color property
  final Widget? child;

  const BuildElevatedButton({
    Key? key,
    this.txt,
    this.onTap,
    this.backgroundColor,
    this.width,
    this.textStyle,
    this.height,
    this.borderThickness,
    this.borderColor, // Initialize border color
    this.child,
    this.borderRadiusBottomLeft,
    this.borderRadiusBottomRight,
    this.borderRadiusTopLeft,
    this.borderRadiusTopRight,
    this.elavation,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width ?? screenWidth(context),
      height: height ?? screenHeight(context, dividedBy: 19),
      child: ElevatedButton(
        onPressed: () => onTap!(),
        style: ElevatedButton.styleFrom(
          elevation: elavation ?? 0,
          backgroundColor: backgroundColor ?? AppColors.mainAccentColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(borderRadiusBottomLeft ?? 5),
              bottomRight: Radius.circular(borderRadiusBottomRight ?? 5),
              topLeft: Radius.circular(borderRadiusTopLeft ?? 5),
              topRight: Radius.circular(borderRadiusTopRight ?? 5),
            ),
            side: BorderSide(
              color: borderColor ??
                  Colors
                      .transparent, // Use the specified border color or default to transparent
              width: borderThickness ?? 0,
            ),
          ),
        ),
        child: Center(
          child: child ??
              BuildTextWidget(
                style: textStyle ??
                    Theme.of(context).textTheme.displayLarge?.copyWith(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                          fontFamily: FontFamily.gothamBook,
                          color: AppColors.primaryColorLight,
                        ),
                text: txt,
              ),
        ),
      ),
    );
  }
}
