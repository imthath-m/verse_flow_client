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
    String message, {
    this.statusCode,
    this.responseData,
    String? endpoint,
    dynamic originalError,
  }) : super(message, endpoint: endpoint, originalError: originalError);
  
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
    String message, {
    this.isOffline = false,
    this.isTimeout = false,
    String? endpoint,
    dynamic originalError,
  }) : super(message, endpoint: endpoint, originalError: originalError);
  
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
    String message, {
    this.field,
    this.expectedType,
    String? endpoint,
    dynamic originalError,
  }) : super(message, endpoint: endpoint, originalError: originalError);
  
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
    String message, {
    this.retryAfter,
    int? statusCode,
    Map<String, dynamic>? responseData,
    String? endpoint,
    dynamic originalError,
  }) : super(
    message,
    statusCode: statusCode,
    responseData: responseData,
    endpoint: endpoint,
    originalError: originalError,
  );
  
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
    String message, {
    int? statusCode,
    Map<String, dynamic>? responseData,
    String? endpoint,
    dynamic originalError,
  }) : super(
    message,
    statusCode: statusCode,
    responseData: responseData,
    endpoint: endpoint,
    originalError: originalError,
  );
}
