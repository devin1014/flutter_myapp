import 'package:flutter/material.dart';
import 'package:flutter_router_demo/module/game/model/model.dart';
import 'package:flutter_router_demo/util/parser.dart';

class SchedulePage extends StatefulWidget {
  const SchedulePage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _SchedulePageState();
}

class _SchedulePageState extends State<SchedulePage> {
  @override
  void initState() {
    super.initState();
    _loadData("data/schedule_1129.json");
  }

  Games? _result;

  void _loadData(String path) async {
    final games = Games.fromJson(await Parser.parseAssets(path));
    setState(() {
      _result = games;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_result == null) {
      return const Center(child: CircularProgressIndicator());
    } else if (_result!.games.isEmpty) {
      return _buildError("NO GAMES");
    } else {
      return _buildList(_result!.games);
    }
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
    return ListView.separated(
        padding: const EdgeInsets.symmetric(vertical: 12),
        itemBuilder: (context, index) {
          switch (list[index].gameState) {
            case Game.gameStateUpcoming:
              return _buildUpcoming(list[index]);
            case Game.gameStateLive:
              return _buildLive(list[index]);
            default:
              return _buildArchive(list[index]);
          }
        },
        separatorBuilder: (context, index) {
          return const SizedBox(height: 12);
        },
        itemCount: list.length);
  }

  Widget _buildItemBackground({required Widget child}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Container(
        width: double.infinity,
        height: 196,
        decoration: BoxDecoration(
          color: const Color(0xFFe0e0e0),
          border: Border.all(color: Colors.white, width: 0.5),
          borderRadius: const BorderRadius.all(Radius.circular(8.0)),
        ),
        child: child,
      ),
    );
  }

  Widget _buildUpcoming(Game game) {
    return _buildItemBackground(
      child: Center(
        child: Text("Upcoming\n"
            "${game.awayTeam} vs ${game.homeTeam}\n"
            "${game.date}\n"),
      ),
    );
  }

  Widget _buildLive(Game game) {
    return _buildItemBackground(
      child: Center(
        child: Text("Live\n"
            "${game.awayTeam} vs ${game.homeTeam}\n"
            "${game.awayScore} - ${game.homeScore}\n"),
      ),
    );
  }

  Widget _buildArchive(Game game) {
    return _buildItemBackground(
      child: Center(
        child: Text("Archive\n"
            "${game.awayTeam} vs ${game.homeTeam}\n"
            "${game.awayScore} - ${game.homeScore}\n"),
      ),
    );
  }
}
