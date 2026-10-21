import 'package:flutter/material.dart';
import 'package:meet_halfway/app/theme/app_theme.dart';
import 'package:meet_halfway/features/meetup/domain/fairness.dart';

extension FairnessColors on Fairness {
  Color get color => switch (this) {
    Fairness.balanced => JewelColors.emerald,
    Fairness.moderate => JewelColors.topaz,
    Fairness.unbalanced => JewelColors.ruby,
  };

  IconData get icon => switch (this) {
    Fairness.balanced => Icons.balance,
    Fairness.moderate => Icons.trending_flat,
    Fairness.unbalanced => Icons.warning_amber_rounded,
  };
}

class FairnessBadge extends StatelessWidget {
  const FairnessBadge({required this.fairness, super.key});

  final Fairness fairness;

  @override
  Widget build(BuildContext context) {
    final color = fairness.color;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(fairness.icon, size: 14, color: color),
          const SizedBox(width: 4),
          Text(
            fairness.label,
            style: Theme.of(context).textTheme.labelSmall
                ?.copyWith(color: color),
          ),
        ],
      ),
    );
  }
}
