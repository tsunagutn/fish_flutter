import 'package:fish_flutter/Model/FishModel.dart';
import 'package:fish_flutter/Model/FishResultsModel.dart';
import 'package:flutter/material.dart';

import 'SliderPainter.dart';

class FishCardList extends StatefulWidget {
  @override
  const FishCardList({
    required this.fishsTable,
    required this.fishesResult,
    required this.hitFishId,
    required this.pointerColor,
    required this.borderWidth,
    required this.flgRight,
  });

  final List<FishModel> fishsTable;
  final FishesResultModel fishesResult;
  final int hitFishId; //HITorアタリ中の魚ID 非HIT中は-1
  final Color pointerColor; //光点の色
  final double borderWidth; //枠線の幅
  final bool flgRight;
  _FishCardListState createState() => _FishCardListState();
}

class _FishCardListState extends State<FishCardList>
     {
  List<FishModel> fishList = [];

  static const double cardWidth = 100.0;
  static const double cardHeight = 19.0;

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
    fishList = [];
    widget.fishsTable.forEach((value) {
      fishList.add(value);
    });
    //リストソート タイプ→レア度
    fishList.sort((a, b) {
      int result = a.type.index.compareTo(b.type.index);
      //result = a.tanaMin.compareTo(b.tanaMin);
      if (result != 0) return result;
      return  a.rare.compareTo(b.rare);
    });
    //リストビューの高さを算出
    double listHeight = cardHeight * fishList.length + (8 * fishList.length);

    return Container(
      // decoration: BoxDecoration(
      //   border: Border.all(color: Colors.red),
      // ),
      width: cardWidth,
      height: listHeight,
      child: ListView.builder(
        padding: EdgeInsets.only(top: 0, bottom: 0),
        itemBuilder: (BuildContext context, int index) {
          return Column(
            children: [
              makeFishCard(
                  fish: fishList[index],
                  fishResult: widget.fishesResult.listFishResult.where(
                      (FishResultModel value) =>
                          value.fishId == fishList[index].id)),
            ],
          );
        },
        itemCount: fishList.length,
      ),
    );
  }

  //魚のリストアイテム
  Widget makeFishCard(
      {required FishModel fish,
      required Iterable<FishResultModel> fishResult}) {
    var borderColor = Colors.black;
    var boxColor;
    bool flgBorder = false;
    String name;
    var bold = false;
    var prob;

    switch (fish.type) {
      case enumFishType.blue:
        boxColor = Colors.lightBlue[100];
        break;
      case enumFishType.bream:
        boxColor = Colors.red[200];
        break;
      case enumFishType.bottom:
        boxColor = Colors.green[200];
        break;
      default:
        return Container();
    }

    if (fishResult.length > 0) {
      //釣果有り
      name = fish.name;
      bold = true;
    } else {
      //釣果なし
      name = "";
      for (var i = 0; i < fish.name.length; i++) name += "？";
      if (fish.id == widget.hitFishId) {
        flgBorder = true;
        borderColor = widget.pointerColor;
      }
    }
    //HIT率の整形
    prob = fish.prob * 100.0;
    if (prob > 1.0) prob = 1.0;

    return Transform(
        transform: Matrix4.skewX(-0.3),
        child:

Stack(children:[
            new Card(
              color: boxColor,
              shape: RoundedRectangleBorder(
                side: BorderSide(
                  width: (flgBorder ? widget.borderWidth : 1),
                  color: borderColor,
                ),
              ),
              child: Container(
                height: cardHeight,
                margin: EdgeInsets.only(left: 3, right: 3),
                child:
                    Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                  Text(
                    name,
                    textAlign: TextAlign.left,
                    style: TextStyle(color: Colors.black, fontSize: 12, fontWeight: (bold ? FontWeight.bold:FontWeight.normal)),
                  ),
                ]),
              ),
              //),
            ),
            CustomPaint(
              painter: new probPainter(prob: prob, flgRight: widget.flgRight),
            ),]),
        );
  }
}

class probPainter extends CustomPainter {
  const probPainter({
    required this.prob,
    required this.flgRight,
  });
  final double prob;
  final bool flgRight;

  @override
  void paint(Canvas canvas, Size size) {
    double x = 0;
    if (flgRight) {
      x = 100;
    } else {
      x = 0;
    }

    final paint = Paint()
      ..color = Colors.black
      ..strokeWidth = 10;
    canvas.drawLine(
        Offset(x, 24), Offset(x, 4), paint);

     paint
    ..color = Colors.yellow
    ..strokeWidth = 8;
    canvas.drawLine(
        Offset(x, 24), Offset(x, 2 + (22 - (22 * prob))), paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}