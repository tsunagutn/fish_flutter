import 'package:fish_flutter/Model/FishModel.dart';
import 'package:fish_flutter/Model/LuresModel.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;

import '../Main.dart';

class windDialog extends StatefulWidget {
  @override
  const windDialog({
    required this.dispSize,
    required this.nowWindLevel,
  });
  final Size dispSize;
  final double nowWindLevel;

  _windDialogState createState() => _windDialogState();
}

class _windDialogState extends State<windDialog>
    with TickerProviderStateMixin {

  List<double> lstWind = [];
  late double _selectWind;
  static const ITEMCOUNT = 3;
  static const CARDHEIGHT = 100.0;

  @override
  void initState() {
    super.initState();
    //初期値として現在の風レベルを格納
    _selectWind = widget.nowWindLevel;
    lstWind.add(widget.nowWindLevel);

    //ランダムで3つの風レベルを生成
    for (int i = 0; i < ITEMCOUNT; i++) {
      var rnd = (new math.Random()).nextDouble();
      lstWind.add(rnd);
    }
    //少ない順に並べ替え
    lstWind.sort((a, b) => a.compareTo(b));
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return Stack(children: [
          AlertDialog(
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

              content: Container(
                  height: widget.dispSize.height,
                  width: widget.dispSize.width,
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Column(
                          children: [
                  Container(
                    // decoration: BoxDecoration(
                    //   border: Border.all(color: Colors.red),
                    // ),
                    width: widget.dispSize.width / 2,
                    height: widget.dispSize.height / 2,
                    child: ListView.builder(
                      padding: EdgeInsets.only(top: 0, bottom: 0),
                      itemBuilder: (BuildContext context, int index) {
                        return Column(
                          children: [
                            GestureDetector(
                            onTap: () {
                          setState(() {
                            _selectWind = lstWind[index];
                          });
                        },
                        child: new Card(
                              //color: boxColor,
                              // shape: RoundedRectangleBorder(
                              //   side: BorderSide(
                              //     width: (flgBorder ? widget.borderWidth : 1),
                              //     color: borderColor,
                              //   ),
                              // ),
                              child: Container(
                                height: CARDHEIGHT,
                                margin: EdgeInsets.only(left: 3, right: 3),
                                child:
                                Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                                  Text(
                                    (10 * lstWind[index]).toInt().toString() + " m/s",
                                    textAlign: TextAlign.left,
                                    //style: TextStyle(color: Colors.black, fontSize: 12, fontWeight: (bold ? FontWeight.bold:FontWeight.normal)),
                                  ),
                                ]),
                              ),
                              //),
                            ),
                            ),
                          ],
                        );
                      },
                      itemCount: lstWind.length,
                    ),
                  ),








                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                ElevatedButton(
                                  child: Text("OK"),
                                  onPressed: () {
                                    Navigator.pop(context, _selectWind);
                                  },
                                ),
                              ],
                            ),
                         ]),
                      ])),
            )
    ]);
  }
}

// builder: (BuildContext context) {
