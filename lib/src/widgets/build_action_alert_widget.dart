import 'package:flutter/material.dart';

import '../utils/app_colors.dart';
import 'build_elevated_button.dart';

class BuildActionAlertWidget extends StatefulWidget {
  final String titleText;
  final String primaryButtonText;
  final String secondaryButtonText;
  final Function onPrimaryButtonTap;
  final Function onSecondaryButtonTap;
  const BuildActionAlertWidget({
    super.key,
    required this.titleText,
    required this.primaryButtonText,
    required this.secondaryButtonText,
    required this.onPrimaryButtonTap,
    required this.onSecondaryButtonTap,
  });

  @override
  State<BuildActionAlertWidget> createState() => _BuildActionAlertWidgetState();
}

class _BuildActionAlertWidgetState extends State<BuildActionAlertWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Spacer(),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10.0),
          child: Text(
            widget.titleText,
            style: Theme.of(context).textTheme.bodyLarge,
          ),
        ),
        const Spacer(),
        Padding(
          padding: const EdgeInsets.only(left: 20, right: 20, bottom: 10),
          child: BuildElevatedButton(
            backgroundColor: AppColors.mainAccentColor,
            onTap: () async {
              widget.onPrimaryButtonTap();
            },
            txt: widget.primaryButtonText,
            child: null,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 20, right: 20, bottom: 10),
          child: TextButton(
            onPressed: () {
              widget.onSecondaryButtonTap();
            },
            child: Text(
              widget.secondaryButtonText,
              style: const TextStyle(color: AppColors.borderMediumGrey),
            ),
          ),
        ),
      ],
    );
  }
}
