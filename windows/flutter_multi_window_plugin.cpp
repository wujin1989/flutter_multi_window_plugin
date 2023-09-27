#include "flutter_multi_window_plugin.h"

// This must be included before many other Windows headers.
#include <windows.h>

// For getPlatformVersion; remove unless needed for your plugin implementation.
#include <VersionHelpers.h>

#include <flutter/method_channel.h>
#include <flutter/plugin_registrar_windows.h>
#include <flutter/standard_method_codec.h>

#include <memory>
#include <thread>
#include <sstream>

#include <flutter/dart_project.h>
#include <flutter/flutter_view_controller.h>
#include "flutter_windows.h"


namespace flutter_multi_window_plugin {

LRESULT CALLBACK WindowProc(HWND hwnd, UINT uMsg, WPARAM wParam, LPARAM lParam) {
    switch (uMsg) {
    case WM_DESTROY:
      DestroyWindow(hwnd);
      PostQuitMessage(0);
      break;
    default:
        return DefWindowProc(hwnd, uMsg, wParam, lParam);
    }
    return 0;
}

void createSubWindow(void) {
    flutter::DartProject project(L"data");
    std::vector<std::string> args;
    args.push_back("SubWindow");

    project.set_dart_entrypoint_arguments(std::move(args));

    WNDCLASSEX wc = { sizeof(WNDCLASSEX), CS_CLASSDC, WindowProc, 0L, 0L, GetModuleHandle(NULL), NULL, NULL, NULL, NULL, L"SubWindowClass", NULL };
    RegisterClassEx(&wc);
    HWND hwnd = CreateWindow(L"SubWindowClass", L"Sub Window", WS_OVERLAPPEDWINDOW, 100, 100, 1280, 720, NULL, NULL, wc.hInstance, NULL);
    
    RECT frame;
    std::unique_ptr<flutter::FlutterViewController> flutter_controller2_;

    GetClientRect(hwnd, &frame);
    flutter_controller2_ = std::make_unique<flutter::FlutterViewController>(
        frame.right - frame.left, frame.bottom - frame.top, project);
    if (!flutter_controller2_->engine() || !flutter_controller2_->view()) {
        return;
    }
    // flutter_multi_window_plugin::FlutterMultiWindowPlugin::RegisterWithRegistrar(
    //   flutter::PluginRegistrarManager::GetInstance()
    //       ->GetRegistrar<flutter::PluginRegistrarWindows>(flutter_controller2_->engine()->GetRegistrarForPlugin("FlutterMultiWindowPluginCApi")));

    SetParent(flutter_controller2_->view()->GetNativeWindow(), hwnd);
    GetClientRect(hwnd, &frame);

    MoveWindow(flutter_controller2_->view()->GetNativeWindow(), frame.left, frame.top, frame.right - frame.left,
        frame.bottom - frame.top, true);

    SetFocus(flutter_controller2_->view()->GetNativeWindow());
    flutter_controller2_->engine()->SetNextFrameCallback([=]() {
        ShowWindow(hwnd, SW_SHOWNORMAL);
    });

    flutter_controller2_->ForceRedraw();

  ::MSG msg;
  while (::GetMessage(&msg, nullptr, 0, 0)) {
    ::TranslateMessage(&msg);
    ::DispatchMessage(&msg);
  }
  return;
}

// static
void FlutterMultiWindowPlugin::RegisterWithRegistrar(
    flutter::PluginRegistrarWindows *registrar) {
  auto channel =
      std::make_unique<flutter::MethodChannel<flutter::EncodableValue>>(
          registrar->messenger(), "flutter_multi_window_plugin",
          &flutter::StandardMethodCodec::GetInstance());

  auto plugin = std::make_unique<FlutterMultiWindowPlugin>();

  channel->SetMethodCallHandler(
      [plugin_pointer = plugin.get()](const auto &call, auto result) {
        plugin_pointer->HandleMethodCall(call, std::move(result));
      });

  registrar->AddPlugin(std::move(plugin));
}

FlutterMultiWindowPlugin::FlutterMultiWindowPlugin() {}

FlutterMultiWindowPlugin::~FlutterMultiWindowPlugin() {}

void FlutterMultiWindowPlugin::HandleMethodCall(
    const flutter::MethodCall<flutter::EncodableValue> &method_call,
    std::unique_ptr<flutter::MethodResult<flutter::EncodableValue>> result) {
  if (method_call.method_name().compare("createSubWindow") == 0) {
    std::thread subWindowThread([]() {
        createSubWindow();
    });
    subWindowThread.detach();
    
    result->Success();
  } else {
    result->NotImplemented();
  }
}

}  // namespace flutter_multi_window_plugin
