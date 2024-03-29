import 'dart:convert';

import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_router_demo/common/http/http.dart';
import 'package:flutter_router_demo/module/game/model/model.dart';
import 'package:flutter_router_demo/router/routers.dart';
import 'package:flutter_router_demo/util/date.dart';
import 'package:flutter_router_demo/util/image.dart';
import 'package:flutter_router_demo/util/util.dart';

class SchedulePage extends StatefulWidget {
  const SchedulePage({Key? key, required DateTime dateTime})
      : _dateTime = dateTime,
        super(key: key);

  final DateTime _dateTime;

  @override
  State<StatefulWidget> createState() => _SchedulePageState();
}

class _SchedulePageState extends State<SchedulePage> {
  static const dividerSize = 14.0;
  static const edgePadding = 10.0;

  @override
  void initState() {
    super.initState();
    _load(widget._dateTime);
  }

  Games? _result;

  void _load(DateTime dateTime) async {
    Future.wait([
      http.dio.get(Url.getSchedule(dateTime: dateTime)),
      http.dio.get(Url.getBroadcast(dateTime: dateTime)),
    ]).then((value) {
      // schedule
      final values = value[0].data.split("=");
      final result = values.length == 1 ? values[0] : values[1];
      final games = Games.fromJson(jsonDecode(result));
      // broadcast
      final List<dynamic> resultSets = value[1].data["resultSets"];
      final List<dynamic> completeList = (resultSets[1]["CompleteGameList"]);
      final broadcastList = completeList.map((e) => Broadcast.fromJson(e as Map<String, dynamic>)).toList();
      // merge
      MergeUtil.merge(games.games, broadcastList);
      // notify
      setState(() {
        _result = games;
      });
    }).catchError((e) {
      print(e);
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget _buildContent() {
      if (_result == null) {
        return const Center(child: CircularProgressIndicator());
      } else if (_result!.games.isEmpty) {
        return _buildError("NO GAMES");
      } else {
        return _buildList(_result!.games);
      }
    }

    return DecoratedBox(
      decoration: const BoxDecoration(color: Color(0xfff0f0f0)),
      child: _buildContent(),
    );
  }

  Widget _buildError(String message) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Text(
          message,
          style: const TextStyle(fontSize: 16, color: Colors.black),
        ),
      ),
    );
  }

  Widget _buildList(List<Game> list) {
    Widget _buildItem(Game game) {
      if (game.isEvent) {
        return _buildEvent(game);
      }
      switch (game.gameState) {
        case Game.gameStateUpcoming:
          return _buildUpcoming(game);
        default:
          return _buildLiveArchive(game);
      }
    }

    return ListView.separated(
        padding: const EdgeInsets.symmetric(vertical: edgePadding),
        itemBuilder: (context, index) {
          return InkWell(
            onTap: () {
              Routers.navigateTo(context, path: Routers.detail, query: "param1={key1:value1},{key2:value2}&param2=b");
            },
            child: _buildItem(list[index]),
          );
        },
        separatorBuilder: (context, index) => const SizedBox(height: dividerSize),
        itemCount: list.length);
  }

  Widget _buildItemBackground({required Widget child}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Container(
        width: double.infinity,
        height: 196,
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: Colors.white, width: 0.5),
          borderRadius: const BorderRadius.all(Radius.circular(8.0)),
        ),
        child: child,
      ),
    );
  }

  Widget _buildEvent(Game game) {
    return _buildItemBackground(
      child: Column(
        children: [
          // top
          _buildGameBroadcast(game),
          //center
          Expanded(
            child: Container(
                padding: const EdgeInsets.all(12),
                alignment: Alignment.center,
                child: Text(
                  game.description,
                  textAlign: TextAlign.center,
                  style: const TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.bold),
                )),
          ),
        ],
      ),
    );
  }

  Widget _buildUpcoming(Game game) {
    return _buildItemBackground(
      child: Column(
        children: [
          // top
          _buildGameBroadcast(game),
          //center
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(width: 12, height: double.infinity),
                _buildTeamInfo(ImageUtil.getTeamLogo(game.homeTeam), game.homeTeam, game.homeRecord),
                Expanded(
                  child: SizedBox.expand(
                    child: Center(
                      child: Text(
                        parseDate(game.date),
                        style: const TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.bold),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ),
                _buildTeamInfo(ImageUtil.getTeamLogo(game.awayTeam), game.awayTeam, game.awayRecord),
                const SizedBox(width: 12, height: double.infinity),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLiveArchive(Game game) {
    final isLive = game.gameState == Game.gameStateLive;
    return _buildItemBackground(
      child: Column(
        children: [
          // top
          _buildGameBroadcast(game),
          //center
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(width: 12, height: double.infinity),
                _buildTeamInfo(ImageUtil.getTeamLogo(game.homeTeam), game.homeTeam, game.homeRecord),
                Padding(
                  padding: const EdgeInsets.all(12),
                  child: Text(
                    game.homeScore.toString(),
                    style: const TextStyle(color: Colors.black, fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                ),
                Expanded(
                  child: SizedBox.expand(
                    child: Center(
                      child: Text(
                        isLive ? "直播" : "终场",
                        style: TextStyle(
                            color: isLive ? Colors.red : Colors.black, fontSize: 14, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(12),
                  child: Text(
                    game.awayScore.toString(),
                    style: const TextStyle(color: Colors.black, fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                ),
                _buildTeamInfo(ImageUtil.getTeamLogo(game.awayTeam), game.awayTeam, game.awayRecord),
                const SizedBox(width: 12, height: double.infinity),
              ],
            ),
          ),
          SizedBox(
            width: double.infinity,
            height: 48,
            child: Row(
              children: [
                Expanded(child: _buildTabButton("观看", () {})),
                const Divider(height: double.infinity, color: Colors.grey),
                Expanded(child: _buildTabButton("收听", () {})),
                const Divider(height: double.infinity, color: Colors.grey),
                Expanded(child: _buildTabButton("技术统计", () {})),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _buildGameBroadcast(Game game) {
    return SizedBox(
      width: double.infinity,
      height: 40,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Text(
              game.broadcastName,
              style: const TextStyle(fontSize: 14, fontWeight: FontWeight.normal),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildTabButton(String text, VoidCallback? onPressed) {
    return TextButton(
        onPressed: onPressed,
        child: Text(
          text,
          style: const TextStyle(color: Colors.blue, fontSize: 16, fontWeight: FontWeight.bold),
        ));
  }

  Widget _buildTeamInfo(String image, String teamName, String teamRecord) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          width: 64,
          height: 64,
          child: ExtendedImage.network(image, fit: BoxFit.cover),
        ),
        Text(
          teamName,
          style: const TextStyle(color: Colors.black, fontSize: 14, fontWeight: FontWeight.bold),
        ),
        Text(
          teamRecord,
          style: const TextStyle(color: Colors.grey, fontSize: 16, fontWeight: FontWeight.bold),
        )
      ],
    );
  }
}
