import 'package:fluro/fluro.dart';
import 'package:flutter_router_demo/module/webview/webview.dart';
import 'package:flutter_router_demo/router/router_provider.dart';
import 'package:flutter_router_demo/util/logger.dart';

class WebViewRouter implements IRouterProvider {
  static const routerWebView = "/webView";

  @override
  void initRouter(FluroRouter router) {
    Log.i("register path: '$routerWebView'");
    router.define(routerWebView, handler: Handler(handlerFunc: (_, Map<String, List<String>> params) {
      Log.i("route to '$routerWebView', params: $params");
      final url = params["url"]?.first ?? "https://flutter.dev";
      return WebViewPage(url);
    }));
  }
}
