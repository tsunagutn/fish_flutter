import 'package:fish_flutter/Model/FishModel.dart';
import 'package:fish_flutter/Model/LuresModel.dart';
import 'package:fish_flutter/TypeAdapter/typLureData.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

import '../Main.dart';
import '../TypeAdapter/typFishResult.dart';
import '../TypeAdapter/typGameData.dart';
import 'RadarChart.dart';

class lureLvUpDialog extends StatefulWidget {
  @override
  const lureLvUpDialog({
    required this.lureIdx,
    required this.radarDatas,
    required this.nowLv,
    required this.newLv,
    required this.dispSize,
    required this.weightMsg,
  });
  final int lureIdx;
  final List<List<RadarChartItemModel>> radarDatas;
  final int nowLv;
  final int newLv;
  final Size dispSize;
  final String weightMsg;

  _lureLvUpDialogState createState() => _lureLvUpDialogState();
}

class _lureLvUpDialogState extends State<lureLvUpDialog>
    with TickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animationValue;

  late typLureData lureData;

  @override
  void initState() {
    final gameDataBox = Hive.box(gamedataBoxName);
    final typGameData gameData = gameDataBox.get(gamedataKeyName);
    lureData = gameData.lureData[gameData.useLureIdx];

    _animationController = AnimationController(
        duration: Duration(milliseconds: 2000), vsync: this);
    _animationValue = Tween(begin: 1.5, end: 0.0).animate(_animationController)
      ..addListener(() {
        setState(() {});
      });
    _animationController.forward();
    //ジングル鳴らす
    soundManagerPool.playSound('se/jingle01.mp3');

    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        child: AlertDialog(
      titleTextStyle: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold,
          shadows: <Shadow>[
            Shadow(
                offset: Offset(2.0, 4.0), blurRadius: 2.0, color: Colors.black)
          ]),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20.0))),
      // backgroundColor:
      //     clsColor._getColorFromHex('D1F6FF').withOpacity(0.7),
      title: Text(lureData.name + "がレベルアップ",
          style: TextStyle(
            //fontWeight: FontWeight.bold,
            fontSize: 20,
            //color: Color.fromRGBO(r, g, b, 1.0),
            shadows: <Shadow>[
              Shadow(
                  offset: Offset(4.0, 10.0),
                  blurRadius: 2.0,
                  color: Colors.black.withOpacity(0.3))
            ],
          )),
      insetPadding: EdgeInsets.all(8),
      content: Container(
          height: widget.dispSize.height / 1.5,
          width: widget.dispSize.width / 2,
          child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Column(
                  children: [
                    Container(margin: EdgeInsets.only(left:8, right: 8),
                      child:
                      new Image(
                        image: AssetImage('assets/images/' + lureData.image),
                        fit: BoxFit.fill,
                        //height: 240,
                        width: widget.dispSize.width / 2,
                      ),
                    ),
                    Text(
                      widget.weightMsg,
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),

                    new RadarChart(
                      key: UniqueKey(),
                      items: widget.radarDatas,
                      borderColor: Colors.grey,
                      radarColors: [Colors.yellowAccent, Colors.amber],
                      fontColor: Colors.black,
                    ),

                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ElevatedButton(
                      child: Text("OK"),
                      onPressed: () async {
                        Navigator.pop(context);
                      },
                    ),
                  ],
                ),
              ])),
    ));
  }
}

// builder: (BuildContext context) {
