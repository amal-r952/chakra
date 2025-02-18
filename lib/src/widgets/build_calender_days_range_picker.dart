import 'package:chakra/src/utils/app_colors.dart';
import 'package:date_picker_plus/date_picker_plus.dart';
import 'package:flutter/material.dart';

import '../utils/utils.dart';
import 'build_elevated_button.dart';

class BuildCalenderDaysRangePicker extends StatefulWidget {
  final Function(DateTimeRange) onRangeSelected;

  const BuildCalenderDaysRangePicker({
    super.key,
    required this.onRangeSelected,
  });

  @override
  State<BuildCalenderDaysRangePicker> createState() =>
      _BuildCalenderDaysRangePickerState();
}

class _BuildCalenderDaysRangePickerState
    extends State<BuildCalenderDaysRangePicker> {
  DateTimeRange? dateTimeRange;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            'Choose the dates',
            style: Theme.of(context).textTheme.headlineMedium,
          ),
        ),
        Expanded(
          child: RangeDatePicker(
            selectedCellsDecoration: BoxDecoration(
              color: AppColors.mainAccentColor.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            selectedCellsTextStyle: TextStyle(
              color: AppColors.mainAccentColor.withOpacity(0.7),
              fontWeight: FontWeight.bold,
            ),
            singleSelectedCellDecoration: const BoxDecoration(
              color: AppColors.mainAccentColor,
              shape: BoxShape.circle,
            ),
            singleSelectedCellTextStyle: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
            currentDateDecoration: BoxDecoration(
              border: Border.all(
                color: AppColors.mainAccentColor.withOpacity(0.3),
                width: 2,
              ),
              shape: BoxShape.circle,
            ),
            currentDateTextStyle: TextStyle(
              color: AppColors.mainAccentColor.withOpacity(0.7),
              fontWeight: FontWeight.bold,
            ),
            daysOfTheWeekTextStyle: const TextStyle(
              color: Colors.black87,
              fontWeight: FontWeight.w600,
            ),
            disabledCellsDecoration: BoxDecoration(
              color: Colors.grey.withOpacity(0.2),
              shape: BoxShape.circle,
            ),
            disabledCellsTextStyle: const TextStyle(
              color: Colors.grey,
            ),
            enabledCellsDecoration: const BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
            ),
            enabledCellsTextStyle: const TextStyle(
              color: Colors.black87,
            ),
            initialPickerType: PickerType.days,
            leadingDateTextStyle: TextStyle(
              fontSize: 20,
              color: Colors.grey.withOpacity(0.8),
            ),
            slidersColor: AppColors.mainAccentColor,
            highlightColor: AppColors.mainAccentColor.withOpacity(0.1),
            slidersSize: 20,
            splashColor: AppColors.mainAccentColor.withOpacity(0.2),
            centerLeadingDate: true,
            minDate: DateTime(2024, 12, 1),
            maxDate: DateTime.now(),
            onRangeSelected: (value) {
              setState(() {
                dateTimeRange = value;
              });
            },
          ),
        ),
        if (dateTimeRange != null)
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 5.0),
            child: Text(
              dateTimeRange!.start == dateTimeRange!.end
                  ? formatDate(dateTimeRange!.start)
                  : "${formatDate(dateTimeRange!.start)} to ${formatDate(dateTimeRange!.end)}",
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10.0),
          child: Text(
            "Double tap to choose a particular day!",
            style: Theme.of(context).textTheme.bodySmall,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 20, right: 20, bottom: 10),
          child: BuildElevatedButton(
            backgroundColor: dateTimeRange != null
                ? AppColors.mainAccentColor
                : AppColors.elevatedButtonHintColorLight,
            onTap: dateTimeRange != null
                ? () async {
                    widget.onRangeSelected(dateTimeRange!);
                    pop(context);
                  }
                : null,
            txt: "Done",
            child: null,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 20, right: 20, bottom: 10),
          child: TextButton(
            onPressed: () {
              pop(context);
            },
            child: const Text(
              'Cancel',
              style: TextStyle(color: AppColors.borderMediumGrey),
            ),
          ),
        ),
      ],
    );
  }
}
