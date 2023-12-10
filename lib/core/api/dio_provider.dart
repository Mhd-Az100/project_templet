// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:async';
import 'dart:io';

import 'package:base_templet/core/api/exceptions.dart';
import 'package:base_templet/core/api/handle_exception.dart';
import 'package:base_templet/core/api/response_model.dart';
import 'package:base_templet/core/constants/enums.dart';
import 'package:base_templet/core/dependency_injection/injection_container.dart';
import 'package:base_templet/core/network_info/network_info.dart';
import 'package:base_templet/core/session_management/session.dart';
import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';

import 'domain_url.dart';

class DioProvider with BaseHandleApi {
  final Dio dio;
  final NetworkInfoImpl networkInfo;

  DioProvider(
    this.dio,
    this.networkInfo,
  );
  //
  // ignore: constant_identifier_names
  static const int TIME_OUT_DURATION = 60;

  Future<JsonResponse?> goApi({
    required String url,
    required ApiMethod method,
    dynamic body,
    Map<String, String>? additionalHeader,
    String? contentType,
  }) async {
    //
    //
    var baseHeader = {
      "Accept": "application/json",
      "lang": injection<GlobalSession>().getLang(),
      'Authorization': 'Bearer ${injection<GlobalSession>().getToken()}',
    };
    //
    Response? response;
    //
    baseHeader.addAll(additionalHeader ?? {});
    try {
      if (!(await networkInfo.isConnected)) {
        throw ApiNotRespondingException("error_not_responsed".tr());
      }
      switch (method) {
        //
        case ApiMethod.get:
          response = await dio
              .get(BaseUrl + url,
                  options: Options(
                    contentType: contentType,
                    headers: baseHeader,
                    followRedirects: false,
                  ))
              .timeout(const Duration(seconds: TIME_OUT_DURATION))
              .catchError(handleError);

          break;
        //
        case ApiMethod.post:
          response = await dio
              .post(BaseUrl + url,
                  options: Options(
                    contentType: contentType,
                    headers: baseHeader,
                    followRedirects: false,
                  ),
                  data: body)
              .timeout(const Duration(seconds: TIME_OUT_DURATION))
              .catchError(handleError);

          break;

        case ApiMethod.put:
          response = await dio
              .put(BaseUrl + url,
                  options: Options(
                    contentType: contentType,
                    headers: baseHeader,
                    followRedirects: false,
                  ),
                  data: body)
              .timeout(const Duration(seconds: TIME_OUT_DURATION))
              .catchError(handleError);

          break;

        case ApiMethod.delete:
          response = await dio
              .delete(
                BaseUrl + url,
                options: Options(
                  contentType: contentType,
                  headers: baseHeader,
                  followRedirects: false,
                ),
              )
              .timeout(const Duration(seconds: TIME_OUT_DURATION))
              .catchError(handleError);
          break;

        default:
      }
    } on SocketException {
      throw ApiNotRespondingException("error_not_responsed".tr());
    } on TimeoutException {
      throw ApiNotRespondingException("error_not_responsed".tr());
    } on DioException catch (e) {
      switch (e.response?.statusCode) {
        case 400:
        case 422:
          throw InvalidInputException("error_input".tr());
        case 401:
        case 403:
          throw UnauthorisedException("error_unauth".tr());
        case 500:
          throw FetchDataException("error_server".tr());
        default:
          throw FetchDataException("error_server".tr());
      }
    }
    if (response == null) {
      throw FetchDataException("error_server".tr());
    }
    final res = JsonResponse.fromJson(response.data);
    switch (response.statusCode) {
      case 200:
      case 201:
      case 202:
      case 203:
        return res;
      case 400:
      case 422:
        throw InvalidInputException(res.message ?? "error_input".tr());
      case 401:
      case 403:
        throw UnauthorisedException(res.message ?? "error_unauth".tr());
      case 500:
        throw FetchDataException(res.message ?? "error_server".tr());
      default:
        throw FetchDataException(res.message ?? "error_server".tr());
    }
  }
}
