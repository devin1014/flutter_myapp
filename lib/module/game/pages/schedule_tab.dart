import 'package:flutter/material.dart';
import 'package:flutter_router_demo/module/game/pages/schedule_list.dart';

class ScheduleTabPage extends StatefulWidget {
  const ScheduleTabPage({
    Key? key,
    required this.dates,
    required this.currentIndex,
  }) : super(key: key);

  final List<DateTime> dates;
  final int currentIndex;

  @override
  State<StatefulWidget> createState() => _ScheduleTabPageState(currentIndex);
}

class _ScheduleTabPageState extends State<ScheduleTabPage> {
  _ScheduleTabPageState(int defaultIndex) : _currentIndex = defaultIndex;

  late PageController _pageController;
  late ScrollController _scrollController;
  final GlobalKey _anchorKey = GlobalKey();
  double _tabWidth = 0;
  double _offsetX = 0;
  int _currentIndex;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: _currentIndex);
    _scrollController = ScrollController(initialScrollOffset: _currentIndex * 96);
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
            itemCount: widget.dates.length,
            itemExtent: 96,
            itemBuilder: (context, index) {
              final date = widget.dates[index];
              return InkWell(
                onTap: () {
                  _scrollPage(index);
                },
                child: Center(
                  child: Text("${date.month}-${date.day}"),
                ),
              );
            },
          ),
        ),
        Expanded(
          child: PageView.builder(
              itemCount: widget.dates.length,
              controller: _pageController,
              onPageChanged: (index) {
                print("onPageChanged: $index");
                _scrollTab(index);
              },
              physics: const PageScrollPhysics(parent: BouncingScrollPhysics()),
              itemBuilder: (context, index) {
                return SchedulePage(dateTime: widget.dates[index]);
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