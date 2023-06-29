import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ComputeLayout extends StatefulWidget {
  const ComputeLayout({super.key});

  @override
  State<ComputeLayout> createState() => _ComputeLayoutState();
}

class _ComputeLayoutState extends State<ComputeLayout> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(title: Text(AppLocalizations.of(context)!.compute(100)),centerTitle: true,),body: Container(),);
  }
}
