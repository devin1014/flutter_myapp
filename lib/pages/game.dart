import 'package:flutter/material.dart';
import 'package:flutter_router_demo/widget/horizontal_list_view.dart';

class GamePage extends StatelessWidget {
  const GamePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey,
      width: 160,
      height: 160,
      child: HorizontalListViewBuilder.build(
        itemCount: 20,
        itemDividerWidth: 12.0,
        itemVisibleCount: 2.5,
        itemBuilder: (context, index) => Container(
          color: Colors.greenAccent,
          child: Center(child: Text("$index", style: const TextStyle(fontSize: 22, color: Colors.black))),
        ),
      ),
    );
  }
}
