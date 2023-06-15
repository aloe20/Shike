import 'package:flu/bean/icon_bean.dart';
import 'package:flutter/material.dart';

class FavoritePage extends StatefulWidget {
  const FavoritePage({Key? key}) : super(key: key);

  @override
  State<FavoritePage> createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoritePage> {
  int _selectedIndex = 0;
  late List<IconBean> _items;
  final PageController _pageController = PageController();

  @override
  void initState() {
    super.initState();
    _items = [
      const IconBean(Icons.favorite_border, Icons.favorite, "第一项"),
      const IconBean(Icons.bookmark_border, Icons.bookmark, "第二项"),
      const IconBean(Icons.star_border, Icons.star, "第三项"),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Row(children: [
      NavigationRail(destinations: _items.map((e) =>
          NavigationRailDestination(icon: Icon(e.icon),
              selectedIcon: Icon(e.selectedIcon),
              label: Text(e.label))).toList(),
        selectedIndex: _selectedIndex,
        onDestinationSelected: (index) =>
            setState(() {
              _pageController.animateToPage(
                  index, duration: const Duration(milliseconds: 300),
                  curve: Curves.easeInOut);
            }),),
      const VerticalDivider(width: 1,),
      Expanded(child: PageView(scrollDirection: Axis.vertical,controller: _pageController,onPageChanged: (index)=>setState(() {
        _selectedIndex = index;
      }),children: [
        Container(color: Colors.red,alignment: Alignment.center,child: const Text('First'),),
        Container(color: Colors.green,alignment: Alignment.center,child: const Text('Second'),),
        Container(color: Colors.blue,alignment: Alignment.center,child: const Text('Third'),),
      ],))
    ],);
  }
  @override
  void dispose() {
    super.dispose();
    _pageController.dispose();
  }
}
