import 'package:flutter/material.dart';
import 'package:flutter_router_demo/pigeon.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  List<Book?>? list;

  @override
  void initState() {
    super.initState();
    Future.sync(() async {
      final list = await _getBook();
      setState(() {
        this.list = list;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(list == null ? "SettingPage" : "${list.toString()} -> ${list!.length}"),
    );
  }

  Future<List<Book?>> _getBook() async {
    //TODO
    await Future.delayed(const Duration(seconds: 2), () {});
    return await BookApi().search("arg_key");
  }
}
