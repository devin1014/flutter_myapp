import 'package:flutter_router_demo/routers.dart';

class Global {
  // Global._();
  static Future init() async {
    //TODO: init data
    Routers.initialize();
  }
}
