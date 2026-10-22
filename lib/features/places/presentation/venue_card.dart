import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meet_halfway/app/theme/app_theme.dart';
import 'package:meet_halfway/core/utils/formatters.dart';
import 'package:meet_halfway/features/locations/domain/participant.dart';
import 'package:meet_halfway/features/meetup/presentation/fairness_badge.dart';
import 'package:meet_halfway/features/places/application/venue_providers.dart';
import 'package:meet_halfway/features/places/domain/ranked_venue.dart';
import 'package:meet_halfway/features/places/domain/venue.dart';

class VenueCard extends ConsumerWidget {
  const VenueCard({
    required this.ranked,
    required this.participants,
    required this.onTap,
    super.key,
  });

  final RankedVenue ranked;
  final List<Participant> participants;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final venue = ranked.venue;
    final unit = ref.watch(distanceUnitProvider);
    final theme = Theme.of(context);
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              VenueThumbnail(venue: venue),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      venue.name,
                      style: theme.textTheme.titleMedium,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 2),
                    Text(
                      venueSubtitle(venue),
                      style: theme.textTheme.bodySmall,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 8),
                    Wrap(
                      spacing: 12,
                      runSpacing: 4,
                      crossAxisAlignment: WrapCrossAlignment.center,
                      children: [
                        for (final (i, p) in participants.indexed)
                          if (i < ranked.distancesMeters.length)
                            _DistanceLabel(
                              name: p.name,
                              color: JewelColors.forParticipant(i),
                              text: formatDistance(
                                ranked.distancesMeters[i],
                                unit,
                              ),
                            ),
                        FairnessBadge(fairness: ranked.fairness),
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

/// `Cafe · ★ 4.5 (120) · $$ · Open now`
String venueSubtitle(Venue venue) {
  final rating = venue.rating;
  final count = venue.ratingCount;
  final open = venue.openNow;
  return [
    ?venue.primaryTypeLabel,
    if (rating != null && count != null)
      '★ ${rating.toStringAsFixed(1)} ($count)'
    else if (rating != null)
      '★ ${rating.toStringAsFixed(1)}',
    ?venue.priceLevel?.symbol,
    if (open == true) 'Open now' else if (open == false) 'Closed',
  ].join(' · ');
}

class VenueThumbnail extends ConsumerWidget {
  const VenueThumbnail({required this.venue, this.size = 64, super.key});

  final Venue venue;
  final double size;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final scheme = Theme.of(context).colorScheme;
    final placeholder = ColoredBox(
      color: scheme.surfaceContainerHighest,
      child: Icon(Icons.storefront, color: scheme.outline),
    );
    final photoName = venue.photoName;
    final photo = photoName == null
        ? null
        : ref.watch(venuePhotoProvider(photoName));
    return ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: SizedBox.square(
        dimension: size,
        child: photo == null
            ? placeholder
            : Image.network(
                photo.url,
                headers: photo.headers,
                fit: BoxFit.cover,
                errorBuilder: (_, _, _) => placeholder,
              ),
      ),
    );
  }
}

class _DistanceLabel extends StatelessWidget {
  const _DistanceLabel({
    required this.name,
    required this.color,
    required this.text,
  });

  final String name;
  final Color color;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(Icons.person_pin_circle, size: 16, color: color),
        const SizedBox(width: 2),
        Text('$name $text', style: Theme.of(context).textTheme.labelMedium),
      ],
    );
  }
}
