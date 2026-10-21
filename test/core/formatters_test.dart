import 'package:flutter_test/flutter_test.dart';
import 'package:meet_halfway/core/utils/formatters.dart';

void main() {
  test('formatDistance', () {
    expect(formatDistance(1609.344, DistanceUnit.miles), '1.0 mi');
    expect(formatDistance(25000, DistanceUnit.kilometers), '25 km');
    expect(formatDistance(500, DistanceUnit.kilometers), '0.5 km');
  });

  test('formatDuration', () {
    expect(formatDuration(const Duration(seconds: 30)), '< 1 min');
    expect(formatDuration(const Duration(minutes: 45)), '45 min');
    expect(formatDuration(const Duration(hours: 2)), '2 h');
    expect(formatDuration(const Duration(minutes: 65)), '1 h 5 min');
  });
}
