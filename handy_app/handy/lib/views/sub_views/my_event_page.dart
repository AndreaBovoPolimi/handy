import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:handy/models/events.dart';
import 'package:handy/services/external_API.dart';
import 'package:handy/utils/category.dart';
import 'package:handy/utils/date.dart';
import 'package:handy/views/sub_views/single_event_page.dart';
import 'package:hexcolor/hexcolor.dart';

class MyEventPage extends StatefulWidget {
  @override
  _MyEventPageState createState() {
    return _MyEventPageState();
  }
}

class _MyEventPageState extends State<MyEventPage> {
  bool isLoaded = false;

  late Events events;

  @override
  void initState() {
    getEvents();
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed
    super.dispose();
  }

  Future<void> getEvents() async {
    setState(() {
      events = Events(result: true, events: []);
    });
    events = await getAllMyEvents();
    setState(() {
      isLoaded = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
        backgroundColor: HexColor("#F6F8F8"),
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
              style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.w600,
                  fontFamily: 'NunitoBold'),
            ),
          ),
        ),
        child: Container(
          color: HexColor("#F6F8F8"),
          child: isLoaded
              ? Padding(
                  padding:
                      EdgeInsets.only(left: 0, top: 20, right: 0, bottom: 0),
                  child: CustomScrollView(
                    slivers: [
                      CupertinoSliverRefreshControl(
                        onRefresh: getEvents,
                      ),
                      SliverList(
                        delegate: SliverChildBuilderDelegate(
                          (context, index) {
                            return myEventsCard(events.events[index]);
                          },
                          childCount: events.events.length,
                        ),
                      ),
                    ],
                  ),
                )
              : Center(
                  child: CircularProgressIndicator(
                  color: HexColor("#FF5722"),
                )),
        ));
  }

  /* ListView.builder(
                  shrinkWrap: true,
                  padding:
                      EdgeInsets.only(left: 0, top: 20, right: 0, bottom: 0),
                  itemCount: events.events.length,
                  itemBuilder: (context, index) {
                    if (index == 0) {
                      return CupertinoSliverRefreshControl(
                          refreshTriggerPullDistance: 100.0,
                          refreshIndicatorExtent: 60.0,
                          onRefresh: getEvents);
                    } else {
                      return myEventsCard(events.events[index]);
                    }
                  })*/

  Widget myEventsCard(Event event) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context, rootNavigator: true)
            .push(
              MaterialPageRoute(
                  builder: (context) => SingleEventPage(false, event)),
            )
            .then((value) => getEvents());
      },
      child: Container(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            Column(
              children: [
                Container(
                  padding: EdgeInsets.all(8),
                  child: Text(months[event.datetimeStart.month - 1],
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
                          child: Text(event.datetimeStart.day.toString(),
                              style: TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.bold))),
                      Container(
                        padding: EdgeInsets.all(8),
                        child: Text(weeks[event.datetimeStart.weekday - 1],
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
                          child: Row(
                            children: [
                              Padding(
                                padding: EdgeInsets.only(
                                    left: 0, top: 0, right: 4, bottom: 0),
                                child: Image(
                                    image: AssetImage(mapCategory[
                                            event.category.toUpperCase()]
                                        .toString()),
                                    width: 20,
                                    height: 20),
                              ),
                              Container(
                                width: 300,
                                child: Text(
                                  event.title,
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
                        Padding(
                          padding: EdgeInsets.only(
                              left: 0, top: 0, right: 0, bottom: 2),
                          child: Text(event.location.title,
                              style: TextStyle(
                                  fontSize: 12, color: Colors.grey[400])),
                        ),
                        Text(
                            event.datetimeStart.hour.toString() +
                                ":" +
                                event.datetimeStart.minute.toString() +
                                " - " +
                                event.datetimeEnd.hour.toString() +
                                ":" +
                                event.datetimeEnd.minute.toString(),
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
