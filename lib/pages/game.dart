import 'package:flutter/material.dart';
import 'package:flutter_router_demo/module/game/game.dart';
import 'package:flutter_router_demo/module/game/pages/schedule_tab.dart';

class GamePage extends StatelessWidget {
  const GamePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScheduleTabPage(
      dates: buildDates(),
      currentIndex: 30,
    );
  }
}
