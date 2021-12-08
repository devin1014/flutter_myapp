import 'package:flutter_router_demo/common/http/http.dart';
import 'package:flutter_router_demo/module/game/model/team.dart';
import 'package:flutter_router_demo/routers.dart';

class Global {
  // Global._();
  static Future init() async {
    //TODO: init data
    Routers.initialize();
    http.setup();
    TeamManager.getInstance().init();
  }
}
