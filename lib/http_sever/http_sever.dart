import 'package:dio/dio.dart';
import 'dart:io';

class HttpSeverFactory {
  static HttpSever http;

  static HttpSever getHttp() {
    if (http != null) {
      return http;
    } else {
      http = HttpSever._internal();
      return http;
    }
  }
}

/// 后端返回接口数据model
class ResponseModel<T> {
  bool status;
  int code;
  String msg;
  T data;

  ResponseModel(this.status, this.code, this.data, this.msg);
}

/// 请求方法.
class Method {
  static final String get = "GET";
  static final String post = "POST";
}

class HttpSever {
  final dio = new Dio();

  /// 是否是debug模式.
  static bool _isDebug = true;

  /// 打开debug模式.
  static void openDebug() {
    _isDebug = true;
  }

  /// 定义一个HttpSever 私有类 _internal
  HttpSever._internal() {
    dio.options.baseUrl = "http://10.0.2.2:9999/api";
    dio.options.contentType = ContentType.parse("application/x-www-form-urlencoded");
    dio.options.connectTimeout = 10000;
    dio.options.receiveTimeout = 10000;

    dio.interceptor.request.onSend = (Options options) {
      /// 在请求被发送之前做一些事情
      return options; //continue
      /// 如果你想完成请求并返回一些自定义数据，可以返回一个`Response`对象或返回`dio.resolve(data)`。
      /// 这样请求将会被终止，上层then会被调用，then中返回的数据将是你的自定义数据data.
      ///
      /// 如果你想终止请求并触发一个错误,你可以返回一个`DioError`对象，或返回`dio.reject(errMsg)`，
      /// 这样请求将被中止并触发异常，上层catchError会被调用。
    };

    dio.interceptor.response.onSuccess = (Response response) {
      // 在返回响应数据之前做一些预处理
      return response;
    };

    dio.interceptor.response.onError = (DioError e) {
      /// 当请求失败时做一些预处理
      return DioError;
    };
  }

  /// 定义公共请求方法
  /// [method] 请求方式
  /// [path] 请求路径
  /// [data] 请求数据
  /// [options] options配置
  /// <ResponseModel<T> 返回 status code msg data
  Future<ResponseModel<T>> request<T>(String method, String path, {data, Options options, CancelToken cancelToken}) async {
    Response response = await dio.request(
        path,
        data: data,
        options: _checkOptions(method, options),
        cancelToken: cancelToken
    );
    _printHttpLog(response);
    bool _status;
    int _code;
    String _msg;
    T _data;
    if (response.statusCode == HttpStatus.ok || response.statusCode == HttpStatus.created) {
      _status = response.data['status'];
      _code = response.data['code'];
      _msg = response.data['msg'];
      _data = response.data['data'];
      return new ResponseModel(_status, _code, _data, _msg);
    } else {
      return new Future.error(new DioError(
        response: response,
        message: "statusCode: $response.statusCode, service error",
        type: DioErrorType.RESPONSE,
      ));
    }

  }

  /// 合并 Options.
  Options _checkOptions(method, options) {
    if (options == null) {
      options = new Options();
    }
    options.method = method;
    return options;
  }

  /// 定义http Log
  void _printHttpLog(Response response) {
    if (!_isDebug) {
      return;
    }
    try {
      print("----------------Http Log----------------" +
          "\n[statusCode]:" +
          response.statusCode.toString() +
          "\n[request]:" +
          _getOptionsStr(response.request));
      _printDataStr("response", response.data);
    } catch (ex) {
      print("Http Log" + " error......" + ex);
    }
  }

  /// get Options Str.
  String _getOptionsStr(Options request) {
    return "method:" +
        request.method +
        "  baseUrl:" +
        request.baseUrl +
        "  path:" +
        request.path;
  }

  /// print Data Str.
  void _printDataStr(String tag, Object value) {
    String da = value.toString();
    while (da.isNotEmpty) {
      if (da.length > 512) {
        print("[$tag]:" + da.substring(0, 512));
        da = da.substring(512, da.length);
      } else {
        print("[$tag]:" + da);
        da = "";
      }
    }
  }
}
