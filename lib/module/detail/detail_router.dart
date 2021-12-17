import 'package:fluro/fluro.dart';
import 'package:flutter_router_demo/router/router_provider.dart';
import 'package:flutter_router_demo/util/logger.dart';

import 'detail.dart';

class DetailRouter implements IRouterProvider {
  static String detail = "/detail";

  @override
  void initRouter(FluroRouter router) {
    Log.i("register path: '$detail'");
    router.define(detail, handler: Handler(handlerFunc: (_, Map<String, List<String>> params) {
      Log.i("route to '$detail', params: $params");
      return const DetailPage();
    }));
  }
}
