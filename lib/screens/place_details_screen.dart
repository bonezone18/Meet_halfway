import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter/animation.dart';
import '../models/place_model.dart';
import '../models/location_model.dart';
import '../providers/place_provider.dart';
import '../providers/location_provider.dart';
import '../providers/directions_provider.dart';
import 'directions_screen.dart';

class PlaceDetailsScreen extends StatefulWidget {
  final Place place;

  const PlaceDetailsScreen({super.key, required this.place});

  @override
  State<PlaceDetailsScreen> createState() => _PlaceDetailsScreenState();
}

class _PlaceDetailsScreenState extends State<PlaceDetailsScreen> with SingleTickerProviderStateMixin {
  bool _isGettingDirections = false;
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 100),
      vsync: this,
      lowerBound: 0.0,
      upperBound: 0.05,
    );
    _scaleAnimation = Tween<double>(begin: 1.0, end: 0.95).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeOut),
    );

    WidgetsBinding.instance.addPostFrameCallback((_) {
      final locationProvider = Provider.of<LocationProvider>(context, listen: false);
      final directionsProvider = Provider.of<DirectionsProvider>(context, listen: false);

      final locationA = locationProvider.locationA;
      final locationB = locationProvider.locationB;

      if (locationA != null) {
        directionsProvider.getDirectionsFromA(
          locationA,
          Location(latitude: widget.place.latitude, longitude: widget.place.longitude),
        );
      }
      if (locationB != null) {
        directionsProvider.getDirectionsFromB(
          locationB,
          Location(latitude: widget.place.latitude, longitude: widget.place.longitude),
        );
      }
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final placeProvider = Provider.of<PlaceProvider>(context);
    final directionsProvider = Provider.of<DirectionsProvider>(context);

    final photoUrl = widget.place.photoReference != null
        ? placeProvider.getPhotoUrl(widget.place, maxWidth: 800)
        : null;

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.place.name),
        backgroundColor: theme.colorScheme.primary,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildImage(photoUrl),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildHeader(widget.place, theme),
                  const SizedBox(height: 8),
                  _buildAddress(widget.place),
                  const SizedBox(height: 16),
                  _buildDistanceCard(widget.place, directionsProvider),
                  const SizedBox(height: 16),
                  _buildDetailsCard(widget.place, theme),
                  const SizedBox(height: 24),
                  _buildAnimatedButtons(context, theme),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildImage(String? photoUrl) {
    return Container(
      height: 200,
      width: double.infinity,
      child: photoUrl != null
          ? Image.network(
              photoUrl,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) => _buildImagePlaceholder(),
            )
          : _buildImagePlaceholder(),
    );
  }

  Widget _buildImagePlaceholder() {
    return Container(
      color: Colors.grey[300],
      child: const Icon(Icons.image_not_supported, size: 50),
    );
  }

  Widget _buildHeader(Place place, ThemeData theme) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Text(
            place.name,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
          ),
        ),
        if (place.rating != null)
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: const Color(0xFFF39C12), // Topaz-like
              borderRadius: BorderRadius.circular(16),
            ),
            child: Row(
              children: [
                const Icon(Icons.star, color: Colors.white, size: 16),
                const SizedBox(width: 4),
                Text(
                  place.rating!.toStringAsFixed(1),
                  style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
      ],
    );
  }

  Widget _buildAddress(Place place) {
    return place.vicinity != null
        ? Row(
            children: [
              const Icon(Icons.location_on, color: Colors.grey, size: 16),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  place.vicinity!,
                  style: TextStyle(color: Colors.grey[700]),
                ),
              ),
            ],
          )
        : const SizedBox();
  }

  Widget _buildDistanceCard(Place place, DirectionsProvider dp) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Distance Information', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
            const SizedBox(height: 8),
            Text('From midpoint: ${place.distanceFromMidpoint.toStringAsFixed(1)} km'),
            const SizedBox(height: 8),
            if (dp.isLoadingA || dp.isLoadingB)
              const Center(child: CircularProgressIndicator())
            else ...[
              Text('From you: ~${_estimateTravelTime(place.distanceFromMidpoint * 1.2)} min'),
              Text("From friend: ~${_estimateTravelTime(place.distanceFromMidpoint * 1.2)} min"),
            ]
          ],
        ),
      ),
    );
  }

  Widget _buildDetailsCard(Place place, ThemeData theme) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Details', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
            const SizedBox(height: 8),
            if (place.priceLevel != null)
              _iconTextRow(Icons.attach_money, 'Price level: ${place.priceLevel}', const Color(0xFF2ECC71)),
            const SizedBox(height: 8),
            _iconTextRow(
              place.isOpen ? Icons.check_circle : Icons.access_time,
              place.isOpen ? 'Open now' : 'Hours not available',
              place.isOpen ? const Color(0xFF2ECC71) : const Color(0xFFF39C12),
            ),
            const SizedBox(height: 8),
            _iconTextRow(Icons.category, 'Categories: ${_formatCategories(place.types)}', const Color(0xFF9B59B6)),
            if (place.userRatingsTotal != null)
              _iconTextRow(Icons.people, 'Based on ${place.userRatingsTotal} reviews', const Color(0xFF2980B9)),
          ],
        ),
      ),
    );
  }

  Widget _iconTextRow(IconData icon, String text, Color color) {
    return Row(
      children: [
        Icon(icon, size: 16, color: color),
        const SizedBox(width: 8),
        Expanded(child: Text(text)),
      ],
    );
  }

  Widget _buildAnimatedButtons(BuildContext context, ThemeData theme) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        GestureDetector(
          onTapDown: (_) => _animationController.forward(),
          onTapUp: (_) => _animationController.reverse(),
          onTapCancel: () => _animationController.reverse(),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => DirectionsScreen(place: widget.place)),
            );
          },
          child: ScaleTransition(
            scale: _scaleAnimation,
            child: ElevatedButton.icon(
              onPressed: null,
              icon: const Icon(Icons.directions),
              label: const Text('Directions'),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF2980B9), // Sapphire
                padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                elevation: 4,
              ),
            ),
          ),
        ),
        GestureDetector(
          onTapDown: (_) => _animationController.forward(),
          onTapUp: (_) => _animationController.reverse(),
          onTapCancel: () => _animationController.reverse(),
          onTap: () {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Share functionality coming soon')),
            );
          },
          child: ScaleTransition(
            scale: _scaleAnimation,
            child: ElevatedButton.icon(
              onPressed: null,
              icon: const Icon(Icons.share),
              label: const Text('Share'),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF9B59B6), // Amethyst
                padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                elevation: 4,
              ),
            ),
          ),
        ),
      ],
    );
  }

  String _formatCategories(List<String> types) {
    return types.map((t) => t.split('_').map((w) => w[0].toUpperCase() + w.substring(1)).join(' ')).join(', ');
  }

  int _estimateTravelTime(double distance) => (distance * 2.5).round();
}
