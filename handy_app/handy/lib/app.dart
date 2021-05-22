import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:handy/views/event_page.dart';
import 'package:handy/views/home_page.dart';
import 'package:handy/views/profile_page.dart';
import 'package:handy/views/search_page.dart';

class CupertinoStoreApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // This app is designed only to work vertically, so we limit
    // orientations to portrait up and down.
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);

    return CupertinoApp(
      theme: const CupertinoThemeData(brightness: Brightness.light),
      debugShowCheckedModeBanner: false,
      home: CupertinoStoreHomePage(),
    );
  }
}

class CupertinoStoreHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CupertinoTabScaffold(
      tabBar: CupertinoTabBar(
        backgroundColor: Colors.white,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Image(
                image: AssetImage('assets/home.png'), width: 28, height: 28),
          ),
          BottomNavigationBarItem(
            icon: Image(
                image: AssetImage(
                  'assets/search.png',
                ),
                width: 28,
                height: 28),
          ),
          BottomNavigationBarItem(
            icon: Image(
                image: AssetImage('assets/events.png'), width: 28, height: 28),
          ),
          BottomNavigationBarItem(
            icon: Image(
                image: AssetImage('assets/profile.png'), width: 28, height: 28),
          ),
        ],
      ),
      tabBuilder: (context, index) {
        late final CupertinoTabView returnValue;
        switch (index) {
          case 0:
            returnValue = CupertinoTabView(builder: (context) {
              return HomePage();
            });
            break;
          case 1:
            returnValue = CupertinoTabView(builder: (context) {
              return SearchPage();
            });
            break;
          case 2:
            returnValue = CupertinoTabView(builder: (context) {
              return EventPage();
            });
            break;
          case 3:
            returnValue = CupertinoTabView(builder: (context) {
              return ProfilePage();
            });
            break;
        }
        return returnValue;
      },
    );
  }
}
