import 'dart:math' as math;

/// How evenly a destination splits the trip between participants.
enum Fairness {
  balanced('Balanced'),
  moderate('Slightly uneven'),
  unbalanced('Uneven');

  const Fairness(this.label);

  final String label;

  /// Rates distances (or durations) from each participant to a destination by
  /// the gap between the longest and shortest trip, relative to the longest.
  ///
  /// A small absolute gap (under [tolerance], in the same unit as [values]) is
  /// always balanced, so two people 300 m vs 600 m away aren't "uneven".
  static Fairness of(List<double> values, {double tolerance = 1000}) {
    if (values.length < 2) return Fairness.balanced;
    final longest = values.reduce(math.max);
    final shortest = values.reduce(math.min);
    final gap = longest - shortest;
    if (gap <= tolerance || longest == 0) return Fairness.balanced;
    final ratio = gap / longest;
    if (ratio <= 0.2) return Fairness.balanced;
    if (ratio <= 0.4) return Fairness.moderate;
    return Fairness.unbalanced;
  }

  /// Spread used for ranking: lower is fairer.
  static double spread(List<double> values) =>
      values.isEmpty ? 0 : values.reduce(math.max) - values.reduce(math.min);
}
