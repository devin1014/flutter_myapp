import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_router_demo/widget/table_widget.dart';

class StandingsPage extends StatefulWidget {
  const StandingsPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _StandingsPageState();
}

class _StandingsPageState extends State<StandingsPage> {
  @override
  Widget build(BuildContext context) {
    // return TableWidget.builder(
    //   rowSize: 15,
    //   columnSize: 15,
    //   itemHeight: 48,
    //   itemWidth: 64,
    //   itemBuilder: (context, row, column) => Center(
    //     child: Text("${row + 1}x${column + 1}"),
    //   ),
    //   labelBuilder: (context, row, column) => Container(
    //     alignment: Alignment.center,
    //     color: const Color(0xfff0f0f0),
    //     child: Builder(builder: (context) {
    //       String label = row == -1 ? "col" : "row";
    //       int index = max(row, column);
    //       return Text("$label ${index + 1}");
    //     }),
    //   ),
    // );
    return TableWidget.labelBuilder(
      rowSize: 15,
      columnSize: 15,
      rowLabelWidth: 64,
      rowLabelHeight: 48,
      columnLabelWidth: 96,
      columnLabelHeight: 48,
      itemBuilder: (context, row, column) => Center(
        child: Text("${row + 1}x${column + 1}"),
      ),
      labelBuilder: (context, row, column) => Container(
        alignment: Alignment.center,
        color: const Color(0xfff0f0f0),
        child: Builder(builder: (context) {
          String label = row == -1 ? "col" : "row";
          int index = max(row, column);
          return Text("$label ${index + 1}");
        }),
      ),
    );
  }

// void _loadData() async {
//   final response = await http.dio.get("https://nlnbamdnyc-a.akamaihd.net/fs/nba/feeds.qa"
//       ".nbad/common/nba_season_standings.xml");
//   final xml2Json = Xml2Json();
//   xml2Json.parse(response.data);
//   final json = xml2Json.toBadgerfish();
//   // print("$json");
// }
}
