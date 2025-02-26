import 'package:flutter/material.dart';
import '/utils/animations_util.dart';
import '/model/ride/locations.dart';
import '/model/ride_pref/ride_pref.dart';
import '/theme/theme.dart';
import '/utils/date_time_util.dart';
import '/widgets/actions/bla_button.dart';
import '/widgets/display/bla_divider.dart';
import '/widgets/inputs/bla_location_picker.dart';
import 'ride_pref_input_tile.dart';
 
///
/// A Ride Preference From is a view to select:
///   - A depcarture location
///   - An arrival location
///   - A date
///   - A number of seats
///
/// The form can be created with an existing RidePref (optional).
///
class RidePrefForm extends StatefulWidget {
  // The form can be created with an optional initial RidePref.
  final RidePref? initRidePref;

  const RidePrefForm({super.key, this.initRidePref});

  @override
  State<RidePrefForm> createState() => _RidePrefFormState();
}

class _RidePrefFormState extends State<RidePrefForm> {
  Location? departure;
  late DateTime departureDate;
  Location? arrival;
  late int requestedSeats;



  // ----------------------------------
  // Initialize the Form attributes
  // ----------------------------------

  @override
  void initState() {
    super.initState();
    // TODO 
    if (widget.initRidePref != null) {
      departure = widget.initRidePref!.departure;
      arrival = widget.initRidePref!.arrival;
      departureDate = widget.initRidePref!.departureDate;
      requestedSeats = widget.initRidePref!.requestedSeats;
    } else {
      departure = null; // User must select a departure location
      arrival = null;   // User must select an arrival location
      departureDate = DateTime.now(); // Default to current date
      requestedSeats = 1; // Default to 1 seat
    }
  }

  // ----------------------------------
  // Handle events
  // ----------------------------------

  /// Handles the selection of the departure location
  void onDeparturePressed() async {
    final Location? selectedLocation = await Navigator.of(context).push<Location>(
      AnimationUtils.createBottomToTopRoute(
        BlaLocationPicker(initLocation: departure),
      ),
    );

    if (selectedLocation != null) {
      setState(() => departure = selectedLocation);
    }
  }

  /// Handles the selection of the arrival location
  void onArrivalPressed() async {
    final Location? selectedLocation = await Navigator.of(context).push<Location>(
      AnimationUtils.createBottomToTopRoute(
        BlaLocationPicker(initLocation: arrival),
      ),
    );

    if (selectedLocation != null) {
      setState(() => arrival = selectedLocation);
    }
  }


  /// Swaps the departure and arrival locations if both are selected
  void onSwappingLocationPressed() {
    if (departure == null || arrival == null) return;
    setState(() {
      final temp = departure!;
      departure = Location.copy(arrival!);
      arrival = Location.copy(temp);
    });
  }

  /// Submits the form.
  void onSubmit() {
    ///TODO
  }

  // ----------------------------------
  // Compute the widgets rendering
  // ----------------------------------
  
  /// Getters for UI labels and placeholders.
  String get departureLabel => departure?.name ?? "Leaving from";
  String get arrivalLabel => arrival?.name ?? "Going to";
  String get dateLabel => DateTimeUtils.formatDateTime(departureDate);
  String get numberLabel => requestedSeats.toString();

  bool get showDeparturePlaceholder => departure == null;
  bool get showArrivalPlaceholder => arrival == null;
  bool get switchVisible => departure != null && arrival != null;



  // ----------------------------------
  // Build the widgets
  // ----------------------------------

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: BlaSpacings.m),
          child: Column(
            children: [
              // Ride departure
              RidePrefInputTile(
                isPlaceHolder: showDeparturePlaceholder,
                title: departureLabel,
                leftIcon: Icons.radio_button_checked_outlined,
                onPressed: onDeparturePressed,
                rightIcon: switchVisible ? Icons.swap_vert : null,
                onRightIconPressed: switchVisible ? onSwappingLocationPressed : null,
              ),
              const BlaDivider(),

              // Ride arrival
              RidePrefInputTile(
                isPlaceHolder: showArrivalPlaceholder,
                title: arrivalLabel,
                leftIcon: Icons.radio_button_checked_outlined,
                onPressed: onArrivalPressed,
              ),
              const BlaDivider(),

              // Ride date
              RidePrefInputTile(
                title: dateLabel,
                leftIcon: Icons.calendar_month,
                onPressed: () {},
              ),
              const BlaDivider(),

              // Requested number of seats
              RidePrefInputTile(
                title: numberLabel,
                leftIcon: Icons.person_2_outlined,
                onPressed: () {}, 
              ),
            ],
          ),
        ),

        // Search
        BlaButton(text: 'Search', onPressed: onSubmit),
      ],
    );
  }
}
