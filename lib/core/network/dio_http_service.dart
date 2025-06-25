import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'http_service.dart';
import 'package:tfg_2025_mobile/core/error/exceptions.dart';
import '../config/remote_config_service.dart';

class DioHttpService implements HttpService {
  late final Dio _dio;

  DioHttpService({
    String? baseUrl,
    Map<String, dynamic>? headers,
    int? timeoutSeconds,
  }) {
    // Usar configuraciones de Remote Config con fallbacks
    final effectiveBaseUrl = baseUrl ?? RemoteConfigService.apiBaseUrl;
    final effectiveConnectTimeout = timeoutSeconds != null
        ? Duration(seconds: timeoutSeconds)
        : Duration(milliseconds: RemoteConfigService.connectTimeout);
    final effectiveReceiveTimeout =
        Duration(milliseconds: RemoteConfigService.receiveTimeout);
    final effectiveSendTimeout =
        Duration(milliseconds: RemoteConfigService.sendTimeout);

    _dio = Dio(
      BaseOptions(
        baseUrl: effectiveBaseUrl,
        headers: headers,
        connectTimeout: effectiveConnectTimeout,
        receiveTimeout: effectiveReceiveTimeout,
        sendTimeout: effectiveSendTimeout,
      ),
    );

    if (kDebugMode) {
      _dio.interceptors.add(
        PrettyDioLogger(
          requestHeader: true,
          requestBody: true,
          responseHeader: true,
        ),
      );

      // Log de configuración en debug
      print('🌐 HTTP Service configurado:');
      print('   Base URL: $effectiveBaseUrl');
      print('   Connect Timeout: ${effectiveConnectTimeout.inMilliseconds}ms');
      print('   Receive Timeout: ${effectiveReceiveTimeout.inMilliseconds}ms');
      print('   Send Timeout: ${effectiveSendTimeout.inMilliseconds}ms');
    }

    _dio.interceptors.add(
      InterceptorsWrapper(
        onError: (error, handler) {
          return handler.next(_handleError(error));
        },
      ),
    );
  }

  /// Constructor factory que usa completamente Remote Config
  factory DioHttpService.fromRemoteConfig({
    Map<String, dynamic>? headers,
  }) {
    return DioHttpService(
      baseUrl: RemoteConfigService.apiBaseUrl,
      headers: headers,
    );
  }

  @override
  void addInterceptor(Interceptor interceptor) {
    _dio.interceptors.add(interceptor);
  }

  @override
  void removeInterceptor(Interceptor interceptor) {
    _dio.interceptors.remove(interceptor);
  }

  @override
  Future<Response<T>> get<T>(
    String path, {
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
  }) async {
    try {
      return await _dio.get<T>(
        path,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
      );
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  @override
  Future<Response<T>> post<T>(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
  }) async {
    try {
      return await _dio.post<T>(
        path,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
      );
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  @override
  Future<Response<T>> put<T>(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
  }) async {
    try {
      return await _dio.put<T>(
        path,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
      );
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  @override
  Future<Response<T>> delete<T>(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
  }) async {
    try {
      return await _dio.delete<T>(
        path,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
      );
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  DioException _handleError(DioException error) {
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        throw TimeoutException(error.message);
      case DioExceptionType.badResponse:
        switch (error.response?.statusCode) {
          case 400:
            throw BadRequestException(error.response?.data['message']);
          case 401:
            throw UnauthorizedException(error.response?.data['message']);
          case 403:
            throw ForbiddenException(error.response?.data['message']);
          case 404:
            throw NotFoundException(error.response?.data['message']);
          case 500:
            throw ServerException(error.response?.data['message']);
        }
        break;
      case DioExceptionType.cancel:
        break;
      case DioExceptionType.unknown:
        throw NoInternetException(error.message);
      default:
        throw UnknownException(error.message);
    }
    return error;
  }

  /// Actualiza la configuración desde Remote Config
  void updateConfigFromRemoteConfig() {
    _dio.options.baseUrl = RemoteConfigService.apiBaseUrl;
    _dio.options.connectTimeout =
        Duration(milliseconds: RemoteConfigService.connectTimeout);
    _dio.options.receiveTimeout =
        Duration(milliseconds: RemoteConfigService.receiveTimeout);
    _dio.options.sendTimeout =
        Duration(milliseconds: RemoteConfigService.sendTimeout);

    if (kDebugMode) {
      print('🔄 HTTP Service configuración actualizada desde Remote Config');
    }
  }
}
