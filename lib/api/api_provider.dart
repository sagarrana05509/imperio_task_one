// ignore_for_file: argument_type_not_assignable_to_error_handler, invalid_return_type_for_catch_error

import 'dart:io';


import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';

import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:imperio_task_one_demo/shared/constants/string_constant.dart';
import 'package:imperio_task_one_demo/shared/utils/common_widget.dart';

import 'api_constants.dart';
import 'interceptors/dio_connectivity_request_retrier.dart';
import 'interceptors/retry_interceptor.dart';

class ApiProvider {

  var dio = Dio();
  //final NetworkManager networkManager = Get.put(NetworkManager());
  Future postMethod(String path, dynamic data,
      {bool isMultipart = false, FormData? formData}) async {
    dio = initDio(path, isMultipart: isMultipart);
    print("API Request ======= $data");
    //("API Request :connectionType.value ======= ${connectionType.value}");

    //if (connectionType.value != 0) {
    Response response = await dio
        .post(path,
            data: isMultipart ? formData : data,
            options: Options(
              headers: {
                'accept': 'application/json',
                'Content-Type': 'application/json'
              },
            ))
        .catchError((DioException error) {
      print("==ERROR===${error.response}");
      // print("==ERROR${err.response}");
      //commonResponse = CommonResponse.fromJson(error.response?.data);

      return error;
    });
    print("RESPONSE ======= ${response.data}");

    if (response.data != null && response.statusCode == 200) {

      EasyLoading.dismiss();
      return response.data;

    } else {
      EasyLoading.dismiss();

      // CommonWidget.errorToast(StringConstant.serverError);
    }

    return response.data;
  }

  Future getMethod(String path,
      {Map<String, dynamic>? queryParameters}) async {
    dio = initDio(path);
    print('path ==> $path');
    print('queryParameters ==> $queryParameters');


    //print('dio : ${dio}');

    //if (connectionType.value != 0) {
    var response = await dio
        .get(
      path,
      options: Options(
        headers: {
          'accept': 'application/json',
          'Content-Type': 'application/json'
        },
      ),
      queryParameters: queryParameters,
    )
        .catchError((DioException e) {
      print("==ERROR===${e.toString()}");
      return e;
    });
    // print("RESPONSE ======= ${response.data}");
    if (response.statusCode == 200 && response.data != null) {
      EasyLoading.dismiss();


    } else {
      EasyLoading.dismiss();

      // CommonWidget.errorToast(
      //     commonResponse.dioMessage ?? StringConstant.serverError);
    }

    return response.data;
  }

  Future putMethod(String path,
      {Map<String, dynamic>? query,
      dynamic data,
      bool isMultipart = false,
      FormData? formData}) async {
    dio = initDio(path, isMultipart: isMultipart);

    print("API Request ======= $data");
    // Response response = await put(path, data);
    // if (connectionType.value != 0) {
    var response = await dio
        .put(
      path,
      data: isMultipart ? formData : data,
      options: Options(
        headers: {
          'accept': 'application/json',
        },
      ),
    )
        .catchError((e) {
      print("==ERROR===${e.toString()}");
      return e;
    });
    print("RESPONSE ======= ${response.data}");
    if (response.statusCode == 200 && response.data != null) {
      EasyLoading.dismiss();

    } else {
      EasyLoading.dismiss();

      // CommonWidget.errorToast(
      //     commonResponse.dioMessage ?? StringConstant.serverError);
    }

    return response.data;
  }

  Future deleteMethod(String path,
      {Map<String, dynamic>? data}) async {
    dio = initDio(
      path,
    );
    print("API Request ======= $data");

    //if (connectionType.value != 0) {
    Response response = await dio
        .delete(
      path,
      options: Options(
        headers: {
          'accept': 'application/json',
        },
      ),
      queryParameters: data,
    )
        .catchError((error) {
      print(error);
      return error;
    });
    print("RESPONSE ======= ${response.data}");

    if (response.data != null && response.statusCode == 200) {

      EasyLoading.dismiss();
    } else {
      EasyLoading.dismiss();

      CommonWidget.toast(StringConstant.serverError);
    }

    return response.data;
  }

  Dio initDio(String partUrl, {bool isMultipart = false}) {
    Map<String, dynamic>? headers = {};
    String acceptHeader;
    String contentTypeHeader;

    acceptHeader = 'application/json';
    contentTypeHeader =
        isMultipart ? 'multipart/form-data' : 'application/json';
    // final prefs = Get.find<SharedPreferences>();
    headers = {
      HttpHeaders.acceptHeader: acceptHeader,
      HttpHeaders.contentTypeHeader: contentTypeHeader,
      // HttpHeaders.authorizationHeader: token != null &&
      //         token.isNotEmpty &&
      //         !partUrl.toString().contains(ApiConstants.checkVersion)
      //     ? 'Bearer $token'
      //     : null
    };

    // debugPrint(Injector.prefs.getString(PrefKeys.token));
    BaseOptions options = BaseOptions(
      baseUrl: ApiConstants.baseUrl,
      connectTimeout: Duration(milliseconds: 20000),
      receiveTimeout: Duration(milliseconds: 30000),
      headers: headers,
    );
    dio.options = options;
    dio.interceptors.add(
      RetryOnConnectionChangeInterceptor(
        requestRetrier: DioConnectivityRequestRetrier(
          dio: Dio(),
          connectivity: Connectivity(),
        ),
      ),
    );
    return dio;
  }
}
