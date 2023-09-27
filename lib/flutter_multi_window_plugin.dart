import 'flutter_multi_window_plugin_platform_interface.dart';

class FlutterMultiWindowPlugin {
  Future<void> createSubWindow() {
    return FlutterMultiWindowPluginPlatform.instance.createSubWindow();
  }
}
