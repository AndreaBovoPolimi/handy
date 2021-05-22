import 'package:flutter/cupertino.dart';
import 'package:hexcolor/hexcolor.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() {
    return _HomePageState();
  }
}

class _HomePageState extends State<HomePage> {
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
                '  Home  ',
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.w600),
              ),
            )
          ]),
        ),
        child: Center(child: Text("da sviluppare")));
  }
}
