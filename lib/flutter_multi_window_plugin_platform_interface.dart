import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'flutter_multi_window_plugin_method_channel.dart';

abstract class FlutterMultiWindowPluginPlatform extends PlatformInterface {
  /// Constructs a FlutterMultiWindowPluginPlatform.
  FlutterMultiWindowPluginPlatform() : super(token: _token);

  static final Object _token = Object();

  static FlutterMultiWindowPluginPlatform _instance =
      MethodChannelFlutterMultiWindowPlugin();

  /// The default instance of [FlutterMultiWindowPluginPlatform] to use.
  ///
  /// Defaults to [MethodChannelFlutterMultiWindowPlugin].
  static FlutterMultiWindowPluginPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [FlutterMultiWindowPluginPlatform] when
  /// they register themselves.
  static set instance(FlutterMultiWindowPluginPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<void> createSubWindow() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }
}
