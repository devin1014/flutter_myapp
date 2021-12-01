import 'package:flutter/material.dart';
import 'package:flutter_router_demo/module/game/pages/schedule_list.dart';

class ScheduleTabPage extends StatefulWidget {
  const ScheduleTabPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _ScheduleTabPageState();
}

class _ScheduleTabPageState extends State<ScheduleTabPage> {
  final PageController _pageController = PageController(initialPage: 5);
  final ScrollController _scrollController = ScrollController(initialScrollOffset: 5 * 96);
  final GlobalKey _anchorKey = GlobalKey();
  double _tabWidth = 0;
  double _offsetX = 0;

  @override
  void initState() {
    super.initState();
    _pageController.addListener(() {
      // print("page: ${_pageController.page}");
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: double.infinity,
          height: 54,
          child: ListView.builder(
            key: _anchorKey,
            scrollDirection: Axis.horizontal,
            controller: _scrollController,
            itemCount: 10,
            itemExtent: 96,
            itemBuilder: (context, index) {
              return InkWell(
                onTap: () {
                  // _scrollTab(index);
                  _scrollPage(index);
                },
                child: Center(
                  child: Text("index:[$index]"),
                ),
              );
            },
          ),
        ),
        Expanded(
          child: PageView.builder(
              itemCount: 10,
              controller: _pageController,
              onPageChanged: (index) {
                print("onPageChanged: $index");
                _scrollTab(index);
              },
              physics: const PageScrollPhysics(parent: BouncingScrollPhysics()),
              itemBuilder: (context, index) {
                return const SchedulePage();
              }),
        )
      ],
    );
  }

  void _scrollTab(int index) {
    _calculateOffset();
    _scrollController.animateTo(
      index.toDouble() * 96 - _offsetX,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  void _scrollPage(int index) {
    _calculateOffset();
    _pageController.animateTo(
      index.toDouble() * _tabWidth,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  void _calculateOffset() {
    if (_offsetX == 0) {
      final renderBox = _anchorKey.currentContext?.findRenderObject() as RenderBox;
      final offset = renderBox.localToGlobal(Offset.zero);
      _offsetX = (renderBox.size.width + offset.dx - 96) / 2.0;
      _tabWidth = renderBox.size.width;
    }
  }
}
