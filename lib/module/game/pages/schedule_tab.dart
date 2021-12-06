import 'package:flutter/material.dart';
import 'package:flutter_router_demo/module/game/pages/schedule_list.dart';
import 'package:flutter_router_demo/util/date.dart';

class ScheduleTabPage extends StatefulWidget {
  const ScheduleTabPage({
    Key? key,
    required this.dates,
    required this.currentIndex,
  }) : super(key: key);

  final List<DateTime> dates;
  final int currentIndex;

  @override
  State<StatefulWidget> createState() => _ScheduleTabPageState();
}

class _ScheduleTabPageState extends State<ScheduleTabPage> {
  _ScheduleTabPageState();

  static const _tabItemWidth = 54.0;
  late PageController _pageController;
  late ScrollController _scrollController;
  final GlobalKey _anchorKey = GlobalKey();
  double _tabWidth = 0;
  double _offsetX = 0;
  int _currentIndex = 0;
  var _date = "";
  var _currentYearMonth = "";

  @override
  void initState() {
    super.initState();
    final now = DateTime.now();
    _date = "${now.month} ${now.year}";
    _currentIndex = widget.currentIndex;
    _pageController = PageController(initialPage: _currentIndex);
    _scrollController = ScrollController(initialScrollOffset: _currentIndex * _tabItemWidth);
    _scrollController.addListener(() {
      final index = _scrollController.offset ~/ _tabItemWidth;
      final _date = widget.dates.first.add(Duration(days: index));
      // print("index: $index");
      final _ym = "${_date.year}${_date.month}";
      if (_currentYearMonth != _ym) {
        _currentYearMonth = _ym;
        print("date: $_currentYearMonth");
      }
    });
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
          height: 36,
          child: Center(
            child: Text(
              _date,
              style: const TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
        ),
        SizedBox(
          width: double.infinity,
          height: 54,
          child: ListView.builder(
            key: _anchorKey,
            scrollDirection: Axis.horizontal,
            controller: _scrollController,
            itemCount: widget.dates.length,
            itemExtent: _tabItemWidth,
            itemBuilder: (context, index) {
              return InkWell(
                onTap: () {
                  _scrollPage(index);
                },
                child: _buildTimeTab(widget.dates[index]),
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

  Widget _buildTimeTab(DateTime dateTime) => Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            getWeekDay(dateTime.weekday),
            style: const TextStyle(color: Colors.black, fontSize: 14, fontWeight: FontWeight.bold),
          ),
          Padding(
            padding: const EdgeInsets.all(6),
            child: Text(
              dateTime.day.toString(),
              style: const TextStyle(color: Colors.black, fontSize: 14, fontWeight: FontWeight.bold),
            ),
          )
        ],
      );

  void _scrollTab(int index) {
    _calculateOffset();
    _scrollController.animateTo(
      index.toDouble() * _tabItemWidth - _offsetX,
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
      _offsetX = (renderBox.size.width + offset.dx - _tabItemWidth) / 2.0;
      _tabWidth = renderBox.size.width;
    }
  }
}
