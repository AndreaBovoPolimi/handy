import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:handy/views/sub_views/single_event_page.dart';
import 'package:hexcolor/hexcolor.dart';

class MyEventPage extends StatefulWidget {
  @override
  _MyEventPageState createState() {
    return _MyEventPageState();
  }
}

class _MyEventPageState extends State<MyEventPage> {
  bool isMusicOn = false;
  bool isSportOn = false;
  bool isWorkshopOn = false;
  bool isConferenceOn = false;
  bool isRoundtableOn = false;

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
        navigationBar: CupertinoNavigationBar(
          leading: GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Image(
                  image: AssetImage('assets/vector.png'),
                  width: 18,
                  height: 18)),
          backgroundColor: HexColor("#F6F8F8"),
          border: Border(
              top: BorderSide(color: HexColor("#F6F8F8"), width: 0),
              right: BorderSide(color: HexColor("#F6F8F8"), width: 0),
              left: BorderSide(color: HexColor("#F6F8F8"), width: 0),
              bottom: BorderSide(color: HexColor("#F6F8F8"), width: 0)),
          middle: Center(
            child: Text(
              ' My events calendar      ',
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.w600),
            ),
          ),
        ),
        child: Container(
            color: HexColor("#F6F8F8"),
            child: ListView(
                padding: EdgeInsets.only(left: 0, top: 20, right: 0, bottom: 0),
                children: [
                  myEventsCard(),
                  myEventsCard(),
                  myEventsCard(),
                  myEventsCard()
                ])));
  }

  Widget myEventsCard() {
    return GestureDetector(
      onTap: () {
        Navigator.of(context, rootNavigator: true).push(
          MaterialPageRoute(builder: (context) => SingleEventPage(false)),
        );
      },
      child: Container(
        padding: const EdgeInsets.all(10.0),
        child: Row(
          children: [
            Column(
              children: [
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
              ],
            ),
            Padding(
              padding: EdgeInsets.only(left: 10, top: 20, right: 10, bottom: 0),
              child: Container(
                  width: 330,
                  height: 70,
                  child: Padding(
                    padding:
                        EdgeInsets.only(left: 10, top: 4, right: 4, bottom: 4),
                    child: Wrap(
                      direction: Axis.vertical,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(
                              left: 0, top: 0, right: 0, bottom: 6),
                          child: Flexible(
                            child: Row(
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(
                                      left: 0, top: 0, right: 4, bottom: 0),
                                  child: Image(
                                      image: AssetImage('assets/mic.png'),
                                      width: 20,
                                      height: 20),
                                ),
                                Container(
                                  width: 300,
                                  child: Text(
                                    "Inside the mind of a master procrastinator",
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 1,
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.w700,
                                        fontSize: 16),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                              left: 0, top: 0, right: 0, bottom: 2),
                          child: Text("Conference Room Emilio Gatti",
                              style: TextStyle(
                                  fontSize: 12, color: Colors.grey[400])),
                        ),
                        Text("4:00PM - 5:00PM",
                            style: TextStyle(
                                fontSize: 12, color: Colors.grey[400]))
                      ],
                    ),
                  )),
            ),
          ],
        ),
      ),
    );
  }
}
