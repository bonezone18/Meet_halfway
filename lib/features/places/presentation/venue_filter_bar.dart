import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meet_halfway/features/places/application/venue_providers.dart';
import 'package:meet_halfway/features/places/domain/venue_category.dart';
import 'package:meet_halfway/features/places/domain/venue_filter.dart';

/// Category chips plus sort / "open now" controls.
class VenueFilterBar extends ConsumerWidget {
  const VenueFilterBar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final filter = ref.watch(venueFilterProvider);
    final controller = ref.read(venueFilterProvider.notifier);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            children: [
              for (final category in VenueCategory.values)
                Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: FilterChip(
                    label: Text(category.label),
                    selected: filter.categories.contains(category),
                    onSelected: (_) => controller.toggleCategory(category),
                  ),
                ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 4, 16, 0),
          child: Row(
            children: [
              FilterChip(
                avatar: const Icon(Icons.schedule, size: 18),
                label: const Text('Open now'),
                selected: filter.openNowOnly,
                onSelected: (value) => controller.setOpenNowOnly(value: value),
              ),
              const Spacer(),
              DropdownButton<SortOption>(
                value: filter.sort,
                underline: const SizedBox.shrink(),
                borderRadius: BorderRadius.circular(12),
                items: [
                  for (final option in SortOption.values)
                    DropdownMenuItem(value: option, child: Text(option.label)),
                ],
                onChanged: (option) {
                  if (option != null) controller.setSort(option);
                },
              ),
            ],
          ),
        ),
      ],
    );
  }
}
