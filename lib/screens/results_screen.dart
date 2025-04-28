import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../models/place_model.dart';
import '../providers/location_provider.dart';
import '../providers/midpoint_provider.dart';
import '../providers/place_provider.dart';
import 'place_details_screen.dart';

class ResultsScreen extends StatefulWidget {
  const ResultsScreen({Key? key}) : super(key: key);

  @override
  _ResultsScreenState createState() => _ResultsScreenState();
}

class _ResultsScreenState extends State<ResultsScreen> {
  GoogleMapController? _mapController;
  bool _isSearching = false;
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
      _searchPlaces();
    });
  }

  Future<void> _searchPlaces() async {
    final midpointProvider = Provider.of<MidpointProvider>(context, listen: false);
    final placeProvider = Provider.of<PlaceProvider>(context, listen: false);
    final midpoint = midpointProvider.midpoint;

    if (midpoint != null) {
      try {
        setState(() => _isSearching = true);
        await placeProvider.searchPlaces(midpoint);
      } catch (e) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Error searching places: ${e.toString()}')),
          );
        }
      } finally {
        if (mounted) {
          setState(() => _isSearching = false);
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final locationProvider = Provider.of<LocationProvider>(context);
    final midpointProvider = Provider.of<MidpointProvider>(context);
    final placeProvider = Provider.of<PlaceProvider>(context);

    final locationA = locationProvider.locationA;
    final locationB = locationProvider.locationB;
    final midpoint = midpointProvider.midpoint;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Meeting Point Results'),
        backgroundColor: const Color(0xFF4285F4),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: _searchPlaces,
          ),
        ],
      ),
      body: midpointProvider.isLoading || _isSearching
          ? const Center(child: CircularProgressIndicator())
          : midpointProvider.hasError
              ? Center(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(
                          Icons.error_outline,
                          color: Colors.red,
                          size: 60,
                        ),
                        const SizedBox(height: 16),
                        Text(
                          midpointProvider.errorMessage,
                          style: const TextStyle(color: Colors.red),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 24),
                        ElevatedButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: const Text('Go Back'),
                        ),
                      ],
                    ),
                  ),
                )
              : Column(
                  children: [
                    if (midpoint != null)
                      SizedBox(
                        height: 200,
                        child: GoogleMap(
                          onMapCreated: (controller) {
                            _mapController = controller;
                          },
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
                      ),
                    Container(
                      height: 50,
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: placeProvider.places.isEmpty
                          ? const Center(child: Text('No places found'))
                          : ListView(
                              scrollDirection: Axis.horizontal,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 4.0),
                                  child: FilterChip(
                                    label: const Text('All'),
                                    selected: placeProvider.selectedCategories.isEmpty,
                                    onSelected: (_) => placeProvider.clearCategoryFilters(),
                                  ),
                                ),
                                ...placeProvider.availableCategories
                                    .where((category) => _categoryLabels.containsKey(category))
                                    .map((category) => Padding(
                                          padding: const EdgeInsets.symmetric(horizontal: 4.0),
                                          child: FilterChip(
                                            label: Text(_categoryLabels[category] ?? category),
                                            selected: placeProvider.selectedCategories.contains(category),
                                            onSelected: (_) => placeProvider.toggleCategory(category),
                                          ),
                                        )),
                              ],
                            ),
                    ),
                    Container(
                      height: 50,
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Row(
                        children: [
                          const Text('Sort by: '),
                          const SizedBox(width: 8),
                          DropdownButton<SortOption>(
                            value: placeProvider.sortOption,
                            onChanged: (SortOption? newValue) {
                              if (newValue != null) {
                                placeProvider.setSortOption(newValue);
                              }
                            },
                            items: [
                              const DropdownMenuItem(
                                value: SortOption.distance,
                                child: Text('Distance'),
                              ),
                              const DropdownMenuItem(
                                value: SortOption.rating,
                                child: Text('Rating'),
                              ),
                              const DropdownMenuItem(
                                value: SortOption.priceAsc,
                                child: Text('Price (low to high)'),
                              ),
                              const DropdownMenuItem(
                                value: SortOption.priceDesc,
                                child: Text('Price (high to low)'),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: placeProvider.isLoading
                          ? const Center(child: CircularProgressIndicator())
                          : placeProvider.filteredPlaces.isEmpty
                              ? const Center(child: Text('No places match the selected filters'))
                              : ListView.builder(
                                  itemCount: placeProvider.filteredPlaces.length,
                                  itemBuilder: (context, index) {
                                    final place = placeProvider.filteredPlaces[index];
                                    return PlaceListItem(
                                      place: place,
                                      placeProvider: placeProvider,
                                    );
                                  },
                                ),
                    ),
                  ],
                ),
    );
  }

  String _formatDistance(double distanceKm) {
    if (distanceKm < 1) {
      return '${(distanceKm * 1000).toStringAsFixed(0)} m';
    } else {
      return '${distanceKm.toStringAsFixed(1)} km';
    }
  }
}

class PlaceListItem extends StatelessWidget {
  final Place place;
  final PlaceProvider placeProvider;

  const PlaceListItem({
    super.key,
    required this.place,
    required this.placeProvider,
  });

  @override
  Widget build(BuildContext context) {
    final photoUrl = place.photoReference != null
        ? placeProvider.getPhotoUrl(place)
        : null;

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => PlaceDetailsScreen(place: place),
            ),
          );
        },
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
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
                          errorBuilder: (context, error, stackTrace) {
                            return Container(
                              color: Colors.grey[300],
                              child: const Icon(Icons.image_not_supported),
                            );
                          },
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
                    Text(
                      place.name,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      place.vicinity ?? 'No address available',
                      style: TextStyle(
                        color: Colors.grey[600],
                        fontSize: 14,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        if (place.rating != null) ...[
                          Icon(
                            Icons.star,
                            size: 16,
                            color: Colors.amber[700],
                          ),
                          const SizedBox(width: 4),
                          Text(
                            '${place.rating!.toStringAsFixed(1)} (${place.userRatingsTotal ?? 0})',
                            style: const TextStyle(fontSize: 14),
                          ),
                          const SizedBox(width: 16),
                        ],
                        if (place.priceLevel != null) ...[
                          Text(
                            place.priceLevel!,
                            style: const TextStyle(fontSize: 14),
                          ),
                          const SizedBox(width: 16),
                        ],
                        Icon(
                          Icons.location_on,
                          size: 16,
                          color: Colors.blue[700],
                        ),
                        const SizedBox(width: 4),
                        Text(
                          '${place.distanceFromMidpoint.toStringAsFixed(1)} km',
                          style: const TextStyle(fontSize: 14),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}