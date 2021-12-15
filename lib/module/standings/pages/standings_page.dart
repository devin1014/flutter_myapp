import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_router_demo/common/http/http.dart';
import 'package:flutter_router_demo/module/standings/model/team_record.dart';
import 'package:flutter_router_demo/widget/table_widget.dart';
import 'package:xml2json/xml2json.dart';

class StandingsPage extends StatefulWidget {
  const StandingsPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _StandingsPageState();
}

class _StandingsPageState extends State<StandingsPage> {
  Standings? standings;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  void _loadData() async {
    final response = await http.dio.get("https://nlnbamdnyc-a.akamaihd.net/fs/nba/feeds.qa"
        ".nbad/common/nba_season_standings.xml");
    final xml2Json = Xml2Json();
    xml2Json.parse(response.data);
    final json = xml2Json.toBadgerfish();
    final _result = Standings.fromJson(jsonDecode(json));
    setState(() {
      standings = _result;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (standings == null) {
      return const Center(child: CircularProgressIndicator());
    }
    return TableWidget.labelBuilder(
      rowSize: rowTitle.length,
      columnSize: standings!.teamRecords.length,
      rowLabelWidth: 50,
      rowLabelHeight: 36,
      columnLabelWidth: 140,
      columnLabelHeight: 36,
      itemBuilder: (context, row, column) => Center(
        child: Text(standings!.teamRecords[row].getValue(column)),
      ),
      labelBuilder: (context, row, column) => Container(
        alignment: Alignment.center,
        color: const Color(0xfff0f0f0),
        child: Builder(builder: (context) {
          if (row == -1) {
            return FittedBox(
              child: Text(rowTitle[column], softWrap: true, maxLines: 2, textAlign: TextAlign.center),
            );
          } else {
            return FittedBox(
              child: Text(standings!.teamRecords[row].teamAbr),
            );
          }
        }),
      ),
    );
  }

  static const rowTitle = ["胜", "负", "胜率", "胜差", "分区", "分组", "主场", "客场", "过去10场\n战绩", "连续记录"];
}

extension TeamRecordValue on TeamRecord {
  String getValue(int column) {
    switch (column) {
      case 0:
        return wins;
      case 1:
        return losses;
      case 2:
        return winPct;
      case 3:
        return winStreak;
      case 4:
        return divisionWins;
      case 5:
        return conferenceWins;
      case 6:
        return homeWins;
      case 7:
        return awayWins;
      case 8:
        return last10;
      case 9:
        return streak;
      default:
        return "";
    }
  }
}
