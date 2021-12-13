import 'package:flutter/material.dart';
import 'package:flutter_router_demo/widget/table_widget.dart';

class StandingsPage extends StatefulWidget {
  const StandingsPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _StandingsPageState();
}

class _StandingsPageState extends State<StandingsPage> {
  final ScrollController leftController = ScrollController();
  final ScrollController rightController = ScrollController();

  @override
  void initState() {
    super.initState();
    // leftController.addListener(_onLeftScrollChangedListener);
    // rightController.addListener(_onRightScrollChangedListener);
  }

  // void _onLeftScrollChangedListener() {
  //   print("left: ${leftController.offset}");
  //   rightController.jumpTo(leftController.offset);
  // }
  //
  // void _onRightScrollChangedListener() {
  //   print("right: ${rightController.offset}");
  //   // leftController.jumpTo(rightController.offset);
  // }

  @override
  void dispose() {
    leftController.dispose();
    rightController.dispose();
    super.dispose();
  }

  bool _leftScrolling = false;
  bool _rightScrolling = false;

  bool _onLeftScrollNotification(ScrollNotification notification) {
    if (notification is ScrollStartNotification) {
      // print("left: ScrollStartNotification");
      if (!_rightScrolling) {
        _leftScrolling = true;
      }
    } else if (notification is ScrollEndNotification) {
      // print("left: ScrollEndNotification");
      if (_leftScrolling) {
        _leftScrolling = false;
      }
    } else if (notification is ScrollUpdateNotification) {
      // print("left: ScrollUpdateNotification: ${notification.metrics.pixels}");
      if (_leftScrolling) {
        rightController.jumpTo(notification.metrics.pixels);
      }
    }
    return true;
  }

  bool _onRightScrollNotification(ScrollNotification notification) {
    if (notification is ScrollStartNotification) {
      if (!_leftScrolling) {
        _rightScrolling = true;
      }
      // print("right: ScrollStartNotification");
    } else if (notification is ScrollEndNotification) {
      if (_rightScrolling) {
        _rightScrolling = false;
      }
      // print("right: ScrollEndNotification");
    } else if (notification is ScrollUpdateNotification) {
      // print("right: ScrollUpdateNotification: ${notification.metrics.pixels}");
      if (_rightScrolling) {
        leftController.jumpTo(notification.metrics.pixels);
      }
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    //TODO: test code
    return TableWidget.builder(
      rowSize: 15,
      rowHeight: 64,
      columnSize: 15,
      columnWidth: 64,
      builder: (context, row, column) => Center(
        child: Text("${row + 1}x${column + 1}"),
      ),
    );
    // return Row(
    //   children: [
    //     SizedBox(
    //       width: 140,
    //       child: NotificationListener(
    //         onNotification: _onLeftScrollNotification,
    //         // child: CustomScrollView(
    //         //   scrollDirection: Axis.vertical,
    //         //   controller: leftController,
    //         //   slivers: _buildPrimaryColumn([Colors.white, const Color(0xFFf6f6f6)]),
    //         // ),
    //         child: ListView.builder(
    //             controller: leftController,
    //             itemExtent: 36,
    //             itemCount: columnTotalSize,
    //             itemBuilder: (context, index) {
    //               return Builder(builder: (context) {
    //                 final colors = [Colors.white, const Color(0xFFf6f6f6)];
    //                 return Container(
    //                   height: 36,
    //                   color: colors[index % 2],
    //                   child: Center(child: Text(index.toString())),
    //                 );
    //               });
    //             }),
    //       ),
    //     ),
    //     Expanded(
    //       child: NotificationListener(
    //         onNotification: _onRightScrollNotification,
    //         child: CustomScrollView(
    //           scrollDirection: Axis.vertical,
    //           controller: rightController,
    //           slivers: _buildSecondColumn([const Color(0xFFf6f6f6), Colors.white]),
    //         ),
    //       ),
    //     ),
    //   ],
    // );
  }

  static const columnTotalSize = 50;

  List<Widget> _buildPrimaryColumn(List<Color> colors) {
    final list = <Widget>[];
    for (var i = 0; i < columnTotalSize; i++) {
      final child = SliverToBoxAdapter(
        child: Container(
          height: 36,
          color: colors[i % 2],
          child: Center(child: Text(i.toString())),
        ),
      );
      list.add(child);
    }
    return list;
  }

  List<Widget> _buildSecondColumn(List<Color> colors) {
    final list = <Widget>[];
    List<ScrollController> controllerList = [];
    for (var i = 0; i < columnTotalSize; i++) {
      final controller = ScrollController();
      controllerList.add(controller);
      final child = SliverToBoxAdapter(
        child: Container(
          height: 36,
          color: colors[i % 2],
          // child: Center(child: Text(i.toString())),
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            controller: controller,
            itemExtent: 64,
            itemCount: 15,
            itemBuilder: (context, index) => Center(child: Text(i.toString())),
          ),
        ),
      );
      // final child = SliverFixedExtentList(
      //   itemExtent: 64,
      //   delegate: SliverChildBuilderDelegate(
      //     (context, index) => Center(child: Text(index.toString())),
      //     childCount: 15,
      //   ),
      // );
      list.add(NotificationListener(
        onNotification: (notification) {
          // if (notification is ScrollUpdateNotification) {
          //   for (var c in controllerList) {
          //     c.jumpTo(notification.metrics.pixels);
          //   }
          // }
          return true;
        },
        child: child,
      ));
    }
    return list;
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
