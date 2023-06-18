import 'package:flu/bridge/bridge_impl.dart';
import 'package:flutter/foundation.dart';

abstract class IBridge {
  static IBridge _instance = BridgeImpl();

  static set instance(IBridge instance) {
    _instance = instance;
  }

  static IBridge get instance => _instance;

  Future<void> navigate(dynamic arguments);

  void initStatus();
  void getStatusHeight(ValueChanged<double> callback);
  Future<String> convertHtml(String html);
}
