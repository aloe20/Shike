import 'package:flu/api/http_interface.dart';
import 'package:flu/bean/http_result.dart';
import 'package:flu/bridge/bridge_interface.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  List<BannerBean> _banners = [];
  List<ArticleBean> _tops = [];
  List<ArticleBean> _list = [];
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();
  double _statusHeight = 0;

  @override
  void initState() {
    super.initState();
    /*_items = [
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
    ];*/
    IHttp.instance
        .getBanner()
        .then((value) => setState(() => _banners = value));
    IHttp.instance.getTop().then((value) => setState(() {
          _tops = value;
          if (_tops.isNotEmpty) {
            Future.forEach(value, (element) {
              return IBridge.instance
                  .convertHtml(element.desc)
                  .then((value) => setState(() => element.desc = value));
            });
          }
        }));
    IHttp.instance.getHomeList(0).then((value) => setState(() =>_list = value));
    IBridge.instance.getStatusHeight((value) =>setState(() =>_statusHeight = value));
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
          child: Text(
            AppLocalizations.of(context)!.home,
            style: const TextStyle(fontSize: 16),
          ),
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
                icon: const Icon(Icons.web_outlined),
                selectedIcon: const Icon(Icons.web),
                label: Text("Widget$index"));
          }
        }),
      ),
      body: ListView(
        children: [
          [
            SizedBox(
              height: 160,
              child: PageView(
                  children: _banners
                      .map((e) => GestureDetector(
                            child: Image.network(
                              e.imagePath,
                              fit: BoxFit.fitWidth,
                            ),
                            onTap: () => IBridge.instance
                                .navigate({"pageName": "web", "url": e.url}),
                          ))
                      .toList()),
            ),
          ],
          /*_items
              .map((e) => Card(
                    child: ListTile(
                      title: Text(e.title),
                      onTap: e.callback,
                    ),
                  ))
              .toList(),*/
          _tops
              .map((e) => GestureDetector(
                    onTap: () => IBridge.instance
                        .navigate({"pageName": "web", "url": e.link}),
                    child: Card(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 8, horizontal: 16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(e.title),
                            Text(
                              e.desc,
                              maxLines: 5,
                            )
                          ],
                        ),
                      ),
                    ),
                  ))
              .toList(),
          _list
              .map((e) => GestureDetector(
                    onTap: () => IBridge.instance
                        .navigate({"pageName": "web", "url": e.link}),
                    child: Card(
                      child: Padding(
                        padding:
                            const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              e.title,
                            ),
                            Visibility(
                              visible: e.desc.isNotEmpty,
                              child: Text(
                                e.desc,
                                maxLines: 5,
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ))
              .toList()
        ].expand((element) => element).toList(),
      ),
    );
  }
}

/*class Item {
  const Item(this.title, this.callback);

  final String title;
  final GestureTapCallback callback;
}*/
