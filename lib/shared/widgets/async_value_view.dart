import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meet_halfway/core/error/failure.dart';

/// Standard loading / error / data rendering for an [AsyncValue].
class AsyncValueView<T> extends StatelessWidget {
  const AsyncValueView({
    required this.value,
    required this.data,
    this.onRetry,
    super.key,
  });

  final AsyncValue<T> value;
  final Widget Function(T data) data;
  final VoidCallback? onRetry;

  @override
  Widget build(BuildContext context) {
    return switch (value) {
      AsyncValue(:final error?, hasValue: false) => MessageView(
        icon: Icons.error_outline,
        message: describeError(error),
        actionLabel: onRetry == null ? null : 'Try again',
        onAction: onRetry,
      ),
      AsyncValue(hasValue: true, :final value) => data(value as T),
      _ => const Center(child: CircularProgressIndicator()),
    };
  }
}

/// A centered icon + message, optionally with an action button.
class MessageView extends StatelessWidget {
  const MessageView({
    required this.icon,
    required this.message,
    this.actionLabel,
    this.onAction,
    super.key,
  });

  final IconData icon;
  final String message;
  final String? actionLabel;
  final VoidCallback? onAction;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 48, color: theme.colorScheme.outline),
            const SizedBox(height: 12),
            Text(
              message,
              style: theme.textTheme.bodyLarge,
              textAlign: TextAlign.center,
            ),
            if (actionLabel != null && onAction != null) ...[
              const SizedBox(height: 16),
              FilledButton.tonal(
                onPressed: onAction,
                child: Text(actionLabel!),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
