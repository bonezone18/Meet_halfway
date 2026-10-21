import 'package:flutter_riverpod/flutter_riverpod.dart';

enum DistanceUnit {
  miles('mi', 1609.344),
  kilometers('km', 1000);

  const DistanceUnit(this.symbol, this.metersPerUnit);

  final String symbol;
  final double metersPerUnit;
}

/// User preference for displaying distances. Defaults to miles.
class DistanceUnitController extends Notifier<DistanceUnit> {
  @override
  DistanceUnit build() => DistanceUnit.miles;

  void toggle() => state = state == DistanceUnit.miles
      ? DistanceUnit.kilometers
      : DistanceUnit.miles;
}

final distanceUnitProvider =
    NotifierProvider<DistanceUnitController, DistanceUnit>(
      DistanceUnitController.new,
    );

/// `0.3 mi`, `12 mi`, `1.5 km`.
String formatDistance(double meters, DistanceUnit unit) {
  final value = meters / unit.metersPerUnit;
  final digits = value < 10 ? 1 : 0;
  return '${value.toStringAsFixed(digits)} ${unit.symbol}';
}

/// `45 min`, `1 h 5 min`, `< 1 min`.
String formatDuration(Duration duration) {
  if (duration.inMinutes < 1) return '< 1 min';
  final hours = duration.inHours;
  final minutes = duration.inMinutes.remainder(60);
  if (hours == 0) return '$minutes min';
  if (minutes == 0) return '$hours h';
  return '$hours h $minutes min';
}
