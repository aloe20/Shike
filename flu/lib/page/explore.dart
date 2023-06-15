import 'dart:convert';

import 'package:flu/bean/http_result.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ExplorePage extends StatefulWidget {
  const ExplorePage({Key? key}) : super(key: key);

  @override
  State<ExplorePage> createState() => _ExplorePageState();
}

class _ExplorePageState extends State<ExplorePage>
    with TickerProviderStateMixin {
  late final TabController _tabController;
  final List<IconData> _list = [
    Icons.cloud_outlined,
    Icons.beach_access_outlined,
    Icons.brightness_5_outlined
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: _list.length, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TabBar(
            controller: _tabController,
            tabs: _list
                .map((e) => Tab(
                      icon: Icon(e),
                    ))
                .toList()),
      ),
      body: DefaultAssetBundle(
        bundle: SimpleAssetBundle(),
        child: TabBarView(controller: _tabController, children: [
          Image.network(
            "https://ts1.cn.mm.bing.net/th/id/R-C.18c926a5b5b33e6c7ec7938fe79714a6?rik=XROULmNY%2fkPEcQ&riu=http%3a%2f%2fwww.ukutu.cn%2fupload%2f201603%2f23%2f201603230207284857.jpg&ehk=Daa7YSXlRf09mbTzfKuvuRlPY%2fsqG0qDVAZqb%2bvkVB0%3d&risl=&pid=ImgRaw&r=0",
          loadingBuilder: (context,child,progress){
              int loaded = progress?.cumulativeBytesLoaded??0;
              int total = progress?.expectedTotalBytes??0;
              if(loaded==0) {
                return child;
              } else {
                return Center(child: CircularProgressIndicator(value: total==0?null:loaded/total,),);
              }
          },errorBuilder: (_,__,stackTrace)=>Text(stackTrace.toString()),),
          Column(
            children: [
              Image.asset('assets/images/a.jpg'),
              FutureBuilder(
                future: DefaultAssetBundle.of(context)
                    .loadString("assets/config/banner.json"),
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return Center(
                      child: Text(snapshot.error?.toString() ?? ""),
                    );
                  } else if (snapshot.hasData) {
                    HttpResult<List<BannerBean>> result = HttpResult.fromJson(jsonDecode(snapshot.requireData), (json)=>(json as List<dynamic>).map((e) => BannerBean.fromJson(e)).toList());
                    return Center(
                      child:
                          Text(result.data[0].title),
                    );
                  } else {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                },
              )
            ],
          ),
          const Center(
            child: Badge(
              largeSize: 8,
              label: Text(''),
              child: Icon(Icons.beach_access_outlined),
            ),
          ),
        ]),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
  }
}

class SimpleAssetBundle extends CachingAssetBundle {
  @override
  Future<ByteData> load(String key) {
    debugPrint('key: $key');
    return rootBundle.load(key);
  }
}
