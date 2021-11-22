import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_router_demo/global.dart';
import 'package:flutter_router_demo/home/home.dart';
import 'package:flutter_router_demo/language/delegate.dart';
import 'package:flutter_router_demo/pages/game.dart';
import 'package:flutter_router_demo/pages/setting.dart';
import 'package:flutter_router_demo/pages/video.dart';
import 'package:flutter_router_demo/routers.dart';
import 'package:flutter_router_demo/util/logger.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:permission_handler/permission_handler.dart';

void main() => Global.init().then((value) => runApp(const MyApp()));

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(primarySwatch: Colors.blue),
      onGenerateRoute: Routers.router.generator,
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        MyLocalizationsDelegate.delegate,
        //LogLocalizationsDelegate.delegate,
      ],
      supportedLocales: const [
        Locale('en', 'US'),
        Locale('zh', 'CN'),
        Locale.fromSubtags(
          languageCode: 'zh',
          scriptCode: 'HK',
          countryCode: 'CN',
        ),
      ],
      localeListResolutionCallback: (List<Locale>? locales, Iterable<Locale> supportedLocales) {
        Log.d("localeListResolutionCallback: ${locales?.toString()}");
        Log.d("Iterable: ${supportedLocales.toString()}");
        return locales?.first;
      },
    );
  }
}

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final List<Widget> pages = [
    const HomePage(),
    const GamePage(),
    const VideoPage(),
    const SettingPage(),
  ];

  @override
  void initState() {
    super.initState();

    Future.sync(() async {
      var status = await Permission.storage.status;
      if (!status.isGranted) {
        status = await Permission.storage.request();
        if (!status.isGranted) {
          Fluttertoast.showToast(msg: "not allow permission: 'storage'");
          if (status.isPermanentlyDenied) {
            openAppSettings();
          }
        }
      }
    });
  }

  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Flutter Demo")),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.gamepad), label: "Game"),
          BottomNavigationBarItem(icon: Icon(Icons.video_call), label: "Video"),
          BottomNavigationBarItem(icon: Icon(Icons.settings), label: "Setting"),
        ],
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.black,
        selectedIconTheme: const IconThemeData(color: Colors.blue),
        unselectedIconTheme: const IconThemeData(color: Colors.grey),
        selectedFontSize: 12,
        unselectedFontSize: 12,
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        type: BottomNavigationBarType.fixed,
      ),
      body: pages[_selectedIndex],
    );
  }
}
