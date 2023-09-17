import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_multi_window_plugin/flutter_multi_window_plugin.dart';
import 'package:flutter_multi_window_plugin/flutter_multi_window_plugin_platform_interface.dart';
import 'package:flutter_multi_window_plugin/flutter_multi_window_plugin_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockFlutterMultiWindowPluginPlatform
    with MockPlatformInterfaceMixin
    implements FlutterMultiWindowPluginPlatform {
  @override
  Future<int?> createSubWindow() => Future.value(1);
}

void main() {
  final FlutterMultiWindowPluginPlatform initialPlatform =
      FlutterMultiWindowPluginPlatform.instance;

  test('$MethodChannelFlutterMultiWindowPlugin is the default instance', () {
    expect(
        initialPlatform, isInstanceOf<MethodChannelFlutterMultiWindowPlugin>());
  });

  test('createSubWindow', () async {
    FlutterMultiWindowPlugin flutterMultiWindowPlugin =
        FlutterMultiWindowPlugin();
    MockFlutterMultiWindowPluginPlatform fakePlatform =
        MockFlutterMultiWindowPluginPlatform();
    FlutterMultiWindowPluginPlatform.instance = fakePlatform;

    expect(await flutterMultiWindowPlugin.createSubWindow(), 1);
  });
}
