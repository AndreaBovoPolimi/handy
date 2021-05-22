import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:handy/views/sub_views/my_event_page.dart';
import 'package:handy/views/sub_views/single_event_page.dart';
import 'package:hexcolor/hexcolor.dart';

class EventPage extends StatefulWidget {
  @override
  _EventPageState createState() {
    return _EventPageState();
  }
}

class _EventPageState extends State<EventPage> {
  bool isMusicOn = false;
  bool isSportOn = false;
  bool isWorkshopOn = false;
  bool isConferenceOn = false;
  bool isRoundtableOn = false;

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        backgroundColor: HexColor("#F6F8F8"),
        border: Border(
            top: BorderSide(color: HexColor("#F6F8F8"), width: 0),
            right: BorderSide(color: HexColor("#F6F8F8"), width: 0),
            left: BorderSide(color: HexColor("#F6F8F8"), width: 0),
            bottom: BorderSide(color: HexColor("#F6F8F8"), width: 0)),
        middle: Row(children: [
          Container(
            child: Text(
              '  Discover events  ',
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.w600),
            ),
          ),
          GestureDetector(onTap: () {}, child: topButtonSearch()),
          GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => MyEventPage()),
                );
              },
              child: topButtonPath('assets/my_events.jpeg')),
        ]),
      ),
      child: Container(
        color: HexColor("#F6F8F8"),
        child: ListView(
          padding: EdgeInsets.only(left: 0, top: 20, right: 0, bottom: 0),
          children: [
            Column(
              children: [
                Row(children: [
                  GestureDetector(
                    onTap: () {
                      setState(() =>
                          isMusicOn ? isMusicOn = false : isMusicOn = true);
                    },
                    child: Container(
                      child: topCard("assets/music.png", Colors.black,
                          HexColor("#ACCCFF"), "MUSIC", isMusicOn),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() =>
                          isSportOn ? isSportOn = false : isSportOn = true);
                    },
                    child: topCard("assets/man.png", Colors.black,
                        HexColor("#FFC8AC"), "SPORT", isSportOn),
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() => isWorkshopOn
                          ? isWorkshopOn = false
                          : isWorkshopOn = true);
                    },
                    child: topCard("assets/laptop.png", Colors.black,
                        HexColor("#D75757"), "WORKSHOP", isWorkshopOn),
                  ),
                ]),
                Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        setState(() => isConferenceOn
                            ? isConferenceOn = false
                            : isConferenceOn = true);
                      },
                      child: Container(
                        margin: EdgeInsets.only(
                            left: 60, top: 0, right: 0, bottom: 0),
                        child: topCard("assets/mic.png", Colors.black,
                            HexColor("#FFC3D8"), "CONFERENCE", isConferenceOn),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        setState(() => isRoundtableOn
                            ? isRoundtableOn = false
                            : isRoundtableOn = true);
                      },
                      child: Container(
                        margin: EdgeInsets.only(
                            left: 0, top: 0, right: 60, bottom: 0),
                        child: topCard("assets/hand.png", Colors.black,
                            HexColor("#739B53"), "ROUNDTABLE", isRoundtableOn),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            Container(
              margin: EdgeInsets.only(left: 0, top: 20, right: 0, bottom: 0),
              child: Text(
                '  Upcoming',
                style: TextStyle(fontSize: 26, fontWeight: FontWeight.w500),
              ),
            ),
            eventCard(),
            eventCard(),
            eventCard(),
            eventCard(),
            eventCard(),
          ],
        ),
      ),
    );
  }

  Widget topButtonSearch() {
    return Container(
      margin: EdgeInsets.only(left: 45, top: 0, right: 10, bottom: 0),
      width: 50,
      height: 50,
      child: Center(
          child: Image(
              image: AssetImage('assets/search_events.jpeg'),
              width: 16,
              height: 16)),
      decoration: decorationShadow(),
    );
  }

  Widget topButtonPath(String imagePath) {
    return Container(
      width: 50,
      height: 50,
      child: Center(
          child: Image(image: AssetImage(imagePath), width: 16, height: 16)),
      decoration: decorationShadow(),
    );
  }

  Widget topButtonIcon(
      String imagePath, Color color, HexColor backgroundColor) {
    return Container(
      margin: EdgeInsets.all(6.0),
      width: 40,
      height: 40,
      child: Center(
          child: Image(image: AssetImage(imagePath), width: 20, height: 20)),
      decoration: decorationShadowHexColor(backgroundColor),
    );
  }

  Widget topCard(String iconPath, Color color, HexColor backgroundColor,
      String text, bool isOn) {
    return SizedBox(
      width: 138,
      height: 60,
      child: Card(
        shape: StadiumBorder(
          side: BorderSide(
            color: isOn ? Colors.orangeAccent : Colors.white,
            width: 2.0,
          ),
        ),
        color: Colors.white,
        borderOnForeground: false,
        child: Container(
          child: Center(
            child: Row(
              children: [
                topButtonIcon(iconPath, color, backgroundColor),
                Text(text,
                    style: TextStyle(fontSize: 10.5, color: backgroundColor)),
              ],
            ),
          ),
        ),
      ),
    );
  }

  BoxDecoration decorationShadow() {
    return BoxDecoration(
      shape: BoxShape.circle,
      color: Colors.white,
      boxShadow: [
        BoxShadow(
          color: Colors.grey.withOpacity(0.1),
          spreadRadius: 5,
          blurRadius: 7,
          offset: Offset(0, 3), // changes position of shadow
        ),
      ],
    );
  }

  BoxDecoration decorationShadowHexColor(HexColor backgroundColor) {
    return BoxDecoration(
      shape: BoxShape.circle,
      color: backgroundColor,
      boxShadow: [
        BoxShadow(
          color: Colors.grey.withOpacity(0.1),
          spreadRadius: 5,
          blurRadius: 7,
          offset: Offset(0, 3), // changes position of shadow
        ),
      ],
    );
  }

  Widget eventCard() {
    return GestureDetector(
      onTap: () {
        Navigator.of(context, rootNavigator: true).push(
          MaterialPageRoute(builder: (context) => SingleEventPage()),
        );
      },
      child: Container(
        padding: EdgeInsets.all(25),
        child: Row(
          children: [
            Column(
              children: [
                SizedBox(
                  height: 15,
                ),
                Container(
                  padding: EdgeInsets.all(8),
                  child: Text("MAY",
                      style: TextStyle(
                          fontSize: 10.5, color: HexColor("#FF5722"))),
                ),
                Container(
                    child: Card(
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Column(
                    children: [
                      Container(
                          padding: EdgeInsets.all(8),
                          child: Text("15",
                              style: TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.bold))),
                      Container(
                        padding: EdgeInsets.all(8),
                        child: Text("SAT",
                            style: TextStyle(
                                fontSize: 10, color: HexColor("#C1C1C1"))),
                      ),
                    ],
                  ),
                )),
                SizedBox(
                  height: 100,
                ),
              ],
            ),
            Padding(
                padding: EdgeInsets.only(left: 30, top: 0, right: 0, bottom: 0),
                child: Stack(children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(15.0),
                    child: Image.asset(
                      'assets/conference.png',
                      width: 284,
                      height: 222.34,
                      fit: BoxFit.fill,
                    ),
                  ),
                  Wrap(
                    direction: Axis.vertical,
                    children: [
                      SizedBox(height: 120),
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 5, top: 5, right: 5, bottom: 0),
                        child: Text("SATURDAY MAY 15, 4PM",
                            style: TextStyle(
                                fontSize: 11,
                                fontWeight: FontWeight.bold,
                                color: Colors.white)),
                      ),
                      Container(
                        padding: EdgeInsets.only(
                            left: 5, top: 5, right: 5, bottom: 0),
                        width: 274,
                        child: Text(
                            "Inside the mind of a master procrastinator | Tim Urban",
                            style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.white)),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(2.0),
                              child: Image(
                                  image: AssetImage('assets/mic.png'),
                                  width: 16,
                                  height: 16),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(2.0),
                              child: Text("Conference",
                                  style: TextStyle(
                                      fontSize: 12, color: Colors.grey[400])),
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                  left: 15, top: 2, right: 2, bottom: 2),
                              child: Image(
                                  image: AssetImage('assets/free.png'),
                                  width: 16,
                                  height: 16),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(2.0),
                              child: Text("Free",
                                  style: TextStyle(
                                      fontSize: 12, color: Colors.grey[300])),
                            ),
                          ],
                        ),
                      )
                    ],
                  )
                ])),
          ],
        ),
      ),
    );
  }
}
