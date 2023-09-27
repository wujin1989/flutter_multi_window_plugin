import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'flutter_multi_window_plugin_platform_interface.dart';

/// An implementation of [FlutterMultiWindowPluginPlatform] that uses method channels.
class MethodChannelFlutterMultiWindowPlugin
    extends FlutterMultiWindowPluginPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('flutter_multi_window_plugin');

  @override
  Future<void> createSubWindow() async {
    await methodChannel.invokeMethod<int>('createSubWindow');
  }
}
