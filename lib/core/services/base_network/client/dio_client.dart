import 'dart:developer';
import 'dart:io';
import 'package:amino_therapy/core/services/base_network/interceptors/request_interceptor.dart';
import 'package:amino_therapy/core/services/base_network/interceptors/token_interceptor.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:http_certificate_pinning/http_certificate_pinning.dart';
import 'package:path/path.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

import '../../../data/constants/shared_preferences_constants.dart';
import '../../../global/enums/global_enum.dart';
import '../../flavorizer/flavors_managment.dart';
import '../../local_storage/secure_storage/secure_storage_service.dart';
import '../../local_storage/shared_preference/shared_preference_service.dart';
import '../../log/app_log.dart';
import '../api_endpoints_constants.dart';
import '../general_response_model.dart';

class DioClient {
  // Set base url base on Flavors
  String baseUrl() =>
      FlavorsManagement.instance.getCurrentFlavor.baseUrl ??
      ApiEndpointsConstants.baseUrl;

  // late final dio = Dio();
  late Dio dio;

  String? accessToken;
  dynamic headers;

  DioClient() {
    dio = Dio();
    dio
      ..options.baseUrl = baseUrl()
      ..options.connectTimeout = const Duration(seconds: 15)
      ..options.sendTimeout = const Duration(seconds: 60)
      ..options.receiveTimeout = const Duration(seconds: 360)
      ..httpClientAdapter
      ..options.validateStatus = (_) {
        return true;
      }
      ..options.headers = headers;
    dio.interceptors.add(
      PrettyDioLogger(
        requestHeader: true,
        requestBody: true,
        maxWidth: 90,
        enabled: kDebugMode,
        compact: false,
        logPrint: (object) => log(object.toString(), name: 'Test'),
      ),
    );
    dio.interceptors.add(RequestInterceptor());
    dio.interceptors.add(TokenInterceptor(dio));

    //
    if (FlavorsManagement.instance.getCurrentFlavor.flavorType !=
        FlavorsTypes.dev) {
      dio.interceptors.add(
        CertificatePinningInterceptor(
          allowedSHAFingerprints: [ApiEndpointsConstants.fingerPrint],
        ),
      );
    }
  }

  Future<dynamic> get({
    required String endPoint,
    Map<String, String>? headers,
    Map<String, dynamic>? queryParameters = const {},
    required dynamic model,
  }) async {
    if (headers != null && headers.isNotEmpty) {
    } else {
      headers = await addHeader();
    }
    try {
      final response = await dio.get(
        endPoint,
        queryParameters: queryParameters,
        options: Options(headers: headers),
      );
      if (response.statusCode == HttpStatus.ok ||
          response.statusCode == HttpStatus.created) {
        return Right(
          _jsonBodyParser(requestModel: model, responseBody: response.data),
        );
      } else {
        return Left(
          _jsonBodyParser(requestModel: model, responseBody: response.data),
        );
      }
    } catch (e) {
      final errorModel = mapDioExceptionToResponseModel(e);
      return Left(errorModel);
    }
  }

  Future<dynamic> post({
    required String endPoint,
    Map<String, String>? headers,
    Object? body = const {},
    Map<String, dynamic>? queryParameters = const {},
    required model,
  }) async {
    try {
      final response = await dio.post(
        endPoint,
        queryParameters: queryParameters,
        options: Options(headers: headers),
        data: body,
      );
      if (response.statusCode == HttpStatus.ok ||
          response.statusCode == HttpStatus.created) {
        return Right(
          _jsonBodyParser(requestModel: model, responseBody: response.data),
        );
      } else {
        return Left(
          _jsonBodyParser(requestModel: model, responseBody: response.data),
        );
      }
    } catch (e) {
      final errorModel = mapDioExceptionToResponseModel(e);
      return Left(errorModel);
    }
  }

  Future<dynamic> postMultiPartDataNew({
    required dynamic body,
    required String endPoint,
    Map<String, String>? headers,
    Map<String, dynamic>? queryParameters = const {},
    required model,
  }) async {
    try {
      Map<String, String>? modfiedHeader = headers;
      modfiedHeader!['Content-type'] = 'multipart/form-data';
      FormData formData = FormData.fromMap({
        ...body.toMap(),
        if (body!.file != null)
          "file": await MultipartFile.fromFile(
            body!.file!,
            filename: basename(body.file!),
          ),
      });
      // print('formData>>'+formData.fields.toString());
      // Create a FormData object
      final response = await dio.post(
        endPoint,
        queryParameters: queryParameters,
        options: Options(
          contentType: "multipart/form-data",
          headers: modfiedHeader,
        ),
        data: formData,
      );
      if (response.statusCode == HttpStatus.ok ||
          response.statusCode == HttpStatus.created) {
        return Right(
          _jsonBodyParser(requestModel: model, responseBody: response.data),
        );
      } else {
        return Left(
          _jsonBodyParser(requestModel: model, responseBody: response.data),
        );
      }
    } catch (e) {
      final errorModel = mapDioExceptionToResponseModel(e);
      return Left(errorModel);
    }
  }

