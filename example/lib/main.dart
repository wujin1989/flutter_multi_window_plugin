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
          body: NativeWindow(MediaQuery.of(context).size.width,
              MediaQuery.of(context).size.height)),
    );
  }
}

class NativeWindow extends StatefulWidget {
  final double height;
  final double width;

  NativeWindow(this.width, this.height) {
    print("width: $width, height: $height");
  }
  @override
  _NativeWindowState createState() {
    return _NativeWindowState();
  }
}

class _NativeWindowState extends State<NativeWindow> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {});
  }

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: NativeWindowCustomPainter(),
      size: Size(widget.width, widget.height),
    );
  }
}

class NativeWindowCustomPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    canvas.drawRect(
      Rect.fromLTWH(0, 0, size.width, size.height),
      Paint()
        ..blendMode = BlendMode.clear
        ..color = const Color(0x00000000),
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}

class _MainWindow extends StatelessWidget {
  final FlutterMultiWindowPlugin plugin = FlutterMultiWindowPlugin();
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
