import 'package:fluro/fluro.dart';
import 'package:fluro/src/fluro_router.dart';
import 'package:flutter_router_demo/module/settings/theme_page.dart';
import 'package:flutter_router_demo/module/test/test_http.dart';
import 'package:flutter_router_demo/router/router_provider.dart';
import 'package:flutter_router_demo/util/logger.dart';

class SettingRouter extends IRouterProvider {
  static String theme = "/setting/theme";
  static String testHttp = "/setting/test_http";

  @override
  void initRouter(FluroRouter router) {
    Log.i("register path: '$theme'");
    Log.i("register path: '$testHttp'");
    router.define(theme, handler: Handler(handlerFunc: (_, Map<String, List<String>> params) {
      Log.i("route to '$theme', params: $params");
      return const ThemePage();
    }));
    router.define(testHttp, handler: Handler(handlerFunc: (_, Map<String, List<String>> params) {
      Log.i("route to '$testHttp', params: $params");
      return const TestHttpPage();
    }));
  }
}
