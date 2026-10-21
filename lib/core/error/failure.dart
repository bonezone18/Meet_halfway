/// Typed, user-presentable failures thrown by repositories.
///
/// The presentation layer only ever sees these (via `AsyncValue.error`), never
/// raw `DioException`s or platform exceptions.
sealed class Failure implements Exception {
  const Failure(this.message);

  /// A short, human-readable explanation suitable for showing in the UI.
  final String message;

  @override
  String toString() => 'Failure: $message';
}

/// No connectivity, timeouts, DNS failures, etc. Usually worth retrying.
class NetworkFailure extends Failure {
  const NetworkFailure([super.message = 'Check your internet connection.']);
}

/// The remote API rejected the request (bad key, quota, invalid argument...).
class ApiFailure extends Failure {
  const ApiFailure(super.message, {this.statusCode});

  final int? statusCode;
}

/// The requested resource does not exist.
class NotFoundFailure extends Failure {
  const NotFoundFailure([super.message = 'Nothing found.']);
}

/// The user denied a permission (e.g. location) or the service is disabled.
class PermissionFailure extends Failure {
  const PermissionFailure(super.message);
}

/// The request can't be made yet because user input is incomplete or invalid.
class ValidationFailure extends Failure {
  const ValidationFailure(super.message);
}

/// Anything unexpected. Carries the original error for logging.
class UnknownFailure extends Failure {
  const UnknownFailure(this.cause, [super.message = 'Something went wrong.']);

  final Object? cause;
}

/// Riverpod retry policy: only transient network failures are retried
/// (with exponential backoff). API errors (bad key, quota), validation and
/// permission failures are surfaced immediately instead of silently looping.
Duration? retryTransientFailures(int retryCount, Object error) {
  if (error is! NetworkFailure || retryCount >= 2) return null;
  return Duration(seconds: 1 << retryCount);
}

/// Extracts a display message from any error surfaced through `AsyncValue`.
String describeError(Object error) =>
    error is Failure ? error.message : 'Something went wrong.';
