import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:flutter_router_demo/main.dart';
import 'package:flutter_router_demo/pages/detail.dart';
import 'package:flutter_router_demo/pages/game.dart';
import 'package:flutter_router_demo/pages/home.dart';
import 'package:flutter_router_demo/pages/setting.dart';
import 'package:flutter_router_demo/pages/video.dart';

class Routers {
  static String main = "/";
  static String home = "/main/home";
  static String game = "/main/game";
  static String video = "/main/video";
  static String setting = "/main/setting";
  static String detail = "/detail";

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
    _init = true;
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