  // Future<dynamic> put<T extends BaseModel>({
  Future<dynamic> put({
    required String endPoint,
    Map<String, String>? headers,
    Object? body = const {},
    Map<String, dynamic>? queryParameters = const {},
    required model,
  }) async {
    try {
      final response = await dio.put(
        endPoint,
        data: body,
        queryParameters: queryParameters,
        options: Options(headers: headers),
      );
      if (response.statusCode == HttpStatus.ok ||
          response.statusCode == HttpStatus.created) {
        return Right(
          _jsonBodyParser(requestModel: model, responseBody: response.data),
        );
      } else {
        return Left(
          _jsonBodyParser(requestModel: model, responseBody: response.data),
        );
      }
    } catch (e) {
      final errorModel = mapDioExceptionToResponseModel(e);
      return Left(errorModel);
    }
  }

  Future<dynamic> delete({
    required String endPoint,
    Map<String, String>? headers,
    Object? body = const {},
    Map<String, dynamic>? queryParameters = const {},
    required model,
  }) async {
    try {
      final response = await dio.delete(
        endPoint,
        queryParameters: queryParameters,
        options: Options(headers: headers),
      );
      if (response.statusCode == HttpStatus.ok ||
          response.statusCode == HttpStatus.created) {
        return Right(
          _jsonBodyParser(requestModel: model, responseBody: response.data),
        );
      } else {
        return Left(
          _jsonBodyParser(requestModel: model, responseBody: response.data),
        );
      }
    } catch (e) {
      final errorModel = mapDioExceptionToResponseModel(e);
      return Left(errorModel);
    }
  }

  dynamic _jsonBodyParser({
    required dynamic requestModel,
    required dynamic responseBody,
  }) {
    return requestModel.fromMap(responseBody);
  }

  Future<Map<String, String>> addHeader() async {
    String accessToken =
        await SecureStorageService().read(
          key: SharPrefConstants.userLoginTokenKey,
        ) ??
        '';
    AppLog.logValue('accessToken>>$accessToken');
    headers = dio
      ..options.headers = {
        'Accept': 'application/json',
        'Content-Type': 'application/json; charset=UTF-8',
        HttpHeaders.contentTypeHeader: ContentType.json.mimeType,
        HttpHeaders.authorizationHeader: 'Bearer $accessToken',
      };
    return {
      'Accept': 'application/json',
      'Content-Type': 'application/json; charset=UTF-8',
      HttpHeaders.contentTypeHeader: ContentType.json.mimeType,
      HttpHeaders.authorizationHeader: 'Bearer $accessToken',
    };
  }

  Future<void> updateHeader() async {
    accessToken = await SecureStorageService().read(
      key: SharPrefConstants.userLoginTokenKey,
    );
    AppLog.logValue('accessToken>> $accessToken');
    headers = dio
      ..options.headers = {
        'Accept': 'application/json',
        'Content-Type': 'application/json; charset=UTF-8',
        HttpHeaders.contentTypeHeader: ContentType.json.mimeType,
        HttpHeaders.authorizationHeader: 'Bearer ${accessToken ?? ''}',
      };
  }

  Future<void> deleteToken() async {
    // await FirebaseMessaging.instance.deleteToken();
    // globalFcmToken = null;
    await SecureStorageService().write(
      key: SharPrefConstants.userLoginTokenKey,
      value: '',
    );
    await SharedPreferenceService().setBool(
      SharPrefConstants.isLoginKey,
      false,
    );
  }
}

GeneralResponseModel mapDioExceptionToResponseModel(dynamic e) {
  if (e is DioException) {
    switch (e.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
      case DioExceptionType.connectionError:
      case DioExceptionType.unknown:
        return GeneralResponseModel(
          statusCode: "408",
          englishMessage: "requestTimeout".tr(),
          arabicMessage: "requestTimeout".tr(),
        );

      case DioExceptionType.cancel:
        return GeneralResponseModel(
          statusCode: "499",
          englishMessage: "requestCancelled".tr(),
          arabicMessage: "requestCancelled".tr(),
        );

      case DioExceptionType.badCertificate:
        return GeneralResponseModel(
          statusCode: "495",
          englishMessage: "badCertificate".tr(),
          arabicMessage: "badCertificate".tr(),
        );

      case DioExceptionType.badResponse:
        return GeneralResponseModel(
          statusCode: e.response?.statusCode?.toString() ?? "500",
          englishMessage: e.message ?? "serverError".tr(),
          arabicMessage: e.message ?? "serverError".tr(),
        );
    }
  } else {
    return GeneralResponseModel(
      statusCode: "unknown".tr(),
      englishMessage: "unexpectedError".tr(),
      arabicMessage: "unexpectedError".tr(),
    );
  }
}
