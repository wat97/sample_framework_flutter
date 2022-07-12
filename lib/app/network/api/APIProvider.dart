import 'dart:convert';
import 'dart:io';

import 'package:app_settings/app_settings.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:cookie_jar/cookie_jar.dart';
import 'package:dio/dio.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' hide Response;
import 'package:pretty_json/pretty_json.dart';

import '../../../config/config_base.dart';
import '../../../utility/log/log_base.dart';

import 'package:shared_preferences/shared_preferences.dart';

class APIProvider {
  static const String TAG = 'APIProvider';

  static String _baseUrl = Env.value.baseUrl;
  late bool isConnected = false;
  late Dio _dio;
  late BaseOptions dioOptions;

  var storage = Get.find<SharedPreferences>();

  APIProvider() {
    dioOptions = BaseOptions()..baseUrl = APIProvider._baseUrl;
    dioOptions.validateStatus = (value) {
      return value! < 500;
    };

    _dio = Dio(dioOptions);
    var cookieJar = CookieJar();
    _dio.interceptors.add(CookieManager(cookieJar));

    _dio.interceptors
        .add(InterceptorsWrapper(onRequest: (options, handler) async {
      DioLogger.onSend(TAG, options);

      await checkConnectivity();
      return handler.next(options);
    }, onResponse: (response, handler) {
      DioLogger.onSuccess(TAG, response);

      print(prettyJson(response.data, indent: 2));
      return handler.next(response);
    }, onError: (DioError error, handler) {
      DioLogger.onError(TAG, error);
      throwIfNoSuccess(error);
      return handler.next(error);
    }));
  }

  Future<bool> _checkInternetConnection() async {
    bool _isConnected = true;
    try {
      final response = await InternetAddress.lookup('www.google.com');
      if (response.isNotEmpty) {
        _isConnected = true;
        print("Connected ${_isConnected}");
      }
    } on SocketException catch (err) {
      _isConnected = false;
      print("ConnectedNot ${_isConnected}");
    }
    return _isConnected;
  }

  Future<Response> postData(String path, dynamic data) async {
    try {
      var response = await _dio.post(
        path,
        data: data,
      );
      return response;
    } on DioError catch (ex) {
      throw new Exception(json.decode(ex.response.toString())["error"]);
    }
  }

  Future<Response> postDataSecure(String path, dynamic data) async {
    try {
      var response = await _dio.post(
        path,
        data: data,
      );
      return response;
    } on DioError catch (ex) {
      throw new Exception(json.decode(ex.response.toString())["error"]);
    }
  }

  Future<Response> getData(String path) async {
    try {
      var response = await _dio.get(path);
      return response;
    } on DioError catch (ex) {
      throw new Exception(json.decode(ex.response.toString())["error"]);
    }
  }

  noInternetWarning() async {
    await Get.defaultDialog(
      title: "no_internet".tr,
      titlePadding: EdgeInsets.all(20),
      titleStyle: TextStyle(fontSize: 14),
      contentPadding: EdgeInsets.only(bottom: 20, left: 14, right: 14),
      middleText: "check_connect".tr,
      middleTextStyle: TextStyle(
        fontSize: 10,
      ),
      confirm: ElevatedButton(
        onPressed: () => AppSettings.openDataRoamingSettings(),
        child: Text("setting".tr),
        style: ElevatedButton.styleFrom(
          primary: Colors.green,
          onPrimary: Colors.white,
          shadowColor: Colors.transparent,
          textStyle: TextStyle(
            color: Colors.white,
            fontSize: 12.44,
            fontFamily: "Poppins",
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      cancel: ElevatedButton(
        onPressed: () => exit(0),
        child: Text("close".tr),
        style: ElevatedButton.styleFrom(
          primary: Colors.red,
          onPrimary: Colors.white,
          shadowColor: Colors.transparent,
          textStyle: TextStyle(
            color: Colors.white,
            fontSize: 12.44,
            fontFamily: "Poppins",
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }

  checkConnectivity() async {
    Connectivity().checkConnectivity();
    var connectivityResult = await (Connectivity().checkConnectivity());
    print("CheckConnectivity ${connectivityResult}");
    if (connectivityResult == ConnectivityResult.none) {
      Get.back();
      this.isConnected = false;
      noInternetWarning();
    } else {
      this.isConnected = true;
    }
  }

  void throwIfNoSuccess(DioError ex) async {
    if (ex.response!.statusCode! < 200 || ex.response!.statusCode! > 299) {
      String errorMessage = json.decode(ex.response.toString())["error"] ??
          json.decode(ex.response.toString())["message"];
      Get.snackbar(
        'Oops..',
        errorMessage,
        backgroundColor: Color(0xFF3F4E61),
      );
      throw new Exception(errorMessage);
    }
  }
}
