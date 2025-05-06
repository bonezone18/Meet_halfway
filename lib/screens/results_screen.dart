// lib/screens/results_screen.dart
import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../models/place_model.dart';
import '../models/location_model.dart';
import '../providers/place_provider.dart';
import '../providers/midpoint_provider.dart';
import '../providers/location_provider.dart';
import 'place_details_screen.dart';
import '../utils/navigation_transitions.dart';

class ResultsScreen extends StatefulWidget {
  const ResultsScreen({Key? key}) : super(key: key);

  @override
  State<ResultsScreen> createState() => _ResultsScreenState();
}

class _ResultsScreenState extends State<ResultsScreen> with SingleTickerProviderStateMixin {
  bool _isExpanded = true;
  late AnimationController _controller;
  late Animation<double> _animation;

  GoogleMapController? _mapController;

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
    _controller = AnimationController(vsync: this, duration: const Duration(milliseconds: 300));
    _animation = CurvedAnimation(parent: _controller, curve: Curves.easeInOut);
    _controller.forward();

    // Run initial search once the providers are ready
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final midpointProv = Provider.of<MidpointProvider>(context, listen: false);
      final locProv = Provider.of<LocationProvider>(context, listen: false);
      final midpoint = midpointProv.midpoint;
      final locationA = locProv.locationA;
      final locationB = locProv.locationB;
      if (midpoint != null && locationA != null && locationB != null) {
        Provider.of<PlaceProvider>(context, listen: false)
          .searchPlaces(midpoint, locationA, locationB);
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    _mapController?.dispose();
    super.dispose();
  }

  PageRouteBuilder _buildFadeRoute(Widget page) {
    return PageRouteBuilder(
      transitionDuration: const Duration(milliseconds: 400),
      reverseTransitionDuration: const Duration(milliseconds: 400),
      pageBuilder: (_, animation, __) => FadeTransition(
        opacity: animation,
        child: page,
      ),
      transitionsBuilder: (_, animation, __, child) => FadeTransition(opacity: animation, child: child),
    );
  }

