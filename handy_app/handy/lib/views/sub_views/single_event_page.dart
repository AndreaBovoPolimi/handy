import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:handy/models/events.dart';
import 'package:handy/services/external_API.dart';
import 'package:handy/utils/category.dart';
import 'package:handy/utils/date.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:maps_launcher/maps_launcher.dart';

class SingleEventPage extends StatefulWidget {
  bool _isRegisterable = true;
  Event? _event;

  SingleEventPage(bool isRegisterable, Event event) {
    this._isRegisterable = isRegisterable;
    this._event = event;
  }

  @override
  _SingleEventPageState createState() {
    return _SingleEventPageState(_isRegisterable, _event!);
  }
}

class _SingleEventPageState extends State<SingleEventPage> {
  bool _isRegisterable = true;
  Event? _event;

  _SingleEventPageState(bool isRegisterable, Event event) {
    this._isRegisterable = isRegisterable;
    this._event = event;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        color: HexColor("#10181F"),
        child: Stack(children: [
          Container(
            height: 564,
            width: 700,
            child: Image.network(
              _event!.url,
              fit: BoxFit.fitHeight,
              alignment: Alignment.centerRight,
            ),
          ),
          Positioned(
            top: 49,
            left: 15,
            child: GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Image(
                  image: AssetImage('assets/vector_white.png'),
                  width: 28,
                  height: 28,
                )),
          ),
          Positioned(
              top: 494,
              left: 0,
              child: Opacity(
                opacity: 1,
                child: Container(
                  width: 420,
                  height: 70,
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [Colors.transparent, HexColor("#10181F")])),
                  alignment: Alignment.center,
                ),
              )),
          Positioned(
              top: 564,
              left: 0,
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Wrap(direction: Axis.vertical, children: [
                  Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Container(
                      width: 420,
                      child: Text(_event!.title,
                          style: TextStyle(
                              fontSize: 28,
                              color: Colors.white,
                              fontFamily: 'NunitoBold')),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Image(
                          image: AssetImage('assets/my_event.png'),
                          width: 20,
                          height: 20,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Container(
                            width: 420,
                            child: Text(
                                weeks[_event!.dateTimeStart.weekday - 1] +
                                    " " +
                                    months[_event!.dateTimeStart.month - 1] +
                                    " " +
                                    _event!.dateTimeStart.day.toString() +
                                    ", " +
                                    _event!.dateTimeStart.hour.toString() +
                                    ":" +
                                    _event!.dateTimeStart.minute.toString() +
                                    " - " +
                                    _event!.dateTimeEnd.hour.toString() +
                                    ":" +
                                    _event!.dateTimeEnd.minute.toString(),
                                style: TextStyle(
                                    fontSize: 14, color: Colors.white)),
                          ),
                        ),
                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      MapsLauncher.launchQuery(_event!.street);
                      //MapsLauncher.launchCoordinates(37.4220041, -122.0862462);
                    },
                    child: Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(
                              left: 8, top: 8, right: 8, bottom: 0),
                          child: Row(
                            children: [
                              Image(
                                image: AssetImage('assets/location.png'),
                                width: 20,
                                height: 20,
                              ),
                              Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: Container(
                                  width: 420,
                                  child: Text(_event!.place,
                                      style: TextStyle(
                                          fontSize: 14, color: Colors.white)),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                            padding: EdgeInsets.only(
                                left: 24, top: 0, right: 0, bottom: 0),
                            child: Container(
                              width: 420,
                              child: Text(_event!.street,
                                  style: TextStyle(
                                      fontSize: 10, color: Colors.white54)),
                            )),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Image(
                          image: AssetImage(
                              mapCategory[_event!.category.toUpperCase()]
                                  .toString()),
                          width: 20,
                          height: 20,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Container(
                            width: 420,
                            child: Text(_event!.category,
                                style: TextStyle(
                                    fontSize: 14, color: Colors.white)),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Image(
                          image: AssetImage('assets/free.png'),
                          width: 20,
                          height: 20,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Container(
                            width: 420,
                            child: Text(
                                _event!.price == 0
                                    ? "Free"
                                    : "€" + _event!.price.toString(),
                                style: TextStyle(
                                    fontSize: 14, color: Colors.white)),
                          ),
                        ),
                      ],
                    ),
                  )
                ]),
              )),
          _isRegisterable
              ? Positioned(
                  top: 810,
                  left: 195,
                  child: GestureDetector(
                    onTap: () async {
                      await postEventSubscription(_event!.id);
                      Navigator.pop(context);
                    },
                    child: Card(
                        color: HexColor("#FF5722"),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(13.0),
                        ),
                        child: Container(
                          height: 50,
                          width: 200,
                          child: Center(
                            child: Text("Subscribe",
                                style: TextStyle(
                                    fontSize: 22,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold)),
                          ),
                        )),
                  ),
                )
              : Positioned(
                  top: 810,
                  left: 195,
                  child: GestureDetector(
                    onTap: () async {
                      await deleteEventSubscription(_event!.id);
                      Navigator.pop(context);
                    },
                    child: Card(
                        color: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(13.0),
                        ),
                        child: Container(
                          height: 50,
                          width: 200,
                          child: Center(
                            child: Text("Unsubscribe",
                                style: TextStyle(
                                    fontSize: 22,
                                    color: HexColor("#FF5722"),
                                    fontWeight: FontWeight.bold)),
                          ),
                        )),
                  ),
                ),
        ]));
  }
}
