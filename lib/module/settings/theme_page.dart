import 'package:flutter/material.dart';
import 'package:flutter_router_demo/util/logger.dart';

class ThemePage extends StatefulWidget {
  const ThemePage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _ThemePageState();
}

class _ThemePageState extends State<ThemePage> {
  static const List<MaterialColor> colors = [Colors.teal, Colors.blue, Colors.grey, Colors.deepOrange];
  MaterialColor _themeColor = Colors.teal;
  ValueNotifier<Color> notifier = ValueNotifier(Colors.transparent);
  int _index = 0;

  @override
  Widget build(BuildContext context) {
    ThemeData themeData = Theme.of(context);
    return Theme(
      data: ThemeData(
        primarySwatch: _themeColor,
        iconTheme: IconThemeData(color: _themeColor),
      ),
      child: Scaffold(
        appBar: AppBar(title: const Text("主题测试")),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            DefaultTextStyle.merge(
              style: TextStyle(inherit: true, color: _themeColor),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Icon(Icons.favorite),
                  Icon(Icons.airport_shuttle),
                  Text("颜色跟随主题"),
                ],
              ),
            ),
            Theme(
                data: themeData.copyWith(
                  iconTheme: themeData.iconTheme.copyWith(color: Colors.black),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Icon(Icons.favorite),
                    Icon(Icons.airport_shuttle),
                    Text("颜色固定黑色"),
                  ],
                )),
            Builder(builder: (context) {
              Log.i("Builder1 ...");
              Widget label = Builder(builder: (context) {
                Log.i("Builder2 ...");
                return const Text("固定不变");
              });
              return ValueListenableBuilder<Color>(
                valueListenable: notifier,
                builder: (context, value, child) {
                  return Container(
                    width: 96,
                    height: 64,
                    alignment: Alignment.center,
                    color: value,
                    child: child,
                  );
                },
                child: label,
              );
            }),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            // setState(() {
            _index++;
            _themeColor = colors[_index % colors.length];
            notifier.value = _themeColor;
            // });
          },
          child: const Icon(Icons.palette),
        ),
      ),
    );
  }
}
