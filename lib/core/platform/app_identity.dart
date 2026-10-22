import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:package_info_plus/package_info_plus.dart';

/// Identifies this app to Google APIs.
///
/// API keys restricted to Android or iOS apps only accept REST calls (Places,
/// Routes) that say which app is calling. The native Maps SDK does this by
/// itself; our HTTP client has to send these headers explicitly.
@immutable
class AppIdentity {
  const AppIdentity({
    this.androidPackage,
    this.androidCertSha1,
    this.iosBundleId,
  });

  static const empty = AppIdentity();

  static const _channel = MethodChannel('meet_halfway/app_identity');

  final String? androidPackage;

  /// Signing certificate SHA-1, uppercase hex without colons.
  final String? androidCertSha1;
  final String? iosBundleId;

  Map<String, String> get headers => {
    if (androidPackage != null && androidCertSha1 != null) ...{
      'X-Android-Package': androidPackage!,
      'X-Android-Cert': androidCertSha1!,
    },
    'X-Ios-Bundle-Identifier': ?iosBundleId,
  };

  /// Reads the identity of the running app. Never throws: on failure (or on
  /// web, where the browser sends a Referer instead) it returns [empty].
  static Future<AppIdentity> load() async {
    if (kIsWeb) return empty;
    try {
      final info = await PackageInfo.fromPlatform();
      switch (defaultTargetPlatform) {
        case TargetPlatform.android:
          final sha1 = await _channel.invokeMethod<String>('signingCertSha1');
          return AppIdentity(
            androidPackage: info.packageName,
            androidCertSha1: sha1,
          );
        case TargetPlatform.iOS:
          return AppIdentity(iosBundleId: info.packageName);
        case TargetPlatform.fuchsia:
        case TargetPlatform.linux:
        case TargetPlatform.macOS:
        case TargetPlatform.windows:
          return empty;
      }
    } on Object catch (e) {
      debugPrint('Could not determine app identity: $e');
      return empty;
    }
  }
}

/// Overridden in `main.dart` with the loaded identity.
final appIdentityProvider = Provider<AppIdentity>((ref) => AppIdentity.empty);
