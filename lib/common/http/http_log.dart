import 'package:dio/dio.dart';
import 'package:flutter_router_demo/util/logger.dart';

class HttpLogInterceptor extends Interceptor {
  HttpLogInterceptor({this.logResponseData});

  final bool? logResponseData;

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    Log.d("""
    request:
      method  = ${options.method}
      url     = ${options.uri.toString()}
      params  = ${options.queryParameters}
      headers = ${options.headers} 
    """);
    super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    Log.d("""
    response:
      code    = ${response.statusCode}
      headers = ${response.headers}
      extra   = ${response.extra}
      data    = ${_parseData(response)}
    """);
    super.onResponse(response, handler);
  }

  String _parseData(Response response) {
    if (logResponseData == null || logResponseData!) {
      return "disable";
    } else {
      return "${response.data}";
    }
  }

  @override
  void onError(DioError err, ErrorInterceptorHandler handler) {
    Log.w("""
    error:
      url     = ${err.requestOptions.uri}
      type    = ${err.type}
      message = ${err.message}
      stack   = ${err.stackTrace}
    """);
    super.onError(err, handler);
  }
}
