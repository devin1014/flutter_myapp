import 'package:flutter/material.dart';
import 'package:flutter_router_demo/language/delegate.dart';
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
      //TODO: memory leaks
      final list = await _getBook();
      setState(() {
        this.list = list;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(6),
            child: Text(Localizations.localeOf(context).toString()),
          ),
          Padding(
            padding: const EdgeInsets.all(6),
            child: Text(MyLocalizations.of(context).name),
          ),
          const SizedBox(height: 40),
          Text(list == null ? "SettingPage" : "${list![0]} -> ${list!.length}"),
        ],
      ),
    );
  }

  Future<List<Book?>> _getBook() async {
    //TODO
    await Future.delayed(const Duration(seconds: 2), () {});
    return await BookApi().search("arg_key");
  }
}
