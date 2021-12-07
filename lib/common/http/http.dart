import 'package:cookie_jar/cookie_jar.dart';
import 'package:dio/dio.dart';
import 'package:dio_cache_interceptor/dio_cache_interceptor.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';

import 'http_log.dart';

final Http http = Http();

class Http {
  final Dio _dio = Dio();

  Dio get dio => _dio;

  void setup({bool? logResponseData}) {
    _dio.interceptors.add(CookieManager(CookieJar()));
    _dio.interceptors.add(DioCacheInterceptor(options: _cacheOption));
    // should add in last.
    _dio.interceptors.add(HttpLogInterceptor(logResponseData: logResponseData));
  }

  CacheOptions get _cacheOption => CacheOptions(
        store: MemCacheStore(),
        policy: CachePolicy.request,
        hitCacheOnErrorExcept: [401, 403],
        keyBuilder: CacheOptions.defaultCacheKeyBuilder,
        allowPostMethod: false,
      );
}

class Url {
  Url._();

  static String getSchedule({String season = "2021", required DateTime dateTime}) {
    return "https://nlnbamdnyc-a.akamaihd.net/fs/nba/feeds_s2019"
        "/schedule_atv/$season/${dateTime.month}_${dateTime.day}.js";
  }
}
