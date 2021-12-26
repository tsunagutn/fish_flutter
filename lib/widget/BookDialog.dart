import 'package:fish_flutter/Model/CheckListTestModel.dart';
import 'package:fish_flutter/Model/FishModel.dart';
import 'package:fish_flutter/Model/FishResultsModel.dart';
import 'package:fish_flutter/widget/SoundManagerPool.dart';
import 'package:flutter/material.dart';

import 'RadarChart.dart';
import 'SliderPainter.dart';

class BookDialog extends StatefulWidget {
  @override
  const BookDialog({
    required this.fishsTable,
    required this.fishesResult,
    required this.soundManagerPool,
  });
  final FishsModel fishsTable;
  final FishesResultModel fishesResult;
  final SoundManagerPool soundManagerPool;
  _BookDialogState createState() => _BookDialogState();
}

class _BookDialogState extends State<BookDialog>
    with SingleTickerProviderStateMixin {
  List<FishModel> fishList = [];
  bool _showFishDetail = false;
  //bool _showFishDetail = true; //テスト用でtrue
  late FishModel _showFishData;

  @override
  void initState() {
    super.initState();
    widget.fishsTable.fishs.forEach((value) {
      fishList.add(value);
    });
    _showFishData = widget.fishsTable.fishs[0];
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      insetPadding: EdgeInsets.only(top: 40, bottom: 40, left: 20, right: 20),
      title: Text("おさかな図鑑"),
      content: Container(
        //height: MediaQuery.of(context).size.height / 2,
        child: Stack(children: [
          Column(children: <Widget>[
            Container(
                width: double.maxFinite,
                height: MediaQuery.of(context).size.height / 2,
                margin: EdgeInsets.only(bottom: 10),
                child: ListView.builder(
                  itemBuilder: (BuildContext context, int index) {
                    return Column(
                      children: [
                        makeFishTile(
                            fish: fishList[index],
                            fishResult: widget.fishesResult.listFishResult
                                .where((FishResultModel value) =>
                                    value.fishId == fishList[index].id)),
                      ],
                    );
                  },
                  itemCount: fishList.length,
                )),
            ElevatedButton.icon(
              icon: const Icon(
                Icons.close,
                color: Colors.white,
              ),
              label: const Text('閉じる'),
              style: ElevatedButton.styleFrom(
                primary: Colors.black.withOpacity(0.5),
                onPrimary: Colors.white,
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ]),
          //詳細のモーダル
          IgnorePointer(
              ignoring: !_showFishDetail,
              child: AnimatedOpacity(
                  opacity: _showFishDetail ? 1.0 : 0.0,
                  duration: Duration(microseconds: 200),
                  child: Container(
                    width: double.maxFinite,
                    decoration: BoxDecoration(
                        image: new DecorationImage(
                          image: new AssetImage("Assets/Images/fishback.jpg"),
                          fit: BoxFit.cover,
                        ),
                        border: Border.all(
                            color: Colors.black.withOpacity(1.0), width: 3)),
                    child: Container(
                      color: Colors.white.withOpacity(0.5),
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            //写真
                            Container(
                              margin: EdgeInsets.only(top: 20, bottom: 10),
                              child: new Image(
                                image: AssetImage(
                                    'Assets/Images/' + _showFishData.image),
                                width: 180,
                              ),
                            ),

                            //名前
                            Container(
                                margin: EdgeInsets.only(bottom: 10),
                                child: Text(_showFishData.name,
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20,
                                      shadows: <Shadow>[
                                        Shadow(
                                            offset: Offset(2.0, 4.0),
                                            blurRadius: 2.0,
                                            color:
                                                Colors.black.withOpacity(0.4))
                                      ],
                                    ))),
                            Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[]),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                new RadarChart(
                                  key: UniqueKey(),
                                  items: getFishRadarChartItem(_showFishData),
                                  radarColors: [Colors.green],
                                  fontColor: Colors.black,
                                ),
                                Container(
                                    width: 80,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "【生息域】",
                                          textAlign: TextAlign.left,
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        Text(
                                          (_showFishData.tanaMin / 10)
                                                  .floor()
                                                  .toString() +
                                              " ～ " +
                                              (_showFishData.tanaMax / 10)
                                                  .floor()
                                                  .toString() +
                                              "m",
                                        ),
                                        if (_showFishData.flgBottom)
                                          Container(
                                            margin: EdgeInsets.only(bottom: 5),
                                            padding: const EdgeInsets.only(
                                                left: 5, right: 5),
                                            decoration: BoxDecoration(
                                                border: Border.all(
                                                    color: Colors.red,
                                                    width: 3),
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(7.0)),
                                                color: Colors.yellow),
                                            child: Text("根魚",
                                                style: TextStyle(
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 14,
                                                )),
                                          ),
                                        Text(
                                          "【志向】",
                                          textAlign: TextAlign.left,
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        Container(
                                            margin: EdgeInsets.only(bottom: 3),
                                            child: Text("巻き",
                                                textAlign: TextAlign.left,
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 10,
                                                ))),
                                        CustomPaint(
                                          painter: new SliderPainter(
                                            height: 8,
                                            activeColor: Colors.orange,
                                            inactiveColor: Colors.white,
                                            value: _showFishData.hitMaki * 100,
                                            maxValue: 100,
                                            backRadius: 1.0,
                                            maxBackRadius: 1.0,
                                            flgShaKe: false,
                                            flgDispValue: true,
                                            flgDispMaxValue: false,
                                          ),
                                          child: Container(
                                            height: 10,
                                          ),
                                        ),
                                        Container(
                                            margin: EdgeInsets.only(bottom: 3),
                                            child: Text("シャクリ",
                                                textAlign: TextAlign.left,
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 10,
                                                ))),
                                        CustomPaint(
                                          painter: new SliderPainter(
                                            height: 8,
                                            activeColor: Colors.orange,
                                            inactiveColor: Colors.white,
                                            value: _showFishData.hitJerk * 100,
                                            maxValue: 100,
                                            backRadius: 1.0,
                                            maxBackRadius: 1.0,
                                            flgShaKe: false,
                                            flgDispValue: true,
                                            flgDispMaxValue: false,
                                          ),
                                          child: Container(
                                            height: 10,
                                          ),
                                        ),
                                        Container(
                                            margin: EdgeInsets.only(bottom: 3),
                                            child: Text("フォール",
                                                textAlign: TextAlign.left,
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 10,
                                                ))),
                                        CustomPaint(
                                          painter: new SliderPainter(
                                            height: 8,
                                            activeColor: Colors.orange,
                                            inactiveColor: Colors.white,
                                            value: _showFishData.hitFall * 100,
                                            maxValue: 100,
                                            backRadius: 1.0,
                                            maxBackRadius: 1.0,
                                            flgShaKe: false,
                                            flgDispValue: true,
                                            flgDispMaxValue: false,
                                          ),
                                          child: Container(
//                                  height: 500,
                                              ),
                                        ),
                                      ],
                                    )),
                              ],
                            ),
                            Container(
                                width: double.infinity,
                                margin: EdgeInsets.only(left: 10, bottom: 10),
                                child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Text(
                                        "【あなたの記録】",
                                        textAlign: TextAlign.left,
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          Container(
                                              child: Text(widget.fishesResult
                                                      .listFishResult
                                                      .where((FishResultModel
                                                              value) =>
                                                          value.fishId ==
                                                          _showFishData.id)
                                                      .length
                                                      .toString() +
                                                  "匹")),
                                          Row(
                                            children: [
                                              Text(_showFishData
                                                      .getSize(widget
                                                          .fishesResult
                                                          .getMinSize(
                                                              _showFishData.id))
                                                      .toStringAsFixed(1) +
                                                  " ～ " +
                                                  _showFishData
                                                      .getSize(widget
                                                          .fishesResult
                                                          .getMaxSize(
                                                              _showFishData.id))
                                                      .toStringAsFixed(1) +
                                                  "cm"),
                                              if (widget.fishesResult
                                                          .getMaxSize(
                                                              _showFishData
                                                                  .id) >
                                                      0.8 &&
                                                  widget.fishesResult
                                                          .getMaxSize(
                                                              _showFishData
                                                                  .id) <
                                                      0.95)
                                                Icon(Icons.star,
                                                    color: Colors.grey),
                                              if (widget.fishesResult
                                                      .getMaxSize(
                                                          _showFishData.id) >
                                                  0.95)
                                                Icon(
                                                  Icons.star,
                                                  color: Colors.yellow,
                                                ),
                                            ],
                                          ),
                                        ],
                                      )
                                    ])),
                            //閉じるボタン
                            Container(
                              margin: EdgeInsets.only(top: 20),
                              child: ElevatedButton.icon(
                                icon: const Icon(
                                  Icons.close,
                                  color: Colors.white,
                                ),
                                label: const Text('閉じる'),
                                style: ElevatedButton.styleFrom(
                                  primary: Colors.black.withOpacity(0.5),
                                  onPrimary: Colors.white,
                                ),
                                onPressed: () {
                                  widget.soundManagerPool
                                      .playSound('Se/book.mp3');

                                  setState(() {
                                    _showFishDetail = false;
                                  });
                                },
                              ),
                            ),
                          ]),
                    ),
                  ))),
        ]),
      ),
    );
  }

  //図鑑の一覧リスト
  Widget makeFishTile(
      {required FishModel fish,
      required Iterable<FishResultModel> fishResult}) {
    Color backgroundColor;
    String image;
    String name;
    String resultCount;
    String resultMaxSize;
    double max = 0.0;

    if (fishResult.length > 0) {
      //釣果有り
      backgroundColor = Colors.blue;
      image = fish.image;
      name = fish.name;
      resultCount = fishResult.length.toString() + "匹";
      fishResult.forEach((value) {
        if (max < value.size) {
          max = value.size;
        }
      });
      resultMaxSize = fish.getSize(max).toStringAsFixed(1).toString() + "cm";
    } else {
      //釣ったことがない
      backgroundColor = Colors.grey;
      image = "unknownfish.png";
      name = "?????";
      resultCount = "0匹";
      resultMaxSize = "";
    }
    return new Card(
      color: backgroundColor,
      child: new InkWell(
        onTap: () {
          if (fishResult.length > 0) {
            //釣果有り
            widget.soundManagerPool.playSound('Se/book.mp3');
            //カードタップで詳細画面を表示
            setState(() {
              _showFishData = fish;
              _showFishDetail = true;
            });
          }
        },
        child: new Center(
          child: new Padding(
            padding: const EdgeInsets.all(4.0),
            child: Row(
              children: [
                //画像
                Column(
                  children: [
                    new Image(
                      image: AssetImage('Assets/Images/' + image),
                      width: 50,
                      height: 50,
                    ),
                  ],
                ),
                Column(
                  children: [
                    Column(
                      children: [
                        Text(
                          name,
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text("釣った数：" + resultCount),
                        Row(
                          children: [
                            Text("最大サイズ：" + resultMaxSize),
                            if (max > 0.8 && max < 0.95)
                              Icon(Icons.star, color: Colors.grey),
                            if (max > 0.95)
                              Icon(
                                Icons.star,
                                color: Colors.yellow,
                              ),
                          ],
                        )
                      ],
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  List<RadarChartItemModel> getFishRadarChartItem(FishModel fish) {
    List<RadarChartItemModel> ret = [];
    var lvHp = -1.0;
    var lvAddMax = -1.0;
    var lvAbare = -1.0;
    var lv = fish.getPrmLevels();
    //HPのレベル取得
    for (var idx = 1; idx < lv['hp']!.length; idx++) {
      if (fish.hp < lv['hp']![idx]) {
        lvHp = idx / lv['hp']!.length;
        break;
      }
    }
    if (lvHp == -1.0) lvHp = 1.0;
    //ﾊﾟﾜｰのレベル取得
    for (var idx = 1; idx < lv['addMax']!.length; idx++) {
      if (fish.addMax < lv['addMax']![idx]) {
        lvAddMax = idx / lv['addMax']!.length;
        break;
      }
    }
    if (lvAddMax == -1.0) lvAddMax = 1.0;
    //暴れのレベル取得
    for (var idx = 1; idx < lv['abare']!.length; idx++) {
      if (fish.addMax + fish.addMin < lv['abare']![idx]) {
        lvAbare = idx / lv['abare']!.length;
        break;
      }
    }
    if (lvAbare == -1.0) lvAbare = 1.0;

    ret.add(new RadarChartItemModel(itemName: 'HP', value: lvHp));
    ret.add(new RadarChartItemModel(itemName: '引強', value: lvAddMax));
    ret.add(new RadarChartItemModel(itemName: '暴れ', value: lvAbare));
    return ret;
  }
}
