import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../utils/app_colors.dart';

class BuildLoadingWidget extends StatelessWidget {
  final Color? color;

  const BuildLoadingWidget({super.key, this.color});

  @override
  Widget build(BuildContext context) {
    return SpinKitWave(
      type: SpinKitWaveType.start,
      color: color ?? AppColors.primaryColorLight,
      size: 18.0,
      itemCount: 6,
    );
  }
}
