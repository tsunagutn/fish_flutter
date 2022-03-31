import 'package:fish_flutter/Model/CheckListTestModel.dart';
import 'package:fish_flutter/Model/FishModel.dart';
import 'package:fish_flutter/Model/FishResultsModel.dart';
import 'package:fish_flutter/View/Fishing.dart';
import 'package:fish_flutter/widget/SoundManagerPool.dart';
import 'package:flutter/material.dart';

import 'RadarChart.dart';
import 'SliderPainter.dart';

class FishCardList extends StatefulWidget {
  @override
  const FishCardList({
    required this.fishsTable,
    required this.fishesResult,
    required this.width,
    required this.height,
    required this.hitFishId,
    required this.pointerColor,
    required this.borderWidth,
  });

  final List<FishModel> fishsTable;
  final FishesResultModel fishesResult;
  final double width; //表示エリアの幅
  final double height; //表示エリアの高さ
  final int hitFishId; //HITorアタリ中の魚ID 非HIT中は-1
  final Color pointerColor; //光点の色
  final double borderWidth; //枠線の幅
  _FishCardListState createState() => _FishCardListState();
}

class _FishCardListState extends State<FishCardList>
    with SingleTickerProviderStateMixin {
  List<FishModel> fishList = [];

  // late AnimationController animController;
  // late Animation<double> animValue;
  @override
  void initState() {
    super.initState();
    // animController =
    //     AnimationController(vsync: this, duration: const Duration(seconds: 2));
    // animValue = Tween(begin: 0.0, end: 1.0).animate(animController)
    //   ..addListener(() {
    //     setState(() {});
    //   });
    // animController.repeat(); // アニメーションをスタート
  }

  @override
  void dispose() {
    //animController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    fishList = [];
    widget.fishsTable.forEach((value) {
      fishList.add(value);
    });
    //リストソート レア度→棚
    fishList.sort((a, b) {
      int result = a.rare.compareTo(b.rare);
      if (result != 0) return result;
      return a.tanaMax.compareTo(b.tanaMax);
    });

    return Container(
      decoration: BoxDecoration(
          //border: Border.all(color: Colors.red),
          ),
      width: widget.width,
      height: widget.height,
      child: ListView.builder(
        padding: EdgeInsets.zero,
        itemBuilder: (BuildContext context, int index) {
          return Column(
            //mainAxisAlignment: MainAxisAlignment.start,
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
    Color backgroundColor;
    bool flgBorder = false;
    String name;

    if (fishResult.length > 0) {
      //釣果有り
      name = fish.name;
      backgroundColor = Color(0xffffffe0);
    } else {
      //釣果なし
      name = "";
      for (var i = 0; i < fish.name.length; i++) name += "？";
      if (fish.id == widget.hitFishId) {
        flgBorder = true;
        backgroundColor = Color(0xffffffff);
      } else {
        backgroundColor = Color(0xffc0c0c0).withOpacity(0.8);
      }
    }

    return new Card(
      color: backgroundColor,
      shape: RoundedRectangleBorder(
        side: BorderSide(
          width: (flgBorder ? widget.borderWidth : 0),
          color: widget.pointerColor,
        ),
      ),
      child: new InkWell(
          splashColor: Colors.blue.withAlpha(30),
          //borderRadius: BorderRadius.circular(30),
          onTap: () async {
            //タップ時 ？？？なにするかまだ未定
            //？？？ヒント出す機能
          },
          child: Container(
              margin: EdgeInsets.only(bottom: 3),
              child: Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                Text(
                  name,
                  textAlign: TextAlign.left,
                  style: TextStyle(color: Colors.black),
                ),
              ]))),
    );
  }
}
