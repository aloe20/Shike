import 'package:flu/api/http_interface.dart';
import 'package:flu/bean/http_result.dart';
import 'package:flu/bridge/bridge_interface.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  List<BannerBean> _banners = [];
  late final List<Item> _items;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();
  double _statusHeight = 0;

  @override
  void initState() {
    super.initState();
    _items = [
      Item("打开左边面板", () => _scaffoldKey.currentState?.openDrawer()),
      Item(
          "显示底部弹窗",
          () => showBottomSheet(
              context: context,
              builder: (context) => const SizedBox(
                    height: 200,
                    child: Center(
                      child: Text("底部弹窗"),
                    ),
                  ))),
      Item(
          "显示底部弹窗带阴影",
          () => showModalBottomSheet(
              context: context,
              builder: (context) => const SizedBox(
                    height: 400,
                    child: Center(
                      child: Text("底部弹窗"),
                    ),
                  ))),
      Item("显示弹窗", () {
        var localizations = AppLocalizations.of(context)!;
        showDialog(
            context: context,
            builder: (context) => AlertDialog(
                  title: const Text("AlertDialog"),
                  content: const Text("aaaaaaa"),
                  actions: [
                    localizations.ignore,
                    localizations.cancel,
                    localizations.ok
                  ]
                      .map((e) => TextButton(
                          onPressed: () => Navigator.of(context).pop(),
                          child: Text(e)))
                      .toList(),
                ));
      })
    ];
    IHttp.instance.getBanner().then((value) {
      setState(() {
        _banners = value;
      });
    });
    IBridge.instance.getStatusHeight((value) {
      setState(() {
        _statusHeight = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        leading: Builder(
            builder: (context) => Padding(
                  padding: EdgeInsets.only(top: _statusHeight),
                  child: IconButton(
                      onPressed: () => Scaffold.of(context).openDrawer(),
                      icon: const Icon(Icons.menu)),
                )),
        title: Padding(
          padding: EdgeInsets.only(top: _statusHeight),
          child: Text(AppLocalizations.of(context)!.home),
        ),
        centerTitle: true,
        toolbarHeight: 44 + _statusHeight,
      ),
      drawer: NavigationDrawer(
        selectedIndex: _selectedIndex,
        onDestinationSelected: (index) => setState(() {
          _selectedIndex = index;
          Navigator.pop(context);
        }),
        children: List.generate(4, (index) {
          if (index == 0) {
            return Container(
              height: 183,
              padding: EdgeInsets.zero,
              child: LayoutBuilder(builder: (context, constraints) {
                return Image.network(
                    "https://picsum.photos/id/16/${constraints.maxWidth.toInt()}/${constraints.maxHeight.toInt()}");
              }),
            );
          } else {
            return NavigationDrawerDestination(
                icon: const Icon(Icons.widgets_outlined),
                selectedIcon: const Icon(Icons.widgets),
                label: Text("Widget$index"));
          }
        }),
      ),
      body: ListView(
        children: [
          [
            SizedBox(
              height: 120,
              child: PageView(
                  children: _banners
                      .map((e) => GestureDetector(
                            child: Image.network(
                              e.imagePath,
                              fit: BoxFit.fitWidth,
                            ),
                            onTap: () => IBridge.instance
                                .navigate({"pageName":"web","url": e.url}),
                          ))
                      .toList()),
            ),
          ],
          _items
              .map((e) => Card(
                    child: ListTile(
                      title: Text(e.title),
                      onTap: e.callback,
                    ),
                  ))
              .toList()
        ].expand((element) => element).toList(),
      ),
    );
  }
}

class Item {
  const Item(this.title, this.callback);

  final String title;
  final GestureTapCallback callback;
}
