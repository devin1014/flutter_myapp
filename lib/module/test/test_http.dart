import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_router_demo/common/http/http.dart';

class TestHttpPage extends StatefulWidget {
  const TestHttpPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _TestHttpPageState();
}

class _TestHttpPageState extends State<TestHttpPage> {
  final String _url = "https://neulion-a.akamaihd.net/nlmobile/nba/config/2020/appconfig_android_r6.nmc";
  bool logData = true;

  @override
  void initState() {
    super.initState();
  }

  Future<String> request(String url) async {
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
      result += "\n\ndata: ${response.data.hashCode.toRadixString(16).toUpperCase()}";
    }

    return result;
  }

  @override
  void dispose() {
    super.dispose();
  }

  bool requestHttp = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("TestHttp")),
      body: Padding(
        padding: const EdgeInsets.all(6),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: 128,
              height: 48,
              child: OutlinedButton(
                onPressed: () => setState(() {
                  requestHttp = true;
                }),
                child: const Text("Get Http"),
              ),
            ),
            buildContent(requestHttp)
          ],
        ),
      ),
    );
  }

  Widget buildContent(bool requestHttp) {
    if (!requestHttp) {
      return const Text("");
    }
    return Expanded(
      child: FutureBuilder(
        future: request(_url),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.none) {
            return const Text("NONE");
          } else if (snapshot.connectionState == ConnectionState.active ||
              snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Text(snapshot.error?.toString() ?? "Error");
          } else {
            return SingleChildScrollView(
              child: Text(snapshot.data?.toString() ?? "success"),
            );
          }
        },
      ),
    );
  }
}
