import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meet_halfway/features/directions/data/map_launcher.dart';
import 'package:meet_halfway/features/directions/presentation/travel_section.dart';
import 'package:meet_halfway/features/meetup/application/meetup_providers.dart';
import 'package:meet_halfway/features/places/application/venue_providers.dart';
import 'package:meet_halfway/features/places/domain/venue.dart';
import 'package:meet_halfway/features/places/presentation/venue_card.dart';
import 'package:meet_halfway/shared/widgets/async_value_view.dart';

class VenueDetailsScreen extends ConsumerWidget {
  const VenueDetailsScreen({required this.venueId, super.key});

  final String venueId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final details = ref.watch(venueDetailsProvider(venueId));
    return Scaffold(
      appBar: AppBar(title: Text(details.value?.venue.name ?? 'Details')),
      body: AsyncValueView(
        value: details,
        onRetry: () => ref.invalidate(venueDetailsProvider(venueId)),
        data: (details) => _DetailsBody(details: details),
      ),
    );
  }
}

class _DetailsBody extends ConsumerWidget {
  const _DetailsBody({required this.details});

  final VenueDetails details;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final venue = details.venue;
    final theme = Theme.of(context);
    // The plan is absent when this page is opened directly (e.g. a web
    // refresh); details still render, just without travel times.
    final plan = ref.watch(meetupPlanProvider).value;
    final launcher = ref.watch(mapLauncherProvider);
    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 720),
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            if (venue.photoName != null)
              AspectRatio(
                aspectRatio: 16 / 9,
                child: LayoutBuilder(
                  builder: (context, c) =>
                      VenueThumbnail(venue: venue, size: c.maxWidth),
                ),
              ),
            const SizedBox(height: 16),
            Text(venue.name, style: theme.textTheme.headlineSmall),
            const SizedBox(height: 4),
            Text(venueSubtitle(venue), style: theme.textTheme.bodyMedium),
            if (venue.address.isNotEmpty) ...[
              const SizedBox(height: 4),
              Text(venue.address, style: theme.textTheme.bodySmall),
            ],
            if (details.summary != null) ...[
              const SizedBox(height: 12),
              Text(details.summary!),
            ],
            const SizedBox(height: 12),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                if (venue.googleMapsUri != null)
                  FilledButton.tonalIcon(
                    icon: const Icon(Icons.map_outlined),
                    label: const Text('Google Maps'),
                    onPressed: () =>
                        launcher.open(Uri.parse(venue.googleMapsUri!)),
                  ),
                if (details.phoneNumber != null)
                  OutlinedButton.icon(
                    icon: const Icon(Icons.call_outlined),
                    label: const Text('Call'),
                    onPressed: () => launcher.open(
                      Uri(
                        scheme: 'tel',
                        path: details.phoneNumber!.replaceAll(' ', ''),
                      ),
                    ),
                  ),
                if (details.websiteUri != null)
                  OutlinedButton.icon(
                    icon: const Icon(Icons.language),
                    label: const Text('Website'),
                    onPressed: () =>
                        launcher.open(Uri.parse(details.websiteUri!)),
                  ),
              ],
            ),
            if (plan != null) ...[
              const SizedBox(height: 24),
              TravelSection(plan: plan, venue: venue),
            ],
            if (details.weeklyHours.isNotEmpty) ...[
              const SizedBox(height: 16),
              ExpansionTile(
                leading: const Icon(Icons.schedule),
                title: const Text('Opening hours'),
                childrenPadding: const EdgeInsets.fromLTRB(16, 0, 16, 12),
                expandedCrossAxisAlignment: CrossAxisAlignment.start,
                children: [for (final line in details.weeklyHours) Text(line)],
              ),
            ],
          ],
        ),
      ),
    );
  }
}
