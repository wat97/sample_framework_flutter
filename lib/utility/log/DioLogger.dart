import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import 'log_base.dart';
import '../../config/config_base.dart';

class DioLogger {
  static void onSend(String tag, RequestOptions options) {
    if (EnvType.DEVELOPMENT == Env.value.environmentType ||
        EnvType.PRODUCTION == Env.value.environmentType) {
      debugPrint('header : ${options.headers}');
      Log.info(
          '$tag - request Path : [${options.method}] ${options.baseUrl}${options.path}');
      Log.info('$tag - request Data : ${options.data.toString()}');
    }
  }

  static void onSuccess(String tag, Response response) {
    if (EnvType.DEVELOPMENT == Env.value.environmentType ||
        EnvType.PRODUCTION == Env.value.environmentType) {
      Log.info(
          '$tag - Response Path : [${response.requestOptions.method}] ${response.requestOptions.baseUrl}${response.requestOptions.path} request Data : ${response.requestOptions.data.toString()}');
      Log.info('$tag - Response statusCode : ${response.statusCode}');
      Log.info('$tag - Response data : ${response.data.toString()}');
    }
  }

  static void onError(String tag, DioError error) {
    if (EnvType.DEVELOPMENT == Env.value.environmentType ||
        EnvType.PRODUCTION == Env.value.environmentType) {
      if (null != error.response) {
        Log.info(
            '$tag - Error Path : [${error.response!.requestOptions.method}] ${error.response!.requestOptions.baseUrl}${error.response!.requestOptions.path} request Data : ${error.response!.requestOptions.data.toString()}');
        Log.info('$tag - Error statusCode : ${error.response!.statusCode}');
        Log.info(
            '$tag - Error data : ${null != error.response!.data ? error.response!.data.toString() : ''}');
      }

      if (error.type == DioErrorType.connectTimeout ||
          error.type == DioErrorType.receiveTimeout) {
        debugPrint('No Internet');
      }
      Log.info('$tag - Error Message : ${error.message}');
    }
  }
}
