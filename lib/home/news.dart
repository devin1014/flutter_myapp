import 'package:flutter/material.dart';

import 'model/root.dart';

class HomeNewsPage extends StatelessWidget {
  const HomeNewsPage(this._homeItem, {Key? key}) : super(key: key);

  final HomeItem? _homeItem;

  @override
  Widget build(BuildContext context) {
    if (_homeItem == null) {
      return const SizedBox(
        width: double.infinity,
        height: 164,
        child: Center(child: CircularProgressIndicator()),
      );
    }
    return ListView.builder(
        itemCount: _homeItem!.value!.list.length,
        itemExtent: 40,
        itemBuilder: (context, index) {
          return SizedBox(
            height: 40,
            child: Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: Text(_homeItem!.value!.list[index].title),
                )),
          );
        });
  }
}
