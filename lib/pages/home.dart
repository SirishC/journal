import 'package:flutter/material.dart';
import 'package:journal/pages/search.dart';
import 'package:journal/pages/myhome.dart';
import 'package:journal/pages/startup.dart';
import 'package:journal/pages/statistics.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  // Holds the Screen Number .
  int currentTab = 2;

  // Screens List .
  final List<Widget> screens = [Search(), MyHome(), StartUp(), Statistics()];

// Nested Tabs
  final PageStorageBucket bucket = PageStorageBucket();
  Widget currentScreen = StartUp(); // Our first view in viewport

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageStorage(
        child: currentScreen,
        bucket: bucket,
      ),

//      floatingActionButton: FloatingActionButton.extended(
//        elevation: 4.0,
//        label: const Text('+',
//          style: TextStyle(fontSize: 25),
//        ),
//        onPressed: () {},
//      ),
//      floatingActionButtonLocation:
//      FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
//        shape: CircularNotchedRectangle(),
        notchMargin: 2,
        child: Container(
          height: 60,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              MaterialButton(
                minWidth: 40,
                onPressed: () {
                  setState(() {
                    currentScreen =
                        Search(); // if user taps on this dashboard tab will be active
                    currentTab = 0;
                  });
                },
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Icon(
                      EvaIcons.searchOutline,
                      color: currentTab == 0 ? Color(0xffFF7582) : Colors.grey,
                    ),
                    Text(
                      'Search',
                      style: TextStyle(
                        color:
                        currentTab == 0 ? Color(0xffFF7582) : Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),
              MaterialButton(
                minWidth: 40,
                onPressed: () {
                  setState(() {
                    currentScreen =
                        MyHome(); // if user taps on this dashboard tab will be active
                    currentTab = 1;
                  });
                },
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Icon(
                      EvaIcons.homeOutline,
                      color: currentTab == 1 ? Color(0xffFF7582) : Colors.grey,
                    ),
                    Text(
                      'Home',
                      style: TextStyle(
                        color:
                        currentTab == 1 ? Color(0xffFF7582) : Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),
              MaterialButton(
                minWidth: 40,
                onPressed: () {
                  setState(() {
                    currentScreen =
                        StartUp(); // if user taps on this dashboard tab will be active
                    currentTab = 2;
                  });
                },
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Icon(
                      EvaIcons.bookOutline,
                      color: currentTab == 2 ? Color(0xffFF7582) : Colors.grey,
                    ),
                    Text(
                      'Feeds',
                      style: TextStyle(
                        color:
                        currentTab == 2 ? Color(0xffFF7582) : Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),
              MaterialButton(
                minWidth: 40,
                onPressed: () {
                  setState(() {
                    currentScreen =
                        Statistics(); // if user taps on this dashboard tab will be active
                    currentTab = 3;
                  });
                },
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Icon(
                      EvaIcons.barChart2,
                      color: currentTab == 3 ? Color(0xffFF7582) : Colors.grey,
                    ),
                    Text(
                      'Statistics',
                      style: TextStyle(
                        color:
                        currentTab == 3 ? Color(0xffFF7582) : Colors.grey,
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
