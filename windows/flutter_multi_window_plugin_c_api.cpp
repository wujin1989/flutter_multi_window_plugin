#include "include/flutter_multi_window_plugin/flutter_multi_window_plugin_c_api.h"

#include <flutter/plugin_registrar_windows.h>

#include "flutter_multi_window_plugin.h"

void FlutterMultiWindowPluginCApiRegisterWithRegistrar(
    FlutterDesktopPluginRegistrarRef registrar) {
  flutter_multi_window_plugin::FlutterMultiWindowPlugin::RegisterWithRegistrar(
      flutter::PluginRegistrarManager::GetInstance()
          ->GetRegistrar<flutter::PluginRegistrarWindows>(registrar));
}
