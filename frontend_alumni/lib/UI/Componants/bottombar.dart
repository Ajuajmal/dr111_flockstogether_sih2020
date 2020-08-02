import 'package:alumni/UI/screens/account.dart';
import 'package:alumni/UI/screens/home.dart';
import 'package:flutter/material.dart';

import 'Search/search.dart';

class BottomBarHome extends StatefulWidget {
  @override
  _BottomBarHomeState createState() => _BottomBarHomeState();
}

class _BottomBarHomeState extends State<BottomBarHome> {
  int _bottomNavbarIndex = 0;
  Widget callPage(int index) {
    switch (index) {
      case 0:
        return Home();
      case 1:
        return SearchPage();
      case 2:
        return AccountPage();
        break;
      default:
        return Home();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: callPage(_bottomNavbarIndex),
      bottomNavigationBar: new BottomNavigationBar(
        currentIndex: _bottomNavbarIndex,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        backgroundColor: Colors.blue,
        onTap: (int index) {
          setState(() {
            _bottomNavbarIndex = index;
          });
        },
        type: BottomNavigationBarType.fixed,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            title: Text(''),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            title: Text(''),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            title: Text(''),
          ),
        ],
        selectedItemColor: Colors.white,
      ),
    );
  }
}
