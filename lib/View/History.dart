import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:hive/hive.dart';

class History extends StatefulWidget {
  History({Key? key}) : super(key: key);

  @override
  _History createState() => _History();
}

class _History extends State<History> {

  late List<int> lstTest = [];

  @override
  void initState() {
    super.initState();
    final box = Hive.box('box');
    if (!box.containsKey('results')) {
      Navigator.pop(context);
    }
  }

  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            margin: EdgeInsets.all(200),
            child: Column(
              children: <Widget>[
              ],
            )));
  }
}