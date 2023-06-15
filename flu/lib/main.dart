import 'package:flu/page/app.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:url_strategy/url_strategy.dart';

void main() {
  if (kReleaseMode) debugPrint = (String? message, {int? wrapWidth}) {};
  setPathUrlStrategy();
  runApp(const App());
}
