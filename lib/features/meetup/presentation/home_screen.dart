import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:meet_halfway/app/router.dart';
import 'package:meet_halfway/app/theme/app_theme.dart';
import 'package:meet_halfway/features/locations/application/participants_controller.dart';
import 'package:meet_halfway/features/locations/presentation/location_input_field.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final participants = ref.watch(participantsProvider);
    final ready = ref.watch(allLocationsSetProvider);
    final theme = Theme.of(context);

    final fields = [
      for (final (i, p) in participants.indexed)
        LocationInputField(
          key: ValueKey(p.id),
          participant: p,
          color: JewelColors.forParticipant(i),
        ),
    ];

    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 520),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    'Meet Halfway',
                    style: theme.textTheme.headlineMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: theme.colorScheme.primary,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 32),
                  fields.first,
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(width: 48),
                      MeetButton(
                        enabled: ready,
                        onPressed: () => context.go(Routes.results),
                      ),
                      IconButton(
                        tooltip: 'Swap locations',
                        icon: const Icon(Icons.swap_vert),
                        onPressed: () => ref
                            .read(participantsProvider.notifier)
                            .swapFirstTwo(),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  ...fields
                      .skip(1)
                      .expand((f) => [f, const SizedBox(height: 16)]),
                  Text(
                    "We'll find a perfect meeting place for you both.",
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: theme.colorScheme.onSurfaceVariant,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

/// The large circular call to action.
class MeetButton extends StatelessWidget {
  const MeetButton({required this.enabled, required this.onPressed, super.key});

  final bool enabled;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox.square(
      dimension: 140,
      child: FilledButton(
        onPressed: enabled ? onPressed : null,
        style: FilledButton.styleFrom(
          shape: const CircleBorder(),
          backgroundColor: JewelColors.emerald,
          foregroundColor: Colors.white,
          elevation: 4,
        ),
        child: const Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.handshake_outlined, size: 36),
            SizedBox(height: 6),
            Text('Meet\nHalfway', textAlign: TextAlign.center),
          ],
        ),
      ),
    );
  }
}
