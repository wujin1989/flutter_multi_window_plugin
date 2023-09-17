#ifndef FLUTTER_PLUGIN_FLUTTER_MULTI_WINDOW_PLUGIN_H_
#define FLUTTER_PLUGIN_FLUTTER_MULTI_WINDOW_PLUGIN_H_

#include <flutter/method_channel.h>
#include <flutter/plugin_registrar_windows.h>

#include <memory>

namespace flutter_multi_window_plugin {

class FlutterMultiWindowPlugin : public flutter::Plugin {
 public:
  static void RegisterWithRegistrar(flutter::PluginRegistrarWindows *registrar);

  FlutterMultiWindowPlugin();

  virtual ~FlutterMultiWindowPlugin();

  // Disallow copy and assign.
  FlutterMultiWindowPlugin(const FlutterMultiWindowPlugin&) = delete;
  FlutterMultiWindowPlugin& operator=(const FlutterMultiWindowPlugin&) = delete;

  // Called when a method is called on this plugin's channel from Dart.
  void HandleMethodCall(
      const flutter::MethodCall<flutter::EncodableValue> &method_call,
      std::unique_ptr<flutter::MethodResult<flutter::EncodableValue>> result);
};

}  // namespace flutter_multi_window_plugin

#endif  // FLUTTER_PLUGIN_FLUTTER_MULTI_WINDOW_PLUGIN_H_
