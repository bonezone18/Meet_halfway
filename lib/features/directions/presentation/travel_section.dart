import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meet_halfway/app/theme/app_theme.dart';
import 'package:meet_halfway/core/error/failure.dart';
import 'package:meet_halfway/core/utils/formatters.dart';
import 'package:meet_halfway/features/directions/application/route_providers.dart';
import 'package:meet_halfway/features/directions/data/map_launcher.dart';
import 'package:meet_halfway/features/directions/domain/route_summary.dart';
import 'package:meet_halfway/features/directions/domain/travel_mode.dart';
import 'package:meet_halfway/features/meetup/domain/fairness.dart';
import 'package:meet_halfway/features/meetup/domain/meetup_plan.dart';
import 'package:meet_halfway/features/meetup/presentation/fairness_badge.dart';
import 'package:meet_halfway/features/places/domain/venue.dart';

/// Travel time for every participant to [venue], with a directions link each.
class TravelSection extends ConsumerWidget {
  const TravelSection({required this.plan, required this.venue, super.key});

  final MeetupPlan plan;
  final Venue venue;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final mode = ref.watch(travelModeProvider);
    final requests = [
      for (final origin in plan.origins)
        (origin: origin, destination: venue.location, mode: mode),
    ];
    final routes = [
      for (final r in requests) ref.watch(routeSummaryProvider(r)),
    ];
    final durations = [
      for (final r in routes)
        if (r.value case final summary?) summary.duration.inSeconds.toDouble(),
    ];
    final allLoaded = durations.length == routes.length;
    final unit = ref.watch(distanceUnitProvider);
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          children: [
            Text('Getting there', style: theme.textTheme.titleMedium),
            const Spacer(),
            if (allLoaded)
              FairnessBadge(
                // Within 5 minutes of each other always counts as balanced.
                fairness: Fairness.of(durations, tolerance: 300),
              ),
          ],
        ),
        const SizedBox(height: 8),
        SegmentedButton<TravelMode>(
          showSelectedIcon: false,
          segments: [
            for (final m in TravelMode.values)
              ButtonSegment(value: m, label: Text(m.label)),
          ],
          selected: {mode},
          onSelectionChanged: (s) =>
              ref.read(travelModeProvider.notifier).select(s.first),
        ),
        const SizedBox(height: 8),
        for (final (i, participant) in plan.participants.indexed)
          ListTile(
            contentPadding: EdgeInsets.zero,
            leading: Icon(
              Icons.person_pin_circle,
              color: JewelColors.forParticipant(i),
            ),
            title: Text(participant.name),
            subtitle: Text(_routeText(routes[i], unit)),
            trailing: IconButton(
              tooltip: 'Directions for ${participant.name}',
              icon: const Icon(Icons.directions),
              onPressed: () => _openDirections(ref, i, mode),
            ),
          ),
      ],
    );
  }

  static String _routeText(
    AsyncValue<RouteSummary?> value,
    DistanceUnit unit,
  ) => switch (value) {
    AsyncValue(:final error?, hasValue: false) => describeError(error),
    AsyncValue(hasValue: true, value: final RouteSummary summary) =>
      '${formatDuration(summary.duration)} · '
          '${formatDistance(summary.distanceMeters.toDouble(), unit)}',
    AsyncValue(hasValue: true) => 'No route for this travel mode',
    _ => 'Calculating…',
  };

  Future<void> _openDirections(WidgetRef ref, int index, TravelMode mode) {
    final launcher = ref.read(mapLauncherProvider);
    final origin = plan.origins[index];
    final uri = launcher.supportsAppleMaps
        ? MapLauncher.appleMapsDirections(
            origin: origin,
            destination: venue.location,
            mode: mode,
          )
        : MapLauncher.googleMapsDirections(
            origin: origin,
            destination: venue.location,
            destinationPlaceId: venue.id,
            mode: mode,
          );
    return launcher.open(uri);
  }
}
