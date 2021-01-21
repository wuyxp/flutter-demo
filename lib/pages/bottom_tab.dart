import 'package:flutter/material.dart';

import 'tabs/bottom_navigation.dart';
import 'tabs/aa.dart';
import 'tabs/bb.dart';
import 'tabs/cc.dart';
import 'tabs/dd.dart';


class BottomTab extends StatefulWidget {
  @override
  _BottomTabState createState() => _BottomTabState();
}

class _BottomTabState extends State<BottomTab> {
  final widgets = [
    BottomNavigation(AA()),
    BottomNavigation(BB()),
    BottomNavigation(CC()),
    BottomNavigation(DD()),
  ];
  int activeIndex = 0;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: widgets[activeIndex],
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          selectedFontSize: 16,
          unselectedFontSize: 16,
          onTap: (index){
            print(index);
            setState(() {
              activeIndex = index;
            });
          },
          currentIndex: activeIndex,
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: "AA",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.icecream),
              label: "BB",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.message),
              label: "CC",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.settings),
              label: "DD",
            ),
          ],
        ),
      ),
    );
  }
}
