import 'package:flutter/material.dart';

class BuildTextWidget extends StatelessWidget {
  final TextStyle? style;
  final String? text;
  final String? fontFamily;
  final Color? color;
  final double? size;
  final FontWeight? fontWeight;
  final int? maxLines;
  final bool? isObscure;
  final TextOverflow? textOverflow;
  final TextAlign? textAlign;
  final TextDecoration? textDecoration;

  const BuildTextWidget({
    Key? key,
    required this.text,
    this.color,
    this.size,
    this.style,
    this.fontWeight,
    this.maxLines,
    this.textOverflow,
    this.isObscure,
    this.textAlign,
    this.fontFamily,
    this.textDecoration,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(isObscure == true ? text!.replaceAll(RegExp(r"."), "*") : text!,
        overflow: textOverflow ?? TextOverflow.ellipsis,
        maxLines: maxLines ?? 2,
        textAlign: textAlign ?? TextAlign.left,
        style: style ?? Theme.of(context).textTheme.headlineLarge);
  }
}
