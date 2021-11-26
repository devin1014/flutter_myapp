import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_router_demo/common/http/http.dart';

class VideoPage extends StatefulWidget {
  const VideoPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _VideoPageState();
}

class _VideoPageState extends State<VideoPage> {
  String _result = "";
  bool logData = true;

  @override
  void initState() {
    super.initState();
  }

  void request(String url) async {
    final Response<String> response = await http.dio.get(url);

    String result = """
    *************************************************
    request:
    *************************************************
    
    url:    ${response.requestOptions.uri}
    headers:${response.requestOptions.headers}
    
    *************************************************
    response:
    *************************************************
    
    code:   ${response.statusCode}
    headers:${response.headers}
    """;

    if (logData) {
      result += "\n\ndata: ${response.data}";
    }

    setState(() {
      _result = result;
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 128,
          height: 48,
          child: TextButton(
              onPressed: () {
                request("https://neulion-a.akamaihd.net/nlmobile/nba/config/2020/appconfig_android_r6.nmc");
                // request("https://www.baidu.com/");
              },
              child: const Text("get")),
        ),
        Expanded(flex: 1, child: SingleChildScrollView(child: Text(_result))),
      ],
    );
  }
}
