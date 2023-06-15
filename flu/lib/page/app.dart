import 'package:flu/bridge/bridge_interface.dart';
import 'package:flu/page/main.dart';
import 'package:flu/page/only_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    IBridge.instance.initStatus();
    return MediaQuery.removePadding(
        context: context,
        removeTop: true,
        child: MaterialApp(
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          darkTheme: ThemeData.dark(useMaterial3: true),
          theme: ThemeData.light(useMaterial3: true),
          initialRoute: View.of(context).platformDispatcher.defaultRouteName,
          debugShowCheckedModeBanner: false,
          routes: {
            '/': (_) => const MainPage(),
            'onlyData': (_) => const OnlyData()
          },
        ));
  }
}
