import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:meet_halfway/app/router.dart';
import 'package:meet_halfway/app/theme/app_theme.dart';
import 'package:meet_halfway/core/error/failure.dart';
import 'package:meet_halfway/core/geo/geo_math.dart';
import 'package:meet_halfway/core/utils/formatters.dart';
import 'package:meet_halfway/features/meetup/application/meetup_providers.dart';
import 'package:meet_halfway/features/meetup/domain/meetup_plan.dart';
import 'package:meet_halfway/features/places/application/venue_providers.dart';
import 'package:meet_halfway/features/places/presentation/results_map.dart';
import 'package:meet_halfway/features/places/presentation/venue_card.dart';
import 'package:meet_halfway/features/places/presentation/venue_filter_bar.dart';
import 'package:meet_halfway/shared/widgets/async_value_view.dart';

class ResultsScreen extends ConsumerWidget {
  const ResultsScreen({super.key});

  static const _wideLayoutBreakpoint = 900.0;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final plan = ref.watch(meetupPlanProvider);
    final unit = ref.watch(distanceUnitProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Meeting spots'),
        actions: [
          TextButton(
            onPressed: ref.read(distanceUnitProvider.notifier).toggle,
            child: Text(unit.symbol),
          ),
          IconButton(
            tooltip: 'Refresh',
            icon: const Icon(Icons.refresh),
            onPressed: () => ref.invalidate(nearbyVenuesProvider),
          ),
        ],
      ),
      body: switch (plan) {
        AsyncValue(error: final ValidationFailure f) => MessageView(
          icon: Icons.edit_location_alt_outlined,
          message: f.message,
          actionLabel: 'Back',
          onAction: () => context.go(Routes.home),
        ),
        _ => AsyncValueView(
          value: plan,
          data: (plan) => LayoutBuilder(
            builder: (context, constraints) {
              final venues = ref.watch(visibleVenuesProvider).value ?? const [];
              final map = ResultsMap(plan: plan, venues: venues);
              if (constraints.maxWidth >= _wideLayoutBreakpoint) {
                return Row(
                  children: [
                    Expanded(child: map),
                    SizedBox(width: 440, child: VenueResultsPanel(plan: plan)),
                  ],
                );
              }
              return Column(
                children: [
                  SizedBox(height: constraints.maxHeight * 0.38, child: map),
                  Expanded(child: VenueResultsPanel(plan: plan)),
                ],
              );
            },
          ),
        ),
      },
    );
  }
}

/// Summary, filters and the venue list. Separate from the map so it can be
/// tested and laid out independently.
class VenueResultsPanel extends ConsumerWidget {
  const VenueResultsPanel({required this.plan, super.key});

  final MeetupPlan plan;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final venues = ref.watch(visibleVenuesProvider);
    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(child: _PlanSummary(plan: plan)),
        const SliverToBoxAdapter(child: VenueFilterBar()),
        const SliverToBoxAdapter(child: SizedBox(height: 8)),
        switch (venues) {
          AsyncValue(hasValue: true, value: final list?) when list.isEmpty =>
            const SliverFillRemaining(
              hasScrollBody: false,
              child: MessageView(
                icon: Icons.search_off,
                message:
                    'No matching places near the midpoint. '
                    'Try other categories or turn off "Open now".',
              ),
            ),
          AsyncValue(hasValue: true, value: final list?) => SliverList.builder(
            itemCount: list.length,
            itemBuilder: (context, i) => VenueCard(
              ranked: list[i],
              participants: plan.participants,
              onTap: () => context.go(Routes.venue(list[i].venue.id)),
            ),
          ),
          _ => SliverFillRemaining(
            hasScrollBody: false,
            child: AsyncValueView(
              value: venues,
              onRetry: () => ref.invalidate(nearbyVenuesProvider),
              data: (_) => const SizedBox.shrink(),
            ),
          ),
        },
        const SliverToBoxAdapter(child: SizedBox(height: 16)),
      ],
    );
  }
}

class _PlanSummary extends ConsumerWidget {
  const _PlanSummary({required this.plan});

  final MeetupPlan plan;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final unit = ref.watch(distanceUnitProvider);
    final theme = Theme.of(context);
    return Card(
      margin: const EdgeInsets.fromLTRB(16, 16, 16, 8),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Midpoint', style: theme.textTheme.titleMedium),
            const SizedBox(height: 8),
            for (final (i, p) in plan.participants.indexed)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 2),
                child: Row(
                  children: [
                    Icon(
                      Icons.person_pin_circle,
                      size: 18,
                      color: JewelColors.forParticipant(i),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        '${p.name} · ${p.location!.label}',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Text(
                      formatDistance(
                        GeoMath.distanceMeters(
                          p.location!.point,
                          plan.midpoint,
                        ),
                        unit,
                      ),
                      style: theme.textTheme.labelLarge,
                    ),
                  ],
                ),
              ),
            const SizedBox(height: 4),
            Text(
              'Searching within '
              '${formatDistance(plan.searchRadiusMeters, unit)} '
              'of the midpoint.',
              style: theme.textTheme.bodySmall,
            ),
          ],
        ),
      ),
    );
  }
}
