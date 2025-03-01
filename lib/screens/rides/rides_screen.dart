import 'package:flutter/material.dart';
import '/screens/rides/widgets/ride_pref_bar.dart';

import '../../model/ride/ride.dart';
import '../../model/ride_pref/ride_pref.dart';
import '../../service/rides_service.dart';
import '../../theme/theme.dart';
import 'widgets/rides_tile.dart';

/// Ride selection screen allowing users to choose a ride based on preferences.
/// Users can also modify ride preferences and apply filters.
class RidesScreen extends StatefulWidget {
  final RidePref initialRidePref;

  const RidesScreen({super.key, required this.initialRidePref});

  @override
  State<RidesScreen> createState() => _RidesScreenState();
}

class _RidesScreenState extends State<RidesScreen> {
  List<Ride> get _matchingRides => RidesService.getRidesFor(widget.initialRidePref);

  void _onRidePrefPressed() {
    // TODO: Open modal to edit ride preferences
  }

  void _onFilterPressed() {
    print("Filter button pressed");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: BlaSpacings.m).copyWith(top: BlaSpacings.s),
        child: Column(
          children: [
            RidePrefBar(
              ridePref: widget.initialRidePref,
              onRidePrefPressed: _onRidePrefPressed,
              onFilterPressed: _onFilterPressed,
            ),
            Expanded(
              child: ListView.builder(
                itemCount: _matchingRides.length,
                itemBuilder: (context, index) => RideTile(
                  ride: _matchingRides[index],
                  onPressed: () {},
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
