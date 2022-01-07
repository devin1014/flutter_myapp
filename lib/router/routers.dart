import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:flutter_router_demo/main.dart';
import 'package:flutter_router_demo/module/detail/detail_router.dart';
import 'package:flutter_router_demo/module/game/pages/game_page.dart';
import 'package:flutter_router_demo/module/program/video.dart';
import 'package:flutter_router_demo/module/settings/setting.dart';
import 'package:flutter_router_demo/module/settings/setting_router.dart';
import 'package:flutter_router_demo/module/standings/pages/standings_page.dart';
import 'package:flutter_router_demo/module/webview/webview_router.dart';
import 'package:flutter_router_demo/router/router_provider.dart';

import '../module/home/home.dart';

class Routers {
  static const String main = "/";
  static String home = "/main/home";
  static String game = "/main/game";
  static String video = "/main/video";
  static String setting = "/main/setting";
  static String standings = "/main/standings";

  static String detail = "/detail";
  static String webView = "/webView";

  static final _router = FluroRouter();

  static FluroRouter get router => _router;
  static final List<IRouterProvider> _routerProviders = [];

  static void initialize() {
    _router.notFoundHandler = Handler(handlerFunc: (_, __) {
      return const Center(child: Text("Not Found!"));
    });
    _router.define(main, handler: Handler(handlerFunc: (_, param) => const MainPage()));
    _router.define(home, handler: Handler(handlerFunc: (_, param) => const HomePage()));
    _router.define(game, handler: Handler(handlerFunc: (_, param) => const GamePage()));
    _router.define(video, handler: Handler(handlerFunc: (_, param) => const VideoPage()));
    _router.define(standings, handler: Handler(handlerFunc: (_, param) => const StandingsPage()));
    _router.define(setting, handler: Handler(handlerFunc: (_, param) => const SettingPage()));

    _routerProviders.add(DetailRouter());
    _routerProviders.add(WebViewRouter());
    _routerProviders.add(SettingRouter());

    void initRouter(IRouterProvider provider) {
      provider.initRouter(router);
    }

    _routerProviders.forEach(initRouter);
  }

  static Future navigateTo(BuildContext context,
      {required String path,
      String? query,
      bool replace = false,
      bool clearStack = false,
      bool maintainState = true,
      bool rootNavigator = false,
      TransitionType? transition,
      Duration? transitionDuration,
      RouteTransitionsBuilder? transitionBuilder,
      RouteSettings? routeSettings}) {
    return router.navigateTo(
      context,
      path,
      replace: replace,
      clearStack: clearStack,
      maintainState: maintainState,
      rootNavigator: rootNavigator,
      transition: transition,
      transitionDuration: transitionDuration,
      routeSettings: routeSettings,
    );
  }
}
