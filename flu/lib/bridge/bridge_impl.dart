import 'package:flu/bridge/bridge_interface.dart';
import 'package:flutter/services.dart';

class BridgeImpl extends IBridge {
  final MethodChannel _channel = const MethodChannel("appBridge");
  ValueChanged<double>? _callback;
  double _statusBarHeight = 0;
  @override
  Future<void> navigate(dynamic arguments) async {
    await _channel.invokeMethod('navigation', arguments);
  }

  @override
  Future<String> convertHtml(String html) async {
    return await _channel.invokeMethod("convertHtml", {"data":html});
  }

  @override
  void initStatus() {
    _channel.setMethodCallHandler((call) async {
      switch (call.method) {
        case "getResult":
          _statusBarHeight = (call.arguments as Map)['statusBarHeight'] ?? 0;
          if(_callback!=null){
            _callback!(_statusBarHeight);
          }
          break;
        default:
          break;
      }
    });
  }

  @override
  void getStatusHeight(ValueChanged<double> callback) {
    if(_statusBarHeight!=0){
      callback(_statusBarHeight);
    } else {
      _callback = callback;
    }
  }
}
