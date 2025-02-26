import 'package:flutter/material.dart';
import '/model/ride/locations.dart';
import '/service/locations_service.dart';
import '/theme/theme.dart';

/// A placeholder widget for selecting a location.
class BlaLocationPicker extends StatefulWidget {
  final Location? initLocation;

  const BlaLocationPicker({super.key, this.initLocation});

  @override
  State<BlaLocationPicker> createState() => _BlaLocationPickerState();
}

class _BlaLocationPickerState extends State<BlaLocationPicker> {
  List<Location> filteredLocations = [];

  @override
  void initState() {
    super.initState();
    // Initialize filteredLocations with all available locations or based on the initLocation
    filteredLocations = LocationsService.availableLocations;
  }

  void _onBackPressed() => Navigator.of(context).pop();

  void _onLocationSelected(Location location) => Navigator.of(context).pop(location);

  void _onSearchChanged(String query) {
    setState(() {
      filteredLocations = query.length > 1
          ? LocationsService.availableLocations
              .where((location) => location.name.toUpperCase().contains(query.toUpperCase()))
              .toList()
          : LocationsService.availableLocations; // Show all locations when search query is too short
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: BlaSpacings.m, vertical: BlaSpacings.s),
        child: Column(
          children: [
            BlaSearchBar(onSearchChanged: _onSearchChanged, onBackPressed: _onBackPressed),
            Expanded(
              child: ListView.builder(
                itemCount: filteredLocations.length,
                itemBuilder: (ctx, index) => LocationTile(
                  location: filteredLocations[index],
                  onSelected: _onLocationSelected,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Represents a selectable location tile in the list.
class LocationTile extends StatelessWidget {
  final Location location;
  final ValueChanged<Location> onSelected;

  const LocationTile({super.key, required this.location, required this.onSelected});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () => onSelected(location),
      title: Text(location.name, style: BlaTextStyles.body.copyWith(color: BlaColors.textNormal)),
      subtitle: Text(location.country.name, style: BlaTextStyles.label.copyWith(color: BlaColors.textLight)),
      trailing: Icon(Icons.arrow_forward_ios, size: 16, color: BlaColors.iconLight),
    );
  }
}

/// A reusable search bar with a back button and clear functionality.
class BlaSearchBar extends StatefulWidget {
  final ValueChanged<String> onSearchChanged;
  final VoidCallback onBackPressed;

  const BlaSearchBar({super.key, required this.onSearchChanged, required this.onBackPressed});

  @override
  State<BlaSearchBar> createState() => _BlaSearchBarState();
}

class _BlaSearchBarState extends State<BlaSearchBar> {
  final TextEditingController _controller = TextEditingController();
  final FocusNode _focusNode = FocusNode();

  bool get _isSearchNotEmpty => _controller.text.isNotEmpty;

  void _handleSearch(String text) {
    widget.onSearchChanged(text);
    setState(() {}); // Updates clear button visibility
  }

  void _clearSearch() {
    _controller.clear();
    _focusNode.requestFocus();
    _handleSearch("");
  }

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: BlaColors.backgroundAccent,
        borderRadius: BorderRadius.circular(BlaSpacings.radius),
      ),
      child: Row(
        children: [
          IconButton(
            onPressed: widget.onBackPressed,
            icon: Icon(Icons.arrow_back_ios, size: 16, color: BlaColors.iconLight),
          ),
          Expanded(
            child: TextField(
              controller: _controller,
              focusNode: _focusNode,
              onChanged: _handleSearch,
              style: TextStyle(color: BlaColors.textLight),
              decoration: const InputDecoration(
                hintText: "Any city, street...",
                border: InputBorder.none,
              ),
            ),
          ),
          if (_isSearchNotEmpty)
            IconButton(
              icon: Icon(Icons.close, color: BlaColors.iconLight),
              onPressed: _clearSearch,
            ),
        ],
      ),
    );
  }
}
