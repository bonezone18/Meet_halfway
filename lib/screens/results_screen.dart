// results_screen.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../models/place_model.dart';
import '../models/location_model.dart';
import '../providers/place_provider.dart';
import '../providers/midpoint_provider.dart';
import 'place_details_screen.dart';
import '../providers/location_provider.dart';
import '../utils/navigation_transitions.dart';

class ResultsScreen extends StatefulWidget {
  const ResultsScreen({Key? key}) : super(key: key);

  @override
  State<ResultsScreen> createState() => _ResultsScreenState();
}

class _ResultsScreenState extends State<ResultsScreen> {
  PageRouteBuilder _buildFadeRoute(Widget page) {
    return PageRouteBuilder(
      transitionDuration: const Duration(milliseconds: 400),
      reverseTransitionDuration: const Duration(milliseconds: 400),
      pageBuilder: (_, animation, __) => FadeTransition(
        opacity: animation,
        child: page,
      ),
      transitionsBuilder: (_, animation, __, child) {
        return FadeTransition(
          opacity: animation,
          child: child,
        );
      },
    );
  }

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
      final midpointProvider = Provider.of<MidpointProvider>(context, listen: false);
      final locationProvider = Provider.of<LocationProvider>(context, listen: false);
      final midpoint = midpointProvider.midpoint;
      final locA = locationProvider.locationA;
      final locB = locationProvider.locationB;

      if (midpoint != null && locA != null && locB != null) {
        Provider.of<PlaceProvider>(context, listen: false).searchPlaces(midpoint, locA, locB);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final midpointProvider = Provider.of<MidpointProvider>(context);
    final placeProvider = Provider.of<PlaceProvider>(context);
    final locationProvider = Provider.of<LocationProvider>(context);
    final midpoint = midpointProvider.midpoint;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Meeting Point Results'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () {
              final locA = locationProvider.locationA;
              final locB = locationProvider.locationB;

              if (midpoint != null && locA != null && locB != null) {
                placeProvider.searchPlaces(midpoint, locA, locB);
              }
            },
          ),
        ],
      ),
      body: placeProvider.isLoading
          ? const Center(child: CircularProgressIndicator())
          : placeProvider.hasError
              ? _buildErrorWidget(placeProvider.errorMessage)
              : placeProvider.filteredPlaces.isEmpty
                  ? const Center(child: Text('No places found.'))
                  : Column(
                      children: [
                        if (midpoint != null)
                          _buildInteractiveMap(midpoint, locationProvider, midpointProvider, placeProvider),
                        if (midpoint != null)
                          AnimatedSwitcher(
                            duration: const Duration(milliseconds: 400),
                            transitionBuilder: (child, animation) => SlideTransition(
                              position: Tween<Offset>(begin: const Offset(0, 0.1), end: Offset.zero).animate(animation),
                              child: FadeTransition(opacity: animation, child: child),
                            ),
                            child: midpointProvider.buildTripSummaryCard(),
                          ),
                        _buildFilterChips(placeProvider),
                        _buildSortDropdown(placeProvider),
                        Expanded(child: _buildPlacesList(placeProvider)),
                      ],
                    ),
    );
  }

  Widget _buildErrorWidget(String errorMessage) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.error_outline, color: Colors.redAccent, size: 60),
            const SizedBox(height: 20),
            Text(
              'Oops! Something went wrong.',
              style: Theme.of(context).textTheme.titleLarge,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 10),
            Text(
              errorMessage,
              style: Theme.of(context).textTheme.bodyMedium,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInteractiveMap(Location midpoint, LocationProvider locationProvider, MidpointProvider midpointProvider, PlaceProvider placeProvider) {
    return SizedBox(
      height: 300,
      child: GoogleMap(
        initialCameraPosition: CameraPosition(
          target: LatLng(midpoint.latitude, midpoint.longitude),
          zoom: 14,
        ),
        markers: {
          Marker(
            markerId: const MarkerId('midpoint'),
            position: LatLng(midpoint.latitude, midpoint.longitude),
            draggable: true,
            infoWindow: const InfoWindow(title: 'Drag to adjust midpoint'),
            onDragEnd: (LatLng newPosition) async {
              final newMidpoint = Location(
                latitude: newPosition.latitude,
                longitude: newPosition.longitude,
                name: 'Adjusted Midpoint',
              );
              midpointProvider.setMidpoint(newMidpoint);

              final locA = locationProvider.locationA;
              final locB = locationProvider.locationB;

              if (locA != null && locB != null) {
                await placeProvider.searchPlaces(newMidpoint, locA, locB);
              }
            },
          ),
        },
        zoomGesturesEnabled: true,
        scrollGesturesEnabled: true,
        myLocationButtonEnabled: false,
        zoomControlsEnabled: true,
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
          ...provider.places.expand((place) => place.types).toSet().where((type) => _categoryLabels.containsKey(type)).map(
                (type) => Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4.0),
                  child: FilterChip(
                    label: Text(_categoryLabels[type] ?? type),
                    selected: provider.selectedCategories.contains(type),
                    onSelected: (_) => provider.toggleCategory(type),
                  ),
                ),
              )
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
        final photoUrl = place.photoReference != null
            ? provider.getPhotoUrl(place, maxWidth: 200)
            : null;

        return Card(
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          elevation: 3,
          child: InkWell(
            onTap: () {
              Navigator.of(context).push(
              _buildFadeRoute(PlaceDetailsScreen(place: place)),
              );
            },
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8.0),
                    child: SizedBox(
                      width: 80,
                      height: 80,
                      child: photoUrl != null
                          ? Image.network(
                              photoUrl,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) => Container(
                                color: Colors.grey[300],
                                child: const Icon(Icons.image_not_supported),
                              ),
                            )
                          : Container(
                              color: Colors.grey[300],
                              child: const Icon(Icons.image_not_supported),
                            ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(place.name, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                        const SizedBox(height: 4),
                        Text(place.vicinity ?? place.address ?? 'No address', style: TextStyle(color: Colors.grey[700])),
                        const SizedBox(height: 8),
                        Row(
                          children: [
                            if (place.rating != null) ...[
                              Icon(Icons.star, size: 16, color: Colors.amber[700]),
                              const SizedBox(width: 4),
                              Text('${place.rating!.toStringAsFixed(1)} (${place.userRatingsTotal ?? 0})', style: const TextStyle(fontSize: 14)),
                              const SizedBox(width: 16),
                            ],
                            Icon(Icons.location_on, size: 16, color: Colors.blue[700]),
                            const SizedBox(width: 4),
                            Text('${place.distanceFromMidpoint.toStringAsFixed(1)} km', style: const TextStyle(fontSize: 14)),
                          ],
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}