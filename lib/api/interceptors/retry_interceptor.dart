import 'dart:io';


import 'package:dio/dio.dart';

import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart' as getx;
import 'package:imperio_task_one_demo/shared/constants/string_constant.dart';
import 'package:imperio_task_one_demo/shared/utils/common_widget.dart';


import 'dio_connectivity_request_retrier.dart';

class RetryOnConnectionChangeInterceptor extends Interceptor {
  final DioConnectivityRequestRetrier requestRetrier;

  RetryOnConnectionChangeInterceptor({
    required this.requestRetrier,
  });
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {


      EasyLoading.show(status: 'loading...');

    super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    print(
        'Request: URL ${response.requestOptions.method.toUpperCase()}: ${response.requestOptions.uri}');
    print('Request: Headers ${response.headers}');
    print('Response: Status ${response.statusCode}');
    print('Response: Status ${response.statusMessage}');
    print('Response: Body ${response.data.toString()}');
    EasyLoading.dismiss();
    // if (response.statusCode == 200) {
    //   return;
    // }
    // if (response.statusCode == 200 && response.data != null) {
    //   EasyLoading.dismiss();
    //   var commonResponse = CommonResponse.fromJson(response.data);
    //   if (commonResponse.dioMessage != null &&
    //       commonResponse.dioMessage != 'Card not found') {
    //     CommonWidget.successToast(commonResponse.dioMessage!);
    //   }
    // }
    super.onResponse(response, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    EasyLoading.dismiss();
    if (_shouldRetry(err)) {
      CommonWidget.toast(StringConstant.networkError);
      try {
        requestRetrier.scheduleRequestRetry(err.requestOptions);
      } catch (e) {
        print("==ERROR${err.response}");
      }
    } else if (err.response?.statusCode == 401) {

    } else if (err.response?.statusCode != 200) {
      EasyLoading.dismiss();
    }

    super.onError(err, handler);
  }
  // @override
  // Future onError(DioException err) async {
  //   if (_shouldRetry(err)) {
  //     try {
  //       return requestRetrier.scheduleRequestRetry(err.request);
  //     } catch (e) {
  //       return e;
  //     }
  //   }
  //   return err;
  // }

  bool _shouldRetry(DioException err) {
    printInfo(info: '${err.error}');
    return err.error is SocketException;
  }
}
