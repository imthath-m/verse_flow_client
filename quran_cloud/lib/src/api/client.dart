import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import '../utils/constants.dart';
import '../utils/helpers.dart';
import 'exceptions.dart';

/// HTTP client for Al-Quran Cloud API
class QuranApiClient {
  late final Dio _dio;
  final String? _userAgent;
  final Duration _timeout;
  final int _retryAttempts;
  final Duration _retryDelay;

  /// Creates a new QuranApiClient instance
  QuranApiClient({
    String? userAgent,
    Duration? timeout,
    int? retryAttempts,
    Duration? retryDelay,
  }) : _userAgent = userAgent ?? QuranCloudConstants.userAgent,
       _timeout = timeout ?? QuranCloudConstants.defaultTimeout,
       _retryAttempts =
           retryAttempts ?? QuranCloudConstants.defaultRetryAttempts,
       _retryDelay = retryDelay ?? QuranCloudConstants.defaultRetryDelay {
    _initializeDio();
  }

  /// Initialize Dio HTTP client with configuration
  void _initializeDio() {
    final options = BaseOptions(
      baseUrl: QuranCloudConstants.baseUrl,
      connectTimeout: _timeout,
      receiveTimeout: _timeout,
      sendTimeout: _timeout,
      headers: {
        'User-Agent': _userAgent,
        'Accept': 'application/json',
        'Content-Type': 'application/json',
      },
    );
    if (kIsWeb) {
      // Add this to your Dio configuration
      options.headers['Access-Control-Allow-Origin'] = '*';
      options.headers['Access-Control-Allow-Methods'] =
          'GET,PUT,POST,DELETE,PATCH,OPTIONS';
    }
    _dio = Dio(options);

    // Add interceptors for logging and error handling
    _dio.interceptors.add(
      LogInterceptor(
        requestBody: false,
        responseBody: false,
        logPrint: (obj) => debugPrint('QuranApiClient: $obj'),
      ),
    );

    _dio.interceptors.add(
      InterceptorsWrapper(
        onError: (error, handler) {
          final exception = _handleError(error);
          handler.reject(exception);
        },
      ),
    );
  }

  /// Handle Dio errors and convert to QuranCloudException
  DioException _handleError(DioException error) {
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return DioException(
          requestOptions: error.requestOptions,
          error: NetworkException(
            'Request timeout',
            isTimeout: true,
            endpoint: error.requestOptions.path,
            originalError: error,
          ),
        );

      case DioExceptionType.connectionError:
        return DioException(
          requestOptions: error.requestOptions,
          error: NetworkException(
            'No internet connection',
            isOffline: true,
            endpoint: error.requestOptions.path,
            originalError: error,
          ),
        );

      case DioExceptionType.badResponse:
        final statusCode = error.response?.statusCode;
        final responseData = error.response?.data;

        if (statusCode == 429) {
          // Rate limiting
          final retryAfter = _parseRetryAfter(error.response?.headers);
          return DioException(
            requestOptions: error.requestOptions,
            error: RateLimitException(
              'Rate limit exceeded',
              statusCode: statusCode,
              responseData: responseData,
              endpoint: error.requestOptions.path,
              originalError: error,
              retryAfter: retryAfter,
            ),
          );
        } else if (statusCode == 401 || statusCode == 403) {
          // Authentication error
          return DioException(
            requestOptions: error.requestOptions,
            error: AuthenticationException(
              'Authentication failed',
              statusCode: statusCode,
              responseData: responseData,
              endpoint: error.requestOptions.path,
              originalError: error,
            ),
          );
        } else {
          // General API error
          return DioException(
            requestOptions: error.requestOptions,
            error: QuranApiException(
              'API request failed',
              statusCode: statusCode,
              responseData: responseData,
              endpoint: error.requestOptions.path,
              originalError: error,
            ),
          );
        }

      default:
        return DioException(
          requestOptions: error.requestOptions,
          error: NetworkException(
            'Network error: ${error.message}',
            endpoint: error.requestOptions.path,
            originalError: error,
          ),
        );
    }
  }

  /// Parse Retry-After header
  Duration? _parseRetryAfter(Headers? headers) {
    if (headers == null) return null;

    final retryAfter = headers.value('retry-after');
    if (retryAfter == null) return null;

    try {
      final seconds = int.parse(retryAfter);
      return Duration(seconds: seconds);
    } catch (e) {
      return null;
    }
  }

  /// Make a GET request with retry mechanism
  Future<Response<T>> get<T>(
    String path, {
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    return _makeRequestWithRetry(
      () =>
          _dio.get<T>(path, queryParameters: queryParameters, options: options),
    );
  }

  /// Make a POST request with retry mechanism
  Future<Response<T>> post<T>(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    return _makeRequestWithRetry(
      () => _dio.post<T>(
        path,
        data: data,
        queryParameters: queryParameters,
        options: options,
      ),
    );
  }

  /// Make a request with exponential backoff retry
  Future<Response<T>> _makeRequestWithRetry<T>(
    Future<Response<T>> Function() request,
  ) async {
    DioException? lastError;

    for (int attempt = 0; attempt <= _retryAttempts; attempt++) {
      try {
        return await request();
      } on DioException catch (error) {
        lastError = error;

        // Don't retry on certain errors
        if (error.error is AuthenticationException ||
            error.error is DataException) {
          rethrow;
        }

        // Don't retry on rate limiting unless we have retry-after
        if (error.error is RateLimitException) {
          final rateLimitError = error.error as RateLimitException;
          if (rateLimitError.retryAfter != null) {
            await QuranCloudHelpers.delay(rateLimitError.retryAfter!);
            continue;
          } else {
            rethrow;
          }
        }

        // Don't retry on network errors if we're offline
        if (error.error is NetworkException) {
          final networkError = error.error as NetworkException;
          if (networkError.isOffline) {
            rethrow;
          }
        }

        // If this is the last attempt, rethrow the error
        if (attempt == _retryAttempts) {
          rethrow;
        }

        // Calculate backoff delay
        final delay = QuranCloudHelpers.calculateBackoffDelay(
          attempt,
          baseDelay: _retryDelay,
        );
        await QuranCloudHelpers.delay(delay);
      }
    }

    // This should never be reached, but just in case
    throw lastError ??
        DioException(
          requestOptions: RequestOptions(path: ''),
          error: QuranApiException('Unknown error occurred'),
        );
  }

  /// Close the HTTP client
  void close() {
    _dio.close();
  }
}
