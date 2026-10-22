import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:meet_halfway/core/config/app_config.dart';
import 'package:meet_halfway/core/network/dio_client.dart';
import 'package:meet_halfway/core/platform/app_identity.dart';
import 'package:meet_halfway/features/locations/data/google_location_repository.dart';

import '../helpers/fakes.dart';

void main() {
  group('AppIdentity.headers', () {
    test('Android sends package and certificate', () {
      const identity = AppIdentity(
        androidPackage: 'com.meethalfway.meet_halfway',
        androidCertSha1: 'ABC123',
      );
      expect(identity.headers, {
        'X-Android-Package': 'com.meethalfway.meet_halfway',
        'X-Android-Cert': 'ABC123',
      });
    });

    test('Android without a certificate sends nothing', () {
      const identity = AppIdentity(androidPackage: 'com.example');
      expect(identity.headers, isEmpty);
    });

    test('iOS sends the bundle identifier', () {
      const identity = AppIdentity(iosBundleId: 'com.meethalfway.meetHalfway');
      expect(identity.headers, {
        'X-Ios-Bundle-Identifier': 'com.meethalfway.meetHalfway',
      });
    });

    test('empty identity sends nothing', () {
      expect(AppIdentity.empty.headers, isEmpty);
    });
  });

  test('requests carry the API key and app identity headers', () async {
    final container = ProviderContainer.test(
      overrides: [
        appConfigProvider.overrideWithValue(
          const AppConfig(googleMapsApiKey: 'test-key'),
        ),
        appIdentityProvider.overrideWithValue(
          const AppIdentity(androidPackage: 'com.pkg', androidCertSha1: 'F00'),
        ),
      ],
    );
    final adapter = FakeHttpAdapter(const {'suggestions': <Object>[]});
    final dio = container.read(dioProvider)..httpClientAdapter = adapter;

    await GoogleLocationRepository(dio).autocomplete('pizza');

    final headers = adapter.lastRequest!.headers;
    expect(headers['X-Goog-Api-Key'], 'test-key');
    expect(headers['X-Android-Package'], 'com.pkg');
    expect(headers['X-Android-Cert'], 'F00');
  });
}
