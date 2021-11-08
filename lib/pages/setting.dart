import 'package:flutter/material.dart';
import 'package:flutter_router_demo/common/db/provider/model_provider.dart';
import 'package:flutter_router_demo/program/model/model.dart';
import 'package:flutter_router_demo/util/logger.dart';

class SettingPage extends StatelessWidget {
  const SettingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Future.sync(() async {
      final provider = SingleProgramProvider();
      List<SingleProgram>? list = await provider.get(0);
      list?.forEach((element) {
        Log.i(element.toJson().toString());
      });
    });
    return const Center(
      child: Text("SettingPage"),
    );
  }
}