  @override
  Widget build(BuildContext context) {
    final midpointProvider  = Provider.of<MidpointProvider>(context);
    final placeProvider     = Provider.of<PlaceProvider>(context);
    final locationProvider  = Provider.of<LocationProvider>(context);
    final midpoint          = midpointProvider.midpoint;
    final locationA         = locationProvider.locationA;
    final locationB         = locationProvider.locationB;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Meeting Point Results'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () {
              if (midpoint != null && locationA != null && locationB != null) {
                placeProvider.searchPlaces(midpoint, locationA, locationB);
              }
            },
          ),
        ],
      ),
      body: placeProvider.isLoading
        ? const Center(child: CircularProgressIndicator())
        : placeProvider.filteredPlaces.isEmpty
          ? const Center(child: Text('No places found.'))
          : SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Collapse / expand button
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton.icon(
                        onPressed: () {
                          setState(() {
                            _isExpanded = !_isExpanded;
                            _isExpanded ? _controller.forward() : _controller.reverse();
                          });
                        },
                        icon: Icon(_isExpanded ? Icons.expand_less : Icons.expand_more),
                        label: Text(_isExpanded ? 'Hide Map & Summary' : 'Show Map & Summary'),
                      ),
                    ],
                  ),

                  // Collapsible map & summary
                  SizeTransition(
                    sizeFactor: _animation,
                    axisAlignment: -1.0,
                    child: Column(
                      children: [
                        if (midpoint != null)
                          _buildMap(midpoint, locationA, locationB),
                        if (midpoint != null)
                          AnimatedSwitcher(
                            duration: const Duration(milliseconds: 400),
                            transitionBuilder: (child, anim) => SlideTransition(
                              position: Tween<Offset>(
                                begin: const Offset(0, 0.1),
                                end: Offset.zero,
                              ).animate(anim),
                              child: FadeTransition(opacity: anim, child: child),
                            ),
                            child: midpointProvider.buildTripSummaryCard(),
                          ),
                      ],
                    ),
                  ),

                  // Filters & sorting
                  _buildFilterChips(placeProvider),
                  _buildSortDropdown(placeProvider),

                  // Places list
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: placeProvider.filteredPlaces.length,
                    itemBuilder: (context, index) {
                      final place = placeProvider.filteredPlaces[index];
                      final photoUrl = place.photoReference != null
                        ? placeProvider.getPhotoUrl(place, maxWidth: 200)
                        : null;

                      return Card(
                        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                        elevation: 3,
                        child: InkWell(
                          onTap: () => Navigator.of(context).push(
                            _buildFadeRoute(PlaceDetailsScreen(place: place)),
                          ),
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
                                      ? Image.network(photoUrl, fit: BoxFit.cover)
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
                                        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                                      ),
                                      const SizedBox(height: 4),
                                      Text(
                                        place.vicinity ?? place.address ?? 'No address',
                                        style: TextStyle(color: Colors.grey[700]),
                                      ),
                                      const SizedBox(height: 8),
                                      Row(
                                        children: [
                                          if (place.rating != null) ...[
                                            Icon(Icons.star, size: 16, color: Colors.amber[700]),
                                            const SizedBox(width: 4),
                                            Flexible(
                                              child: Text(
                                                '${place.rating!.toStringAsFixed(1)} (${place.userRatingsTotal ?? 0})',
                                                style: const TextStyle(fontSize: 14),
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            ),
                                            const SizedBox(width: 16),
                                          ],
                                          Icon(Icons.location_on, size: 16, color: Colors.blue[700]),
                                          const SizedBox(width: 4),
                                          Flexible(
                                            child: Text(
                                              '${place.distanceFromMidpoint.toStringAsFixed(1)} km',
                                              style: const TextStyle(fontSize: 14),
                                              overflow: TextOverflow.ellipsis,
                                            ),
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
                    },
                  ),
                ],
              ),
            ),
    );
  }

  Widget _buildMap(Location midpoint, Location? locationA, Location? locationB) {
    // midpoint marker
    final midpointMarker = Marker(
      markerId: const MarkerId('midpoint'),
      position: LatLng(midpoint.latitude, midpoint.longitude),
      draggable: true,
      infoWindow: const InfoWindow(title: 'Drag to adjust midpoint'),
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),
      onDragEnd: (newPos) {
        final newMid = Location(
          latitude: newPos.latitude,
          longitude: newPos.longitude,
          name: 'Custom Midpoint',
        );
        Provider.of<MidpointProvider>(context, listen: false).setMidpoint(newMid);
        final locA = locationA, locB = locationB;
        if (locA != null && locB != null) {
          Provider.of<PlaceProvider>(context, listen: false)
            .searchPlaces(newMid, locA, locB);
        }
      },
    );

    final markers = <Marker>{ midpointMarker };
    if (locationA != null) {
      markers.add(Marker(
        markerId: const MarkerId('locationA'),
        position: LatLng(locationA.latitude, locationA.longitude),
        infoWindow: const InfoWindow(title: 'You'),
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
      ));
    }
    if (locationB != null) {
      markers.add(Marker(
        markerId: const MarkerId('locationB'),
        position: LatLng(locationB.latitude, locationB.longitude),
        infoWindow: const InfoWindow(title: 'Friend'),
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
      ));
    }

   /// return SizedBox(
    ///  height: 200,
    ///  child: GoogleMap(
    ///    key: const ValueKey('results_map'),
  /// Build a dynamic key so the map fully rebuilds whenever the coords change
    final mapKey = ValueKey(
      'map_${locationA?.latitude}_${locationA?.longitude}_'
      '${locationB?.latitude}_${locationB?.longitude}_'
      '${midpoint.latitude}_${midpoint.longitude}',
   );
   return SizedBox(
      height: 200,
      child: GoogleMap(
        key: mapKey,
        initialCameraPosition: CameraPosition(
          target: LatLng(midpoint.latitude, midpoint.longitude),
          zoom: 12, // zoomed out to show both points
        ),
        markers: markers,
        zoomControlsEnabled: true,
        myLocationButtonEnabled: false,
        onMapCreated: (controller) {
          // dispose previous controller if any
          _mapController?.dispose();
          _mapController = controller;

          // auto-fit all markers in view
          if (locationA != null && locationB != null) {
            final lats = [locationA.latitude, locationB.latitude, midpoint.latitude];
            final lngs = [locationA.longitude, locationB.longitude, midpoint.longitude];
            final bounds = LatLngBounds(
              southwest: LatLng(lats.reduce(math.min), lngs.reduce(math.min)),
              northeast: LatLng(lats.reduce(math.max), lngs.reduce(math.max)),
            );
            controller.moveCamera(CameraUpdate.newLatLngBounds(bounds, 50));
          }
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
              .expand((p) => p.types)
              .toSet()
              .where((type) => _categoryLabels.containsKey(type))
              .map((type) => Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4.0),
                    child: FilterChip(
                      label: Text(_categoryLabels[type]!),
                      selected: provider.selectedCategories.contains(type),
                      onSelected: (_) => provider.toggleCategory(type),
                    ),
                  )),
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
}
