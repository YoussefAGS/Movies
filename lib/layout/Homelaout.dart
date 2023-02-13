
import 'package:flutter/material.dart';
import 'package:movise/moudlse/Browser/Browser.dart';
import 'package:movise/moudlse/Search%20screen/sreach%20screen.dart';
import 'package:movise/moudlse/watch/watchlist.dart';

import '../moudlse/home screen/home_screen.dart';

class HomeLayout extends StatefulWidget {
  static const String routeName='HomeLayout';

  @override
  State<HomeLayout> createState() => _HomeLayoutState();
}

class _HomeLayoutState extends State<HomeLayout> {
  int crreuntTap=0;
  List<Widget>tabs=[
    HomeScreen(),
    SearchTab(),
    BrowserScreen(),
    WatchListScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 0,
        backgroundColor: Colors.transparent,
        elevation: 0,

      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex:  crreuntTap,
        onTap:(index) {
          crreuntTap=index;
          setState(() {

          });
        },
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(icon: ImageIcon(
            AssetImage(
                'assets/images/Home icon.png'
            ),size: 30,
          ),
            label: 'HOME',

          ),
          BottomNavigationBarItem(icon: ImageIcon(
            AssetImage(
                'assets/images/search-2.png'
            ),size: 30,
          ),
            label: 'SEARCH',

          ),
          BottomNavigationBarItem(icon: ImageIcon(
            AssetImage(
                'assets/images/Icon material-movie.png'
            ),size: 30,
          ),
            label: 'BROWSR',

          ),
          BottomNavigationBarItem(icon: ImageIcon(
            AssetImage(
                'assets/images/Icon ionic-md-bookmarks.png'
            ),size: 30,
          ),
            label:'WATCHLIST',

          ),
        ],
      ),
      body: tabs[crreuntTap],

    );
  }
}
