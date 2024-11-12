import 'dart:io';

import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:fpdart/fpdart.dart';
import 'package:logger/logger.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

import '../../../config/api_path.dart';
import '../../../config/constants.dart';
import '../../../features/shared/splash/controllers/splash_controller.dart';
import '../../../main.dart';
import '../../errors/failure.dart';
import '../local_data_manager.dart';
import '../localization_service/localization_service.dart';

Logger logger = Logger();

enum _MethodType { post, get, put, patch, delete, download }

class ApiService {
  static const _connectTimeout = Duration(seconds: 30);
  static const _receiveTimeout = Duration(seconds: 30);
  static const _sendTimeout = Duration(seconds: 30);

  Map<String, String> get _defaultHeaders {
    final token = dataManager.getToken();
    return {
      'Accept-Language': getIt<LocaleService>().handleLocaleInMain.languageCode,
      "Content-Type": Headers.jsonContentType,
      "Accept": Headers.jsonContentType,
      if (token != null) 'Authorization': "Bearer $token",
    };
  }

  static final Dio _dio = Dio(
    BaseOptions(
      connectTimeout: _connectTimeout,
      receiveTimeout: _receiveTimeout,
      sendTimeout: _sendTimeout,
      baseUrl: ApiPath.baseurl,
    ),
  );

  static init() {
    (_dio.httpClientAdapter as IOHttpClientAdapter).createHttpClient =
        () => HttpClient()..badCertificateCallback = (x, y, z) => true;
  }

  // POST method
  Future<T> post<T>({
    dynamic requestBody,
    Map<String, dynamic>? header,
    bool returnDataOnly = true,
    CancelToken? cancelToken,
    bool ignoreError = false,
    bool logging = true,
    Duration? sendTimeOut = _sendTimeout,
    Duration? receiveTimeout = _receiveTimeout,
    // bool automaticManageIndicator = true,
    required String url,
    Map<String, dynamic> additionalHeaders = const {},
  }) async {
    return _hitApi(
      cancelToken: cancelToken,
      url: url,
      header: header,
      returnDataOnly: returnDataOnly,
      methodType: _MethodType.post,
      requestBody: requestBody,
      logging: logging,
      additionalHeaders: additionalHeaders,
      receiveTimeout: receiveTimeout,
      ignoreError: ignoreError,
      sendTimeOut: sendTimeOut,
    );
  }

  Future<T> patch<T>({
    dynamic requestBody,
    Map<String, dynamic>? header,
    bool ignoreError = false,
    bool returnDataOnly = true,
    bool logging = true,
    bool waitError = false,
    CancelToken? cancelToken,
    Duration? sendTimeOut = _sendTimeout,
    Duration? receiveTimeout = _receiveTimeout,
    // bool automaticManageIndicator = true,
    required String url,
    Map<String, dynamic> additionalHeaders = const {},
  }) async {
    return _hitApi(
      cancelToken: cancelToken,
      url: url,
      header: header,
      returnDataOnly: returnDataOnly,
      methodType: _MethodType.patch,
      requestBody: requestBody,
      additionalHeaders: additionalHeaders,
      logging: logging,
      receiveTimeout: receiveTimeout,
      sendTimeOut: sendTimeOut,
    );
  }

  // PUT method
  Future<T> put<T>({
    dynamic requestBody,
    Map<String, dynamic>? header,
    bool returnDataOnly = true,
    bool logging = true,
    bool waitError = false,
    CancelToken? cancelToken,
    Duration? sendTimeOut = _sendTimeout,
    Duration? receiveTimeout = _receiveTimeout,
    bool automaticManageIndicator = true,
    required String url,
    Map<String, dynamic> additionalHeaders = const {},
  }) async {
    return _hitApi(
      cancelToken: cancelToken,
      url: url,
      header: header,
      returnDataOnly: returnDataOnly,
      methodType: _MethodType.put,
      requestBody: requestBody,
      additionalHeaders: additionalHeaders,
      logging: logging,
      receiveTimeout: receiveTimeout,
      sendTimeOut: sendTimeOut,
    );
  }

  Future<T> get<T>({
    required String url,
    bool returnDataOnly = true,
    bool automaticManageIndicator = true,
    dynamic queryParameters,
    Duration? sendTimeOut = _sendTimeout,
    CancelToken? cancelToken,
    bool logging = true,
    bool waitError = false,
    Duration? receiveTimeout = _receiveTimeout,
    bool ignoreError = false,
    Map<String, dynamic> additionalHeaders = const {},
  }) async {
    return _hitApi(
      cancelToken: cancelToken,
      url: url,
      returnDataOnly: returnDataOnly,
      methodType: _MethodType.get,
      requestBody: queryParameters,
      additionalHeaders: additionalHeaders,
      logging: logging,
      receiveTimeout: receiveTimeout,
      sendTimeOut: sendTimeOut,
    );
  }

  Future<T> download<T>({
    required String url,
    CancelToken? cancelToken,
    bool waitError = false,
    dynamic queryParameters,
  }) async {
    return _hitApi(
      cancelToken: cancelToken,
      url: url,
      methodType: _MethodType.download,
      returnDataOnly: false,
      requestBody: queryParameters,
      receiveTimeout: Duration.zero,
      sendTimeOut: Duration.zero,
    );
  }

  Future<Either<T, Failure>> delete<T>({
    required String url,
    bool returnDataOnly = true,
    bool automaticManageIndicator = true,
    bool logging = true,
    CancelToken? cancelToken,
    dynamic queryParameters,
    Duration? sendTimeOut = _sendTimeout,
    bool ignoreError = false,
    Duration? receiveTimeout = _receiveTimeout,
    Map<String, dynamic> additionalHeaders = const {},
  }) async {
    return _hitApi(
      cancelToken: cancelToken,
      url: url,
      returnDataOnly: returnDataOnly,
      methodType: _MethodType.delete,
      requestBody: queryParameters,
      additionalHeaders: additionalHeaders,
      logging: logging,
      receiveTimeout: receiveTimeout,
      sendTimeOut: sendTimeOut,
    );
  }

  Future<T> _hitApi<T>({
    required _MethodType methodType,
    required String url,
    bool returnDataOnly = true,
    CancelToken? cancelToken,
    dynamic requestBody,
    bool logging = true,
    bool ignoreError = false,
    Map<String, dynamic>? header,
    Duration? sendTimeOut = _sendTimeout,
    Duration? receiveTimeout = _receiveTimeout,
    // bool automaticManageIndicator = true,
    Map<String, dynamic> additionalHeaders = const {},
  }) async {
    providerContainer.refresh(hasInternetProvider2);
    final Map<String, dynamic> headers =
        header ?? {..._defaultHeaders, ...additionalHeaders};

    if (logging) {
      logger.f(
        "$methodType:${_dio.options.baseUrl + url}\n$headers\n${requestBody ?? ''}",
      );
      if (requestBody is FormData) {
        logger.f((requestBody).fields);
        logger.f((requestBody).files);
      }
    }

    late String path;
    Response<dynamic> response;
    switch (methodType) {
      case _MethodType.post:
        response = await _dio.post(
          url,
          options: Options(
            headers: headers,
            receiveTimeout: receiveTimeout,
            sendTimeout: sendTimeOut,
          ),
          data: requestBody,
          cancelToken: cancelToken,
        );
        break;
      case _MethodType.get:
        response = await _dio.get(
          url,
          options: Options(
            headers: headers,
          ),
          queryParameters: requestBody,
          cancelToken: cancelToken,
        );
        break;
      case _MethodType.put:
        response = await _dio.put(
          url,
          options: Options(
            headers: headers,
            receiveTimeout: receiveTimeout,
            sendTimeout: sendTimeOut,
          ),
          data: requestBody,
          cancelToken: cancelToken,
        );
        break;
      case _MethodType.patch:
        response = await _dio.patch(
          url,
          options: Options(
            headers: headers,
            receiveTimeout: receiveTimeout,
            sendTimeout: sendTimeOut,
          ),
          data: requestBody,
          cancelToken: cancelToken,
        );
        break;
      case _MethodType.delete:
        response = await _dio.delete(
          url,
          options: Options(
            headers: headers,
          ),
          queryParameters: requestBody,
          cancelToken: cancelToken,
        );
        break;
      case _MethodType.download:
        path = join(await (getTemporaryDirectory().then((value) => value.path)),
            "${DateTime.now().millisecondsSinceEpoch}.pdf");
        response = await _dio.download(url, path,
            cancelToken: cancelToken, queryParameters: requestBody);
        break;
    }

    if (response.statusCode! >= 200 && response.statusCode! < 300) {
      if (Constants.loggerResponse && logging) logger.w(response.data);
      if (_MethodType.download == methodType) {
        return (path as T);
      } else {
        if (returnDataOnly) {
          return (response.data['data'] as T);
        } else {
          return (response.data as T);
        }
      }
    } else {
      throw DioException(requestOptions: response.requestOptions);
    }
  }
}

class APIError extends Failure {
  dynamic status = '';
  bool msgFromServer;

  APIError(
      {this.status,
      dynamic message,
      this.msgFromServer = false,
      required bool ignoreError})
      : super(message ?? '') {
    logger.e("code is $status , and the message is $message");
  }
}
