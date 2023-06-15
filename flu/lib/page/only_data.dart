import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class OnlyData extends StatelessWidget {
  const OnlyData({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    BasicMessageChannel<String> channel = const BasicMessageChannel("flu/msg", StringCodec());
    channel.setMessageHandler((message) async {
      debugPrint("flutter=========> $message");
      return "";
    });
    channel.send("Hello android");
    return const SizedBox.shrink();
  }
}
