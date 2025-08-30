/// Base exception for Quran Cloud API errors
abstract class QuranCloudException implements Exception {
  final String message;
  final String? endpoint;
  final dynamic originalError;
  
  const QuranCloudException(this.message, {this.endpoint, this.originalError});
  
  @override
  String toString() => 'QuranCloudException: $message${endpoint != null ? ' (Endpoint: $endpoint)' : ''}';
}

/// Exception thrown when API request fails
class QuranApiException extends QuranCloudException {
  final int? statusCode;
  final Map<String, dynamic>? responseData;
  
  const QuranApiException(
    super.message, {
    this.statusCode,
    this.responseData,
    super.endpoint,
    super.originalError,
  });
  
  @override
  String toString() {
    final base = super.toString();
    if (statusCode != null) {
      return '$base (Status: $statusCode)';
    }
    return base;
  }
}

/// Exception thrown for network connectivity issues
class NetworkException extends QuranCloudException {
  final bool isOffline;
  final bool isTimeout;
  
  const NetworkException(
    super.message, {
    this.isOffline = false,
    this.isTimeout = false,
    super.endpoint,
    super.originalError,
  });
  
  @override
  String toString() {
    final base = super.toString();
    if (isOffline) {
      return '$base (Offline)';
    }
    if (isTimeout) {
      return '$base (Timeout)';
    }
    return base;
  }
}

/// Exception thrown for invalid data or parsing errors
class DataException extends QuranCloudException {
  final String? field;
  final String? expectedType;
  
  const DataException(
    super.message, {
    this.field,
    this.expectedType,
    super.endpoint,
    super.originalError,
  });
  
  @override
  String toString() {
    final base = super.toString();
    if (field != null) {
      return '$base (Field: $field${expectedType != null ? ', Expected: $expectedType' : ''})';
    }
    return base;
  }
}

/// Exception thrown for rate limiting
class RateLimitException extends QuranApiException {
  final Duration? retryAfter;
  
  const RateLimitException(
    super.message, {
    this.retryAfter,
    super.statusCode,
    super.responseData,
    super.endpoint,
    super.originalError,
  });
  
  @override
  String toString() {
    final base = super.toString();
    if (retryAfter != null) {
      return '$base (Retry after: ${retryAfter!.inSeconds}s)';
    }
    return base;
  }
}

/// Exception thrown for authentication errors
class AuthenticationException extends QuranApiException {
  const AuthenticationException(
    super.message, {
    super.statusCode,
    super.responseData,
    super.endpoint,
    super.originalError,
  });
}
