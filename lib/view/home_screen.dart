import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'history/history_page.dart';
import 'keep/keep_page.dart';
import 'list/list_page.dart';
import 'mypage/mypage.dart';
import 'original/original_page.dart';

/**
 * アプリの大枠（つまりActivityに該当する）
 */
class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Widget> _pages;
  int _currentIndex = 0;

  @override
  void initState() {
    _pages = [
      ListPage(),
      OriginalPage(),
      KeepPage(),
      HistoryPage(),
      MyPage(),
    ];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        currentIndex: _currentIndex,
        onTap: (index){
          setState(() {
            _currentIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(
              icon: FaIcon(FontAwesomeIcons.home),
              label: "テスト",
          ),
          BottomNavigationBarItem(
              icon: FaIcon(FontAwesomeIcons.search),
              label: "テスト",
          ),
          BottomNavigationBarItem(
              icon: FaIcon(FontAwesomeIcons.plusSquare),
              label: "テスト",
          ),
          BottomNavigationBarItem(
              icon: FaIcon(FontAwesomeIcons.heart),
              label: "テスト",
          ),
          BottomNavigationBarItem(
              icon: FaIcon(FontAwesomeIcons.user),
              label: "テスト",
          ),
        ],
      ),
    );
  }
}