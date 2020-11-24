import 'package:flutter/material.dart';
import 'package:uzuri/app/app.dart';
import 'package:uzuri/navigation/tabItem.dart';

class BottomNavigation extends StatefulWidget {
  BottomNavigation({
    this.onSelectTab,
    this.tabs,
  });

  final ValueChanged<int> onSelectTab;
  final List<TabItem> tabs;

  @override
  BottomNavigationState createState() => BottomNavigationState();
}

class BottomNavigationState extends State<BottomNavigation> {
  void onTapItem(int index) {
    setState(() {
      widget.onSelectTab(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration:
          BoxDecoration(boxShadow: [BoxShadow(color: Colors.grey[500])]),
      child: BottomNavigationBar(
          key: navBarGlobalKey,
          backgroundColor: Colors.grey[100],
          elevation: 5,
          type: BottomNavigationBarType.fixed,
          items: widget.tabs
              .map(
                (e) => _buildItem(
                  index: e.getIndex(),
                  icon: e.icon,
                  tabName: e.tabName,
                ),
              )
              .toList(),
          onTap: onTapItem),
    );
  }

  BottomNavigationBarItem _buildItem(
      {int index, IconData icon, String tabName}) {
    return BottomNavigationBarItem(
      backgroundColor: Colors.black,
      icon: Icon(
        icon,
        color: _tabColor(index: index),
      ),
      title: Text(
        tabName,
        style: TextStyle(
          color: _tabColor(index: index),
          fontSize: 12,
        ),
      ),
    );
  }

  Color _tabColor({int index}) {
    return AppState.currentTab == index ? Colors.orange : Colors.grey;
  }
}
