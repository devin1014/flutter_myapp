import 'package:flutter/material.dart';

class SettingPage extends StatefulWidget {
  static const items = [
    "收看直播赛事",
    "球员",
    "球队",
    "NBA 75",
    "统计数据",
    "交易",
    "重要日期",
    "播放时间表",
    "常见问题",
    "隐私设定",
    "隐私条款",
  ];

  const SettingPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemExtent: 56,
      itemCount: SettingPage.items.length,
      itemBuilder: (context, index) => InkWell(
        onTap: () {},
        child: ListTile(title: Text(SettingPage.items[index])),
      ),
    );
  }
}
