import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:login_ui_api_task/services/token_handler.dart';
import 'package:login_ui_api_task/utils/constants.dart';
import 'package:login_ui_api_task/utils/design_utlis.dart';

typedef OnUploadProgress = void Function(double progressValue);

class ApiAccess {
  final Dio dio = Dio();
  Future<bool> attemptLogIn({
    required String phone,
  }) async {
    try {
      Response res = await dio.post(
        "${Constants.baseURL}sendotp.php",
        data: {"mobile": phone},
        options: Options(responseType: ResponseType.json),
      );
      // print(res.data);
      var actualJson = jsonDecode(res.data.toString().trim());
      if (actualJson["status"]) {
        if (kDebugMode) {
          print(actualJson["status"]);
        }
        return true;
      }
    } on DioError catch (e) {
      return false;
    }
    return false;
  }

  Future otpVerify({
    required String phone,
    required String code,
  }) async {
    try {
      var data = {"request_id": phone, "code": code};
      Response res = await dio.post(
        "${Constants.baseURL}verifyotp.php",
        data: data,
        options: Options(responseType: ResponseType.json),
      );
      var actualJson = jsonDecode(res.data.toString().trim());
      if (actualJson["status"]) {
        if (kDebugMode) {
          print(actualJson);
        }
        TokenHandler.setAccessKey(actualJson['jwt']);
        return actualJson;
      } else {
        DesignUtlis.flutterToast(actualJson['response']);
      }
    } on DioError catch (e) {
      return null;
    }
    return null;
  }

  Future<bool> profilesubmit({
    required String name,
    required String email,
  }) async {
    try {
      var data = {"name": name, "email": email};
      final jwtToken = await TokenHandler.getToken();
      Response res = await dio.post(
        "${Constants.baseURL}profilesubmit.php",
        data: data,
        options: Options(
          responseType: ResponseType.json,
          headers: {'Token': jwtToken},
        ),
      );
      var actualJson = jsonDecode(res.data.toString().trim());
      if (actualJson["status"]) {
        if (kDebugMode) {
          print(actualJson["status"]);
        }
        return true;
      } else {
        DesignUtlis.flutterToast(actualJson['response']);
      }
    } on DioError catch (e) {
      return false;
    }
    return false;
  }
}
