import 'package:flu/bean/icon_bean.dart';
import 'package:flu/page/bookmark.dart';
import 'package:flu/page/explore.dart';
import 'package:flu/page/favorite.dart';
import 'package:flu/page/home/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final PageController _pageController = PageController();
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    var localizations = AppLocalizations.of(context)!;
    return Scaffold(
        body: PageView(
          controller: _pageController,
          onPageChanged: (index) => setState(() {
            _selectedIndex = index;
          }),
          children: const [
            HomePage(),
            ExplorePage(),
            FavoritePage(),
            BookmarkPage()
          ],
        ),
        bottomNavigationBar: SizedBox(
          height: 56,
          child: NavigationBar(
            onDestinationSelected: (index) => _pageController.animateToPage(
                index,
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeInOut),
            selectedIndex: _selectedIndex,
            destinations: [
              IconBean(Icons.home_outlined, Icons.home, localizations.home),
              IconBean(Icons.explore_outlined, Icons.explore, localizations.explore),
              IconBean(Icons.favorite_outline, Icons.favorite, localizations.favorite),
              IconBean(Icons.bookmark_outline, Icons.bookmark, localizations.bookmark)
            ]
                .map((e) => NavigationDestination(
                icon: Icon(e.icon),
                selectedIcon: Icon(e.selectedIcon),
                label: e.label))
                .toList(),
          ),
        ));
  }

  @override
  void dispose() {
    super.dispose();
    _pageController.dispose();
  }
}
