import 'dart:async';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:meet_halfway/app/router.dart';
import 'package:meet_halfway/app/theme/app_theme.dart';
import 'package:meet_halfway/core/geo/geo_math.dart';
import 'package:meet_halfway/core/geo/geo_point.dart';
import 'package:meet_halfway/features/meetup/domain/meetup_plan.dart';
import 'package:meet_halfway/features/places/domain/ranked_venue.dart';

/// Map with a marker per participant, the midpoint, and each venue.
class ResultsMap extends StatefulWidget {
  const ResultsMap({required this.plan, required this.venues, super.key});

  final MeetupPlan plan;
  final List<RankedVenue> venues;

  @override
  State<ResultsMap> createState() => _ResultsMapState();
}

class _ResultsMapState extends State<ResultsMap> {
  GoogleMapController? _controller;

  @override
  void didUpdateWidget(ResultsMap oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.plan != widget.plan) unawaited(_fitPlan());
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  Future<void> _fitPlan() async {
    final controller = _controller;
    if (controller == null) return;
    final points = [...widget.plan.origins, widget.plan.midpoint];
    final b = GeoMath.bounds(points);
    final update = b.southwest == b.northeast
        ? CameraUpdate.newLatLngZoom(_latLng(b.southwest), 14)
        : CameraUpdate.newLatLngBounds(
            LatLngBounds(
              southwest: _latLng(b.southwest),
              northeast: _latLng(b.northeast),
            ),
            48,
          );
    await controller.animateCamera(update);
  }

  static LatLng _latLng(GeoPoint p) => LatLng(p.latitude, p.longitude);

  static BitmapDescriptor _hue(Color color) =>
      BitmapDescriptor.defaultMarkerWithHue(HSVColor.fromColor(color).hue);

  Set<Marker> _markers(BuildContext context) => {
    for (final (i, p) in widget.plan.participants.indexed)
      Marker(
        markerId: MarkerId('participant-${p.id}'),
        position: _latLng(p.location!.point),
        icon: _hue(JewelColors.forParticipant(i)),
        infoWindow: InfoWindow(title: p.name, snippet: p.location!.label),
      ),
    Marker(
      markerId: const MarkerId('midpoint'),
      position: _latLng(widget.plan.midpoint),
      icon: _hue(JewelColors.amethyst),
      infoWindow: const InfoWindow(title: 'Midpoint'),
      zIndexInt: 1,
    ),
    for (final r in widget.venues)
      Marker(
        markerId: MarkerId('venue-${r.venue.id}'),
        position: _latLng(r.venue.location),
        icon: _hue(JewelColors.ruby),
        infoWindow: InfoWindow(
          title: r.venue.name,
          snippet: 'Tap for details',
          onTap: () => context.go(Routes.venue(r.venue.id)),
        ),
      ),
  };

  @override
  Widget build(BuildContext context) {
    return GoogleMap(
      initialCameraPosition: CameraPosition(
        target: _latLng(widget.plan.midpoint),
        zoom: 11,
      ),
      markers: _markers(context),
      circles: {
        Circle(
          circleId: const CircleId('search-area'),
          center: _latLng(widget.plan.midpoint),
          radius: widget.plan.searchRadiusMeters,
          strokeWidth: 1,
          strokeColor: JewelColors.amethyst,
          fillColor: JewelColors.amethyst.withValues(alpha: 0.08),
        ),
      },
      myLocationButtonEnabled: false,
      onMapCreated: (controller) {
        _controller = controller;
        unawaited(_fitPlan());
      },
    );
  }
}
