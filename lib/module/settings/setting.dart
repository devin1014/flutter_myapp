import 'package:flutter/material.dart';
import 'package:flutter_router_demo/module/settings/setting_router.dart';
import 'package:flutter_router_demo/router/routers.dart';

class SettingPage extends StatefulWidget {
  static const items = [
    "主题",
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
    "测试",
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
        onTap: () {
          if (index == 0) {
            Routers.navigateTo(context, path: SettingRouter.theme);
          } else if (index == SettingPage.items.length - 1) {
            Routers.navigateTo(context, path: SettingRouter.testHttp);
          }
        },
        child: ListTile(title: Text(SettingPage.items[index])),
      ),
    );
  }
}
