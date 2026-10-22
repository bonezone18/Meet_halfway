import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meet_halfway/core/config/app_config.dart';
import 'package:meet_halfway/core/error/failure.dart';
import 'package:meet_halfway/core/platform/app_identity.dart';

/// Shared HTTP client for Google Maps Platform APIs (Places New, Routes).
///
/// The API key is attached as a header so it never appears in logged URLs.
/// App-identity headers let keys restricted to Android/iOS apps accept these
/// calls.
final dioProvider = Provider<Dio>((ref) {
  final config = ref.watch(appConfigProvider);
  final dio = Dio(
    BaseOptions(
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 15),
      headers: {
        'X-Goog-Api-Key': config.googleMapsApiKey,
        ...ref.watch(appIdentityProvider).headers,
      },
    ),
  );
  if (kDebugMode) {
    dio.interceptors.add(
      LogInterceptor(requestHeader: false, logPrint: (o) => debugPrint('$o')),
    );
  }
  ref.onDispose(dio.close);
  return dio;
});

/// Converts any error thrown while talking to an API into a [Failure].
Failure mapDioError(Object error) {
  if (error is Failure) return error;
  if (error is! DioException) return UnknownFailure(error);
  switch (error.type) {
    case DioExceptionType.connectionTimeout:
    case DioExceptionType.sendTimeout:
    case DioExceptionType.receiveTimeout:
    case DioExceptionType.transformTimeout:
    case DioExceptionType.connectionError:
      return const NetworkFailure();
    case DioExceptionType.badResponse:
      final status = error.response?.statusCode;
      if (status == 404) return const NotFoundFailure();
      return ApiFailure(
        _googleErrorMessage(error.response?.data) ??
            'Request failed ($status).',
        statusCode: status,
      );
    case DioExceptionType.badCertificate:
    case DioExceptionType.cancel:
    case DioExceptionType.unknown:
      return UnknownFailure(error);
  }
}

/// Google APIs return `{"error": {"message": "...", "status": "..."}}`.
String? _googleErrorMessage(Object? data) {
  if (data is Map && data['error'] is Map) {
    final message = (data['error'] as Map)['message'];
    if (message is String && message.isNotEmpty) return message;
  }
  return null;
}

/// Runs [request] and rethrows any failure as a typed [Failure].
Future<T> guardRequest<T>(Future<T> Function() request) async {
  try {
    return await request();
  } on Object catch (e) {
    throw mapDioError(e);
  }
}
