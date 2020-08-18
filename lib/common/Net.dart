import 'package:beeui/bee.dart';
import 'package:beeui/main.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_template/common/Constant.dart';
import 'package:flutter_app_template/common/Global.dart';

import 'Events.dart';

final Http http = Http();

class Http extends BaseHttp {
  @override
  void init() {
    options.baseUrl = Constant.API_URL;
    options.connectTimeout = 10000;
    options.receiveTimeout = 10000;

    options.extra = {"showLoading": false};

    debugPrint("options.baseUrl${options.baseUrl}");
    interceptors..add(ApiInterceptor());
  }
}

class Http2 extends BaseHttp {
  @override
  void init() {
    debugPrint("options.baseUrl====${options.baseUrl}");
//    options.baseUrl = Domains.API_URL + "/kkingweb/";
//    interceptors..add(ApiInterceptor());
  }
}

class ApiInterceptor extends InterceptorsWrapper {
  Function _close;

  @override
  onRequest(RequestOptions options) async {
    if (options.method == "GET") {
//      options.queryParameters["t"] = DateTime.now().millisecondsSinceEpoch;

      debugPrint('---api-request--->url-->${options.baseUrl}${options.path}' +
          ' queryParameters: ${options.queryParameters}');
    } else if (options.method == "POST") {
      debugPrint('---api-request--->url-->${options.baseUrl}${options.path}' +
          ' data: ${options.data}');
    }
    options.headers['ticket'] = Global.ticket;

    if (options.extra["showLoading"] && _close == null) {
//      _close = BeeToast.loading(icon: Loading(size: 90));
    }

    return options;
  }

  @override
  onResponse(Response response) {
    if (_close != null) {
      _close();
      _close = null;
    }

    debugPrint(
        '---api-response--->${response.request.path} - resp----->${response.data}');

    print(response.extra);

    ResponseData respData = ResponseData.fromJson(response.data);
    if (respData.success) {
//      response.data = respData.data != null ? respData.data : respData;
      return http.resolve(respData);
    } else {
      if (respData.code == 50) {
        BeeUI.eventBus.emit(SystemEvent.LOGIN_DISABLED);
        throw const UnAuthorizedException(); // 需要登录
        return http.resolve(respData);
      } else {
//        throw NotSuccessException.fromRespData(respData);

        return http.resolve(respData);
//        throw {"code": 100};
      }
    }
  }

  onError(DioError e) async {
    var statusCode = 8800;
    var message = "";

    if (_close != null) {
      _close();
      _close = null;
    }

    print(e);

    // 当请求失败时做一些预处理
    if (e.type == DioErrorType.DEFAULT) {
      statusCode = 8801;
      message = 'network_failed';
    } else if (e.type == DioErrorType.CANCEL) {
      statusCode = 8802;
      message = 'network_cancel';
    } else if (e.type == DioErrorType.CONNECT_TIMEOUT) {
      statusCode = 8803;
      message = 'network_connect_timeout';
    } else if (e.type == DioErrorType.RECEIVE_TIMEOUT) {
      statusCode = 8804;
      message = 'network_receive_timeout';
    } else if (e.type == DioErrorType.RESPONSE) {
      statusCode = 8805;
      message = 'network_response';
    } else if (e.type == DioErrorType.SEND_TIMEOUT) {
      statusCode = 8806;
      message = 'network_send_timeout';
    }

    ResponseData response = new ResponseData.fromJson(
        {"code": statusCode, "data": null, "message": message});
    return http.resolve(response);
  }
}

class ResponseData extends BaseResponseData {
  bool get success => 0 == code;

  ResponseData.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    message = json['message'];
    data = json['data'];
  }
}
