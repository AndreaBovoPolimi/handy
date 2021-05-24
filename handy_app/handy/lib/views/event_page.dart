import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:handy/models/events.dart';
import 'package:handy/services/external_API.dart';
import 'package:handy/utils/category.dart';
import 'package:handy/utils/date.dart';
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

  bool isGroup = true;
  bool isLoaded = false;

  bool iskeyboardOpen = false;

  late Events events;

  final searchController = TextEditingController();

  @override
  void initState() {
    var keyboardVisibilityController = KeyboardVisibilityController();

    keyboardVisibilityController.onChange.listen((bool visible) {
      setState(() {
        iskeyboardOpen = visible;
      });
    });

    getEvents();
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    searchController.dispose();
    super.dispose();
  }

  Future<void> getEvents() async {
    setState(() {
      isLoaded = false;
    });
    events = await getAllEvents();
    setState(() {
      isLoaded = true;
    });
  }

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
              style: TextStyle(
                  fontSize: 28,
                  //fontWeight: FontWeight.bold,
                  fontFamily: 'NunitoBold'),
            ),
          ),
          GestureDetector(
              onTap: () {
                FocusScope.of(context).unfocus();
                setState(() => isGroup ? isGroup = false : isGroup = true);
              },
              child: topButtonSearch()),
          GestureDetector(
              onTap: () {
                FocusScope.of(context).unfocus();
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => MyEventPage()),
                );
              },
              child: topButtonPath('assets/my_events.png')),
        ]),
      ),
      child: Container(
        color: HexColor("#F6F8F8"),
        child: //RefreshIndicator(
            //onRefresh: getEvents,
            Padding(
          padding: EdgeInsets.only(left: 0, top: 20, right: 0, bottom: 0),
          child: Column(
            children: [
              isGroup
                  ? Column(
                      children: [
                        Row(children: [
                          GestureDetector(
                            onTap: () {
                              FocusScope.of(context).unfocus();
                              setState(() => isMusicOn
                                  ? isMusicOn = false
                                  : isMusicOn = true);
                            },
                            child: Container(
                              child: topCard("assets/music.png", Colors.black,
                                  HexColor("#ACCCFF"), "MUSIC", isMusicOn),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              FocusScope.of(context).unfocus();
                              setState(() => isSportOn
                                  ? isSportOn = false
                                  : isSportOn = true);
                            },
                            child: topCard("assets/man.png", Colors.black,
                                HexColor("#FFC8AC"), "SPORT", isSportOn),
                          ),
                          GestureDetector(
                            onTap: () {
                              FocusScope.of(context).unfocus();
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
                                FocusScope.of(context).unfocus();
                                setState(() => isConferenceOn
                                    ? isConferenceOn = false
                                    : isConferenceOn = true);
                              },
                              child: Container(
                                margin: EdgeInsets.only(
                                    left: 60, top: 0, right: 0, bottom: 0),
                                child: topCard(
                                    "assets/mic.png",
                                    Colors.black,
                                    HexColor("#FFC3D8"),
                                    "CONFERENCE",
                                    isConferenceOn),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                FocusScope.of(context).unfocus();
                                setState(() => isRoundtableOn
                                    ? isRoundtableOn = false
                                    : isRoundtableOn = true);
                              },
                              child: Container(
                                margin: EdgeInsets.only(
                                    left: 0, top: 0, right: 60, bottom: 0),
                                child: topCard(
                                    "assets/hand.png",
                                    Colors.black,
                                    HexColor("#739B53"),
                                    "ROUNDTABLE",
                                    isRoundtableOn),
                              ),
                            ),
                          ],
                        ),
                      ],
                    )
                  : Padding(
                      padding: EdgeInsets.only(
                          left: 0, top: 38, right: 0, bottom: 38),
                      child: Center(
                        child: Container(
                          width: 365,
                          height: 44,
                          child: CupertinoTextField(
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.black,
                            ),
                            onChanged: (value) {
                              setState(() => isGroup = false);
                            },
                            decoration: BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.1),
                                    spreadRadius: 5,
                                    blurRadius: 7,
                                    offset: Offset(
                                        0, 3), // changes position of shadow
                                  ),
                                ],
                                color: Colors.white,
                                border: Border.all(color: Colors.black12),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20))),
                            controller: searchController,
                            placeholder: "Search...",
                            cursorColor: HexColor("#FF5722"),
                            clearButtonMode: OverlayVisibilityMode.editing,
                            prefix: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Image(
                                  image: AssetImage('assets/search_events.png'),
                                  width: 16,
                                  height: 16),
                            ),
                            prefixMode: OverlayVisibilityMode.always,
                          ),
                        ),
                      ),
                    ),
              Container(
                margin:
                    EdgeInsets.only(left: 20, top: 20, right: 271, bottom: 0),
                child: Text(
                  'Upcoming',
                  style: TextStyle(
                      fontSize: 26,
                      color: Colors.black,
                      //fontWeight: FontWeight.bold,
                      fontFamily: 'NunitoBold'),
                ),
              ),
              isLoaded
                  ? Padding(
                      padding: EdgeInsets.only(
                          left: 0, top: 10, right: 0, bottom: 0),
                      child: Container(
                        height: iskeyboardOpen ? 256 : 518,
                        child: CustomScrollView(
                          keyboardDismissBehavior:
                              ScrollViewKeyboardDismissBehavior.onDrag,
                          slivers: [
                            CupertinoSliverRefreshControl(
                              onRefresh: getEvents,
                            ),
                            SliverList(
                              delegate: SliverChildBuilderDelegate(
                                (context, index) {
                                  if (isGroup) {
                                    if (!isConferenceOn &&
                                        !isMusicOn &&
                                        !isRoundtableOn &&
                                        !isSportOn &&
                                        !isWorkshopOn) {
                                      return eventCard(events.events[index]);
                                    } else {
                                      if (isConferenceOn &&
                                          events.events[index].category
                                                  .toUpperCase() ==
                                              "CONFERENCE")
                                        return eventCard(events.events[index]);
                                      if (isMusicOn &&
                                          events.events[index].category
                                                  .toUpperCase() ==
                                              "MUSIC")
                                        return eventCard(events.events[index]);
                                      if (isRoundtableOn &&
                                          events.events[index].category
                                                  .toUpperCase() ==
                                              "ROUNDTABLE")
                                        return eventCard(events.events[index]);
                                      if (isSportOn &&
                                          events.events[index].category
                                                  .toUpperCase() ==
                                              "SPORT")
                                        return eventCard(events.events[index]);
                                      if (isWorkshopOn &&
                                          events.events[index].category
                                                  .toUpperCase() ==
                                              "WORKSHOP")
                                        return eventCard(events.events[index]);
                                    }
                                  } else {
                                    if (searchController.text == "") {
                                      return eventCard(events.events[index]);
                                    } else {
                                      if (events.events[index].title
                                          .toUpperCase()
                                          .contains(searchController.text
                                              .toUpperCase())) {
                                        return eventCard(events.events[index]);
                                      }
                                    }
                                  }
                                  return SizedBox.shrink();
                                },
                                childCount: events.events.length,
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  : Stack(children: [
                      SizedBox(
                        width: 500,
                        height: 350,
                        child: Center(
                          child: CircularProgressIndicator(
                            color: HexColor("#FF5722"),
                          ),
                        ),
                      )
                    ])
            ],
          ),
        ),
      ),
    );
  }

  List<Widget> getEventsList() {
    List<Widget> list = [SizedBox.shrink()];
    if (isLoaded) {
      for (var event in events.events) {
        if (isGroup) {
          if (!isConferenceOn &&
              !isMusicOn &&
              !isRoundtableOn &&
              !isSportOn &&
              !isWorkshopOn) {
            list.add(eventCard(event));
          } else {
            if (isConferenceOn && event.category.toUpperCase() == "CONFERENCE")
              list.add(eventCard(event));
            if (isMusicOn && event.category.toUpperCase() == "MUSIC")
              list.add(eventCard(event));
            if (isRoundtableOn && event.category.toUpperCase() == "ROUNDTABLE")
              list.add(eventCard(event));
            if (isSportOn && event.category.toUpperCase() == "SPORT")
              list.add(eventCard(event));
            if (isWorkshopOn && event.category.toUpperCase() == "WORKSHOP")
              list.add(eventCard(event));
          }
        } else {
          if (searchController.text == "") {
            list.add(eventCard(event));
          } else {
            if (event.title
                .toUpperCase()
                .contains(searchController.text.toUpperCase())) {
              list.add(eventCard(event));
            }
          }
        }
      }
    } else {
      list.add(
        Stack(children: [
          SizedBox(
            width: 500,
            height: 350,
            child: Center(
              child: CircularProgressIndicator(
                color: HexColor("#FF5722"),
              ),
            ),
          )
        ]),
      );
    }
    return list;
  }

  Widget topButtonSearch() {
    return Container(
      margin: EdgeInsets.only(left: 45, top: 0, right: 10, bottom: 0),
      width: 50,
      height: 50,
      child: Center(
          child: Image(
              image: AssetImage(
                  isGroup ? 'assets/search_events.png' : 'assets/my_group.png'),
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
                    style: TextStyle(
                        fontSize: 11,
                        color: backgroundColor,
                        fontFamily: 'NunitoBold')),
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

  Widget eventCard(Event event) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
        Navigator.of(context, rootNavigator: true).push(
          MaterialPageRoute(builder: (context) => SingleEventPage(true, event)),
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
                  child: Text(months[event.dateTimeStart.month - 1],
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
                          child: Text(event.dateTimeStart.day.toString(),
                              style: TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.bold))),
                      Container(
                        padding: EdgeInsets.all(8),
                        child: Text(weeks[event.dateTimeStart.weekday - 1],
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
                    child: Image.network(
                      event.url,
                      width: 284,
                      height: 222.34,
                      fit: BoxFit.fill,
                    ),
                  ),
                  Opacity(
                    opacity: 0.5,
                    child: Container(
                      width: 284,
                      height: 222.34,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15.0),
                          gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [Colors.transparent, Colors.blue])),
                      alignment: Alignment.center,
                    ),
                  ),
                  Wrap(
                    direction: Axis.vertical,
                    children: [
                      SizedBox(height: 120),
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 5, top: 5, right: 5, bottom: 0),
                        child: Text(
                            weeks[event.dateTimeStart.weekday - 1] +
                                " " +
                                months[event.dateTimeStart.month - 1] +
                                " " +
                                event.dateTimeStart.day.toString() +
                                ", " +
                                event.dateTimeStart.hour.toString() +
                                ":" +
                                event.dateTimeStart.minute.toString(),
                            style: TextStyle(
                                fontSize: 11,
                                fontWeight: FontWeight.bold,
                                color: Colors.white)),
                      ),
                      Container(
                        padding: EdgeInsets.only(
                            left: 5, top: 5, right: 5, bottom: 0),
                        width: 274,
                        child: Text(event.title,
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
                                  image: AssetImage(
                                      mapCategory[event.category.toUpperCase()]
                                          .toString()),
                                  width: 16,
                                  height: 16),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(2.0),
                              child: Text(event.category,
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
                              child: Text(
                                  event.price == 0
                                      ? "Free"
                                      : "€" + event.price.toString(),
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
