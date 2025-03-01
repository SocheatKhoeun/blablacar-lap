import 'package:flutter/material.dart';
import '../../rides/rides_screen.dart';
import '/utils/animations_util.dart';
import '/model/ride/locations.dart';
import '/model/ride_pref/ride_pref.dart';
import '/theme/theme.dart';
import '/utils/date_time_util.dart';
import '/widgets/actions/bla_button.dart';
import '/widgets/display/bla_divider.dart';
import '/widgets/inputs/bla_location_picker.dart';
import 'ride_pref_input_tile.dart';

class RidePrefForm extends StatefulWidget {
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

  @override
  void initState() {
    super.initState();
    if (widget.initRidePref != null) {
      departure = widget.initRidePref!.departure;
      arrival = widget.initRidePref!.arrival;
      departureDate = widget.initRidePref!.departureDate;
      requestedSeats = widget.initRidePref!.requestedSeats;
    } else {
      departure = null;
      arrival = null;
      departureDate = DateTime.now();
      requestedSeats = 1;
    }
  }

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

  void onSwappingLocationPressed() {
    print("Swapping locations");
    if (departure == null || arrival == null) return;
    setState(() {
      final temp = departure!;
      departure = Location.copy(arrival!);
      arrival = Location.copy(temp);
    });
  }

  void onSubmit() {
    bool hasDeparture = departure != null;
    bool hasArrival = arrival != null;
    if (hasDeparture && hasArrival) {
      RidePref newRideRef = RidePref(
        departure: departure!,
        departureDate: departureDate,
        arrival: arrival!,
        requestedSeats: requestedSeats,
      );
      Navigator.of(context).push(
        AnimationUtils.createBottomToTopRoute(
          RidesScreen(initialRidePref: newRideRef),
        ),
      );
    }
  }

  String get departureLabel => departure?.name ?? "Leaving from";
  String get arrivalLabel => arrival?.name ?? "Going to";
  String get dateLabel => DateTimeUtils.formatDateTime(departureDate);
  String get numberLabel => requestedSeats.toString();

  bool get showDeparturePlaceholder => departure == null;
  bool get showArrivalPlaceholder => arrival == null;
  bool get switchVisible => departure != null && arrival != null;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: BlaSpacings.m),
          child: Column(
            children: [
              RidePrefInputTile(
                isPlaceHolder: showDeparturePlaceholder,
                title: departureLabel,
                leftIcon: Icons.radio_button_checked_outlined,
                onPressed: onDeparturePressed,
                rightIcon: switchVisible ? Icons.swap_vert : null,
                onRightIconPressed: switchVisible ? onSwappingLocationPressed : null,
              ),
              const BlaDivider(),
              RidePrefInputTile(
                isPlaceHolder: showArrivalPlaceholder,
                title: arrivalLabel,
                leftIcon: Icons.radio_button_checked_outlined,
                onPressed: onArrivalPressed,
              ),
              const BlaDivider(),
              RidePrefInputTile(
                title: dateLabel,
                leftIcon: Icons.calendar_month,
                onPressed: () {},
              ),
              const BlaDivider(),
              RidePrefInputTile(
                title: numberLabel,
                leftIcon: Icons.person_2_outlined,
                onPressed: () {},
              ),
            ],
          ),
        ),
        BlaButton(text: 'Search', onPressed: onSubmit),
      ],
    );
  }
}