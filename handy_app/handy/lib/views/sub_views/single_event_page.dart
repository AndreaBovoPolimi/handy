import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:maps_launcher/maps_launcher.dart';

class SingleEventPage extends StatefulWidget {
  bool _isRegisterable = true;

  SingleEventPage(bool isRegisterable) {
    this._isRegisterable = isRegisterable;
  }

  @override
  _SingleEventPageState createState() {
    return _SingleEventPageState(_isRegisterable);
  }
}

class _SingleEventPageState extends State<SingleEventPage> {
  bool _isRegisterable = true;

  _SingleEventPageState(bool isRegisterable) {
    this._isRegisterable = isRegisterable;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        color: HexColor("#10181F"),
        child: Stack(children: [
          Container(
            height: 564,
            width: 700,
            child: Image(
              image: AssetImage('assets/conference_big.png'),
              fit: BoxFit.contain,
              alignment: Alignment.topCenter,
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
              top: 544,
              left: 0,
              child: Opacity(
                  opacity: 0.5,
                  child: Container(
                    width: 420,
                    height: 20,
                    color: HexColor("#10181F"),
                  ))),
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
                      child: Text("Inside the mind of a master procrastinator",
                          style: TextStyle(fontSize: 28, color: Colors.white)),
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
                                "Saturday, 15 May 2021 - 4:00PM - 5:00PM",
                                style: TextStyle(
                                    fontSize: 14, color: Colors.white)),
                          ),
                        ),
                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      MapsLauncher.launchQuery(
                          'Via Giuseppe Ponzio, 34/5, 20133 Milano MI');
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
                                  child: Text("Conference Room Emilio Gatti",
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
                              child: Text(
                                  "Via Giuseppe Ponzio, 34/5, 20133 Milano MI",
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
                          image: AssetImage('assets/mic.png'),
                          width: 20,
                          height: 20,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Container(
                            width: 420,
                            child: Text("Conference",
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
                            child: Text("free",
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
                    onTap: () {
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
                            child: Text("Register",
                                style: TextStyle(
                                    fontSize: 22,
                                    color: HexColor("#FF5722"),
                                    fontWeight: FontWeight.bold)),
                          ),
                        )),
                  ),
                )
              : Text(""),
        ]));
  }
}
