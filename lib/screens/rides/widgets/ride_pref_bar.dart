import 'package:flutter/material.dart';
import '/model/ride_pref/ride_pref.dart';
import '/theme/theme.dart';
import '/utils/date_time_util.dart';
import '/widgets/actions/bla_text_button.dart';

/// A top bar combining the ride preference summary + the navigation back button
/// A Filter button appears on the right to filter the view
class RidePrefBar extends StatefulWidget {
  const RidePrefBar({
    super.key,
    required this.ridePref,
    required this.onRidePrefPressed,
    required this.onFilterPressed,
  });

  final RidePref ridePref;
  final VoidCallback onRidePrefPressed;
  final VoidCallback onFilterPressed;

  @override
  State<RidePrefBar> createState() => _RidePrefBarState();
}

class _RidePrefBarState extends State<RidePrefBar> {
  // Back navigation handler
  void onBackPressed() {
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: BlaColors.backgroundAccent,
        borderRadius: BorderRadius.circular(BlaSpacings.radius), // Rounded corners
      ),
      child: Row(
        children: [
          // Left: Back button
          IconButton(
            onPressed: onBackPressed,
            icon: Icon(
              Icons.arrow_back_ios,
              color: BlaColors.iconLight,
              size: 16,
            ),
          ),

          // Middle: Ride Summary
          Expanded(
            child: RidePrefSummary(
              ridePref: widget.ridePref,
              onPressed: widget.onRidePrefPressed,
            ),
          ),

          // Right: Filter button
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: BlaTextButton(
                text: "Filter", onPressed: widget.onFilterPressed),
          ),
        ],
      ),
    );
  }
}

/// A widget displaying the ride preference summary.
class RidePrefSummary extends StatelessWidget {
  final RidePref ridePref;
  final VoidCallback onPressed;

  const RidePrefSummary({
    super.key,
    required this.ridePref,
    required this.onPressed,
  });

  // Full title of the ride preference
  String get title => "${ridePref.departure.name} → ${ridePref.arrival.name}";

  // Subtitle with formatted date and number of passengers
  String get subTitle =>
      "${DateTimeUtils.formatDateTime(ridePref.departureDate)}, ${ridePref.requestedSeats} passenger${ridePref.requestedSeats > 1 ? "s" : ""}";

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click, // Change cursor on hover
      child: GestureDetector(
        onTap: onPressed, // Trigger the provided action
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: BlaTextStyles.label.copyWith(color: BlaColors.textNormal),
            ),
            Text(
              subTitle,
              style: BlaTextStyles.label.copyWith(color: BlaColors.textLight),
            ),
          ],
        ),
      ),
    );
  }
}
