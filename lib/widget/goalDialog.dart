import 'package:fish_flutter/Model/FishModel.dart';
import 'package:fish_flutter/Model/FishResultsModel.dart';
import 'package:fish_flutter/Model/LuresModel.dart';
import 'package:fish_flutter/TypeAdapter/typFishResult.dart';
import 'package:fish_flutter/TypeAdapter/typHistory.dart';
import 'package:fish_flutter/TypeAdapter/typResults.dart';
import 'package:fish_flutter/widget/clsGoal.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

import '../Main.dart';
import '../Model/relultAnimeModel.dart';
import '../TypeAdapter/typGameData.dart';
import 'BgmPlayer.dart';

class goalDialog extends StatefulWidget {
  @override
  const goalDialog({
    // required this.isHistory,
    required this.keyName,
    required this.marginTop,
  });

  // final bool isHistory;
  final String keyName;
  final double marginTop;

  _goalDialogState createState() => _goalDialogState();
}

class _goalDialogState extends State<goalDialog> with TickerProviderStateMixin {

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
    return AlertDialog(
                  titleTextStyle: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      shadows: <Shadow>[
                        Shadow(
                            offset: Offset(2.0, 4.0),
                            blurRadius: 2.0,
                            color: Colors.black)
                      ]),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(20.0))),
                  backgroundColor: Colors.white.withOpacity(0.9),
                  insetPadding: EdgeInsets.only(top: widget.marginTop),
                  content:
                  Container(
                    width: MediaQuery.of(context).size.width,
                    child:
                  new clsGoal(isHistory: true, keyName: widget.keyName),
                      ),
                  actions: <Widget>[
                    Row(mainAxisAlignment: MainAxisAlignment.center,
                    children: [
    ElevatedButton(
    child: Text("OK"),
    onPressed: () async {
      Navigator.pop(context);

    }),
                  ])]
                );
  }
}

// builder: (BuildContext context) {
