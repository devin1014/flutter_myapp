import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:flutter_router_demo/main.dart';
import 'package:flutter_router_demo/module/detail/detail.dart';
import 'package:flutter_router_demo/module/game/pages/game_page.dart';
import 'package:flutter_router_demo/module/settings/setting.dart';
import 'package:flutter_router_demo/module/program/video.dart';
import 'package:flutter_router_demo/widget/video_player.dart';
import 'package:flutter_router_demo/widget/webview.dart';

import 'module/home/home.dart';

class Routers {
  static String main = "/";
  static String home = "/main/home";
  static String game = "/main/game";
  static String video = "/main/video";
  static String setting = "/main/setting";
  static String detail = "/detail";
  static String webView = "/webView";
  static String videoPlayer = "/videoPlayer";

  static final _router = FluroRouter();

  static FluroRouter get router => _router;

  static bool _init = false;

  static void initialize() {
    if (_init) return;
    _router.notFoundHandler = _notFoundHandler;
    _router.define(main, handler: _mainHandler);
    _router.define(home, handler: _homeHandler);
    _router.define(game, handler: _gameHandler);
    _router.define(video, handler: _videoHandler);
    _router.define(setting, handler: _settingHandler);
    _router.define(detail, handler: _detailHandler);
    _router.define(webView, handler: _webViewHandler);
    _router.define(videoPlayer, handler: _videoPlayerHandler);
    _init = true;
  }

  static Future navigateTo(BuildContext context, String path,
      {bool replace = false,
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

Handler get _notFoundHandler => Handler(handlerFunc: (_, Map<String, List<String>> parameters) {
      return const Center(child: Text("Not Found!"));
    });

Handler get _mainHandler => Handler(handlerFunc: (_, Map<String, List<String>> parameters) {
      return const MainPage();
    });

Handler get _homeHandler => Handler(handlerFunc: (_, Map<String, List<String>> parameters) {
      return const HomePage();
    });

Handler get _gameHandler => Handler(handlerFunc: (_, Map<String, List<String>> parameters) {
      return const GamePage();
    });

Handler get _videoHandler => Handler(handlerFunc: (_, Map<String, List<String>> parameters) {
      return const VideoPage();
    });

Handler get _settingHandler => Handler(handlerFunc: (_, Map<String, List<String>> parameters) {
      return const SettingPage();
    });

Handler get _detailHandler => Handler(handlerFunc: (_, Map<String, List<String>> parameters) {
      return const DetailPage();
    });

Handler get _webViewHandler => Handler(handlerFunc: (_, Map<String, List<String>> parameters) {
      final url = (_?.settings?.arguments as String?) ?? "https://flutter.dev";
      return WebViewPage(url);
    });

Handler get _videoPlayerHandler => Handler(handlerFunc: (_, Map<String, List<String>> parameters) {
      return const VideoPlayerPage();
    });
