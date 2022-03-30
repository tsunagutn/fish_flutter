import 'package:fish_flutter/Model/CheckListTestModel.dart';
import 'package:fish_flutter/Model/FishModel.dart';
import 'package:fish_flutter/Model/FishResultsModel.dart';
import 'package:fish_flutter/widget/SoundManagerPool.dart';
import 'package:flutter/material.dart';

import 'RadarChart.dart';
import 'SliderPainter.dart';

class FishCardList extends StatefulWidget {
  @override
  const FishCardList({
    required this.fishsTable,
  });
//？？？引数追加 fishresulut、画面の幅高さ

  final List<FishModel> fishsTable;
  _FishCardListState createState() => _FishCardListState();
}

class _FishCardListState extends State<FishCardList>
    with SingleTickerProviderStateMixin {
  //List<FishModel> fishList = [];
  //late FishModel _showFishData;

  @override
  void initState() {
    super.initState();

    // widget.fishsTable.forEach((value) {
    //   fishList.add(value);
    // });
    // //棚が浅い順にソート
    // fishList.sort((a, b) => a.tanaMin.compareTo(b.tanaMin));

    // _showFishData = widget.fishsTable[0];
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        // width: double.maxFinite,
        // height: MediaQuery.of(context).size.height / 2,
        // margin: EdgeInsets.only(bottom: 10),
        width: 150,
        height: 300,
        child: ListView.builder(
          itemBuilder: (BuildContext context, int index) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                makeFishCard(
                  fish: widget.fishsTable[index],
                ),
              ],
            );
          },
          itemCount: widget.fishsTable.length,
        ));
  }

  //魚のリストアイテム
  Widget makeFishCard({required FishModel fish}) {
    Color backgroundColor;
    String image;
    String name;
    String depth;
    String resultCount;
    String resultMaxSize;
    double max = 0.0;

    name = fish.name;
    backgroundColor = Color(0xffffffe0);

    //debugPrint(widget.fishsTable.length.toString());
    return new Card(
      color: backgroundColor,
      child: new InkWell(
          splashColor: Colors.blue.withAlpha(30),
          //borderRadius: BorderRadius.circular(30),
          onTap: () async {
            //タップ時 ？？？なにするかまだ未定
          },
          child: Container(
              margin: const EdgeInsets.all(3.0),
              // width: 400,
              // height: 100,
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(
                      name,
                      style: TextStyle(
                          //fontSize: 32,
                          color: Colors.black),
                    ),
                  ]))),
    );
  }
}
