import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../models/place_model.dart';
import '../models/location_model.dart';
import '../providers/place_provider.dart';
import '../providers/midpoint_provider.dart';
import 'place_details_screen.dart';

class ResultsScreen extends StatefulWidget {
  const ResultsScreen({Key? key}) : super(key: key);

  @override
  State<ResultsScreen> createState() => _ResultsScreenState();
}

class _ResultsScreenState extends State<ResultsScreen> {
  final Map<String, String> _categoryLabels = {
    'restaurant': 'Restaurants',
    'cafe': 'Cafes',
    'bar': 'Bars',
    'park': 'Parks',
    'shopping_mall': 'Shopping',
    'movie_theater': 'Movies',
    'museum': 'Museums',
    'library': 'Libraries',
    'art_gallery': 'Art Galleries',
    'tourist_attraction': 'Attractions',
  };

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final midpoint = Provider.of<MidpointProvider>(context, listen: false).midpoint;
      if (midpoint != null) {
        Provider.of<PlaceProvider>(context, listen: false).searchPlaces(midpoint);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final midpoint = Provider.of<MidpointProvider>(context).midpoint;
    final placeProvider = Provider.of<PlaceProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Meeting Point Results'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () {
              if (midpoint != null) {
                placeProvider.searchPlaces(midpoint);
              }
            },
          ),
        ],
      ),
      body: placeProvider.isLoading
          ? const Center(child: CircularProgressIndicator())
          : placeProvider.filteredPlaces.isEmpty
              ? const Center(child: Text('No places found.'))
              : Column(
                  children: [
                    if (midpoint != null) _buildMap(midpoint),
                    _buildFilterChips(placeProvider),
                    _buildSortDropdown(placeProvider),
                    Expanded(child: _buildPlacesList(placeProvider)),
                  ],
                ),
    );
  }

  Widget _buildMap(Location midpoint) {
    return SizedBox(
      height: 200,
      child: GoogleMap(
        initialCameraPosition: CameraPosition(
          target: LatLng(midpoint.latitude, midpoint.longitude),
          zoom: 14,
        ),
        markers: {
          Marker(
            markerId: const MarkerId('midpoint'),
            position: LatLng(midpoint.latitude, midpoint.longitude),
            infoWindow: const InfoWindow(title: 'Midpoint'),
          ),
        },
      ),
    );
  }

  Widget _buildFilterChips(PlaceProvider provider) {
    return Container(
      height: 50,
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4.0),
            child: FilterChip(
              label: const Text('All'),
              selected: provider.selectedCategories.isEmpty,
              onSelected: (_) => provider.clearCategoryFilters(),
            ),
          ),
          ...provider.places
              .expand((place) => place.types)
              .toSet()
              .where((type) => _categoryLabels.containsKey(type))
              .map((type) => Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4.0),
                    child: FilterChip(
                      label: Text(_categoryLabels[type] ?? type),
                      selected: provider.selectedCategories.contains(type),
                      onSelected: (_) => provider.toggleCategory(type),
                    ),
                  ))
        ],
      ),
    );
  }

  Widget _buildSortDropdown(PlaceProvider provider) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      alignment: Alignment.centerLeft,
      child: DropdownButton<SortOption>(
        value: provider.sortOption,
        onChanged: provider.setSortOption,
        items: const [
          DropdownMenuItem(value: SortOption.distance, child: Text('Distance')),
          DropdownMenuItem(value: SortOption.rating, child: Text('Rating')),
          DropdownMenuItem(value: SortOption.priceAsc, child: Text('Price (Low to High)')),
          DropdownMenuItem(value: SortOption.priceDesc, child: Text('Price (High to Low)')),
        ],
      ),
    );
  }

  Widget _buildPlacesList(PlaceProvider provider) {
    return ListView.builder(
      itemCount: provider.filteredPlaces.length,
      itemBuilder: (context, index) {
        final place = provider.filteredPlaces[index];
        return ListTile(
          title: Text(place.name),
          subtitle: Text(place.vicinity ?? place.address ?? 'No address'),
          trailing: Text('${place.distanceFromMidpoint.toStringAsFixed(1)} km'),
          onTap: () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => PlaceDetailsScreen(place: place),
            ),
          ),
        );
      },
    );
  }
}
