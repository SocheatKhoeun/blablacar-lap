import 'package:flutter/material.dart';
import '/model/ride/ride.dart';
import '/theme/theme.dart';
import '/utils/date_time_util.dart';

/// A tile representing a ride.
class RideTile extends StatelessWidget {
  final Ride ride;
  final VoidCallback onPressed;

  const RideTile({super.key, required this.ride, required this.onPressed});

  String get departure => "Departure: ${ride.departureLocation.name}";
  String get arrival => "Arrival: ${ride.arrivalLocation.name}";
  String get time => "Time: ${DateTimeUtils.formatTime(ride.departureDate)}";
  String get price => "Price: ${ride.pricePerSeat}";

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Card(
        margin: const EdgeInsets.all(8),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        elevation: 3,
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(departure, style: BlaTextStyles.label.copyWith(color: BlaColors.textNormal)),
              Text(arrival, style: BlaTextStyles.label.copyWith(color: BlaColors.textNormal)),
              Text(time, style: BlaTextStyles.label.copyWith(color: BlaColors.textLight)),
              Text(price, style: BlaTextStyles.label.copyWith(color: BlaColors.primary, fontWeight: FontWeight.bold)),
            ],
          ),
        ),
      ),
    );
  }
}
