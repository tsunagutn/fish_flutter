import 'package:flutter/material.dart';
import 'package:fish_flutter/Class/clsColor.dart';

//メニューのカード
class menuCard extends StatefulWidget {
  const menuCard({
    required this.cardText,
    required this.icon,
  });

  final String cardText;
  final IconData icon;

  @override
  _menuCardState createState() => _menuCardState();
}

class _menuCardState extends State<menuCard> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 30),
      color: clsColor.getColorFromHex("ffffe0"),
      elevation: 10,
      shadowColor: clsColor.getColorFromHex("555555"),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: InkWell(
          splashColor: Colors.blue.withAlpha(10),
          borderRadius: BorderRadius.circular(10),
          child: Container(
              margin: const EdgeInsets.all(10.0),
              width: 200,
              height: 50,
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Icon(
                      widget.icon,
                      color: Colors.green,
                      size: 30.0,
                    ),
                    Text(
                      widget.cardText,
                      style: TextStyle(fontSize: 16, color: Colors.black),
                    ),
                  ]),
          ),
      ),
    );
  }
}
