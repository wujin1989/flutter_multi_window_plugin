import 'package:flutter/material.dart';
import 'package:flutter_multi_window_plugin/flutter_multi_window_plugin.dart';

void main(List<String> args) {
  if (args.firstOrNull == "SubWindow") {
    runApp(_SubWindow());
  } else {
    runApp(_MainWindow());
  }
}

class _SubWindow extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text("SubWindow"),
        ),
        body: const Text("hello i am sub window, hahaha"),
      ),
    );
  }
}

class _MainWindow extends StatelessWidget {
  final plugin = FlutterMultiWindowPlugin();
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text("MainWindow"),
        ),
        floatingActionButton: ElevatedButton(
            onPressed: () async {
              await plugin.createSubWindow();
            },
            child: const Text("CreateSubWindow")),
        body: Center(
          child:
              ElevatedButton(onPressed: () {}, child: const Text("playvideo")),
        ),
      ),
    );
  }
}
