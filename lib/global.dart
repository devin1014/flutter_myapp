import 'package:flutter_router_demo/common/http/http.dart';
import 'package:flutter_router_demo/module/game/model/team.dart';
import 'package:flutter_router_demo/router/routers.dart';
import 'package:flutter_router_demo/util/logger.dart';

class Global {
  Global._();

  static Future init() async {
    final timeStamp = DateTime.now().millisecondsSinceEpoch;
    Log.i("initialize start.");
    Routers.initialize();
    http.setup();
    TeamManager.getInstance().init();
    final duration = DateTime.now().millisecondsSinceEpoch - timeStamp;
    Log.i("initialize end. [$duration]ms");
  }
}
