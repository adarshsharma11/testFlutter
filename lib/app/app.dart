import 'package:flutter/material.dart';
import 'package:uzuri/navigation/bottomNavigation.dart';
import 'package:uzuri/navigation/tabItem.dart';
import 'package:uzuri/pages/about_page.dart';
import 'package:uzuri/pages/catalogue_page.dart';
import 'package:uzuri/pages/home_page.dart';
import 'package:uzuri/pages/notification_page.dart';
import 'package:uzuri/pages/profile_page.dart';

class AppPage extends StatefulWidget {
  @override
  AppState createState() => AppState();
}

GlobalKey navBarGlobalKey = GlobalKey(debugLabel: 'bottomAppBar');

class AppState extends State<AppPage> {
  static int currentTab = 0;
  final List<TabItem> tabs = [
    TabItem(tabName: "Home", icon: Icons.home, page: HomePage()),
    TabItem(tabName: "About Us", icon: Icons.info, page: AboutPage()),
    TabItem(tabName: "Catalogue", icon: Icons.folder, page: CataloguePage()),
    TabItem(
        tabName: "Notifications",
        icon: Icons.notifications,
        page: NotificationPage()),
    TabItem(
        tabName: "My Profile", icon: Icons.account_circle, page: ProfilePage()),
  ];

  AppState() {
    tabs.asMap().forEach((key, value) {
      value.setIndex(key);
    });
  }

  void selectTab(int index) {
    if (index == currentTab) {
      tabs[index].key.currentState.popUntil((route) => route.isFirst);
    } else {
      setState(() {
        currentTab = index;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        final isFirstRouteInCurrentTab =
            !await tabs[currentTab].key.currentState.maybePop();
        if (isFirstRouteInCurrentTab) {
          // if not on the 'main' tab
          if (currentTab != 0) {
            // select 'main' tab
            selectTab(0);
            // back button handled by app
            return false;
          }
        }
        // let system handle back button if we're on the first route
        return isFirstRouteInCurrentTab;
      },
      child: Scaffold(
        body: IndexedStack(
          index: currentTab,
          children: tabs.map((e) => e.page).toList(),
        ),
        bottomNavigationBar: BottomNavigation(
          onSelectTab: selectTab,
          tabs: tabs,
        ),
      ),
    );
  }
}
