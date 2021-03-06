import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:handy/views/event_page.dart';

class CupertinoStoreApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // This app is designed only to work vertically, so we limit
    // orientations to portrait up and down.
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);

    return CupertinoApp(
      theme: const CupertinoThemeData(
          brightness: Brightness.light,
          textTheme: CupertinoTextThemeData(
              textStyle: TextStyle(fontFamily: 'Nunito'))),
      debugShowCheckedModeBanner: false,
      home: CupertinoStoreHomePage(),
    );
  }
}

class CupertinoStoreHomePage extends StatelessWidget {
  var eventPage = EventPage();
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
              return eventPage;
            });
            break;
          case 1:
            returnValue = CupertinoTabView(builder: (context) {
              return eventPage;
            });
            break;
          case 2:
            returnValue = CupertinoTabView(builder: (context) {
              return eventPage;
            });
            break;
          case 3:
            returnValue = CupertinoTabView(builder: (context) {
              return eventPage;
            });
            break;
        }
        return returnValue;
      },
    );
  }
}
