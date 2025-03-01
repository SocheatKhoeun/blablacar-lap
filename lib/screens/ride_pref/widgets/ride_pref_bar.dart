import 'package:flutter/material.dart';
import '/model/ride_pref/ride_pref.dart';
import '/theme/theme.dart';
import '/utils/date_time_util.dart';
import '/widgets/actions/bla_text_button.dart';

/// A top bar combining the ride preference summary and the back button.
/// A Filter button appears on the right to filter the view.
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
  void _onBackPressed() => Navigator.of(context).pop();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: BlaColors.backgroundAccent,
        borderRadius: BorderRadius.circular(BlaSpacings.radius),
      ),
      child: Row(
        children: [
          IconButton(
            onPressed: _onBackPressed,
            icon: Icon(Icons.arrow_back_ios, color: BlaColors.iconLight, size: 16),
          ),
          Expanded(
            child: RidePrefSummary(
              ridePref: widget.ridePref,
              onPressed: widget.onRidePrefPressed,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: BlaTextButton(text: "Filter", onPressed: widget.onFilterPressed),
          )
        ],
      ),
    );
  }
}

class RidePrefSummary extends StatelessWidget {
  const RidePrefSummary({super.key, required this.ridePref, required this.onPressed});

  final RidePref ridePref;
  final VoidCallback onPressed;

  String get title => "${ridePref.departure.name} → ${ridePref.arrival.name}";
  String get subTitle => "${DateTimeUtils.formatDateTime(ridePref.departureDate)}, "
      "${ridePref.requestedSeats} passenger${ridePref.requestedSeats > 1 ? "s" : ""}";

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: onPressed,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: BlaTextStyles.label.copyWith(color: BlaColors.textNormal)),
            Text(subTitle, style: BlaTextStyles.label.copyWith(color: BlaColors.textLight)),
          ],
        ),
      ),
    );
  }
}
