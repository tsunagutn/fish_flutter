import 'package:fish_flutter/Model/FishModel.dart';
import 'package:fish_flutter/Model/FishResultsModel.dart';
import 'package:fish_flutter/Model/LuresModel.dart';
import 'package:flutter/material.dart';

import '../Main.dart';
import 'BgmPlayer.dart';
import 'BookDialog.dart';

class goalDialog extends StatefulWidget {
  @override
  const goalDialog({
    required this.bgm,
    required this.dispSize,
    required this.fishResult,
    required this.maxWindLevel,
    required this.maxDepth,
  });

  final BgmPlayer bgm;
  final Size dispSize;
  final FishesResultModel fishResult;
  final double maxWindLevel;
  final double maxDepth;

  _goalDialogState createState() => _goalDialogState();
}

class _goalDialogState extends State<goalDialog> with TickerProviderStateMixin {
  late AnimationController _lightingAnimationController;
  late Animation<double> _lightingValue;

  late FishsModel FISH_TABLE;
  late List<int> lstFishCount;
  int crownCountSilver = 0;
  int crownCountGold = 0;
  double maxSize = 0.0;
  String maxSizeName = "なし";

  Future subBgmLoop(file) async {
    if (settings.flgBgm) {
      widget.bgm.playBgm(name: file);
    }
  }

  @override
  void initState() {
    super.initState();
    //最初の光
    _lightingAnimationController = AnimationController(
        duration: Duration(milliseconds: 2000), vsync: this);
    _lightingValue =
        Tween(begin: 1.5, end: 0.0).animate(_lightingAnimationController)
          ..addListener(() {
            setState(() {});
          });
    _lightingAnimationController.forward();
    //ジングル鳴らす
    //soundManagerPool.playSound('se/jingle01.mp3');
    //リザルト画面BCM再生
    subBgmLoop('bgm_book.mp3');

    //魚テーブルを初期化？？？本当はエリアで絞る
    FISH_TABLE = new FishsModel();
    lstFishCount = [];

    for (var i = 0; i < 5; i++) {
      //レア度毎のアイテムを作成 初期値0
      lstFishCount.add(0);
    }
    widget.fishResult.listFishResult.forEach((fish) {
      //魚種データを取得
      var fishdata = FISH_TABLE.getFishDetail(fish.fishId);
      //レア度毎の釣果数取得
      lstFishCount[fishdata.rare - 1] += 1;
      if (fish.size > 0.8 && fish.size > 0.95) {
        crownCountSilver++;
      } else if (fish.size > 0.95) {
        crownCountGold++;
      }
      //最大サイズデータ取得
      if (maxSize < fishdata.getSize(fish.size)) {
        maxSize = fishdata.getSize(fish.size);
        maxSizeName = fishdata.name;
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Opacity(
        //最初に画面全体を光らすために最初は透明にする
        opacity: _lightingValue.value <= 1.0 ? 1.0 : 0.0,
        child: Container(
            decoration: new BoxDecoration(
                image: new DecorationImage(
              image: new AssetImage("assets/images/fishback.jpg"),
              fit: BoxFit.cover,
            )),
            child: AlertDialog(
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
              // backgroundColor:
              //     clsColor._getColorFromHex('D1F6FF').withOpacity(0.7),

              content: Container(
                height: widget.dispSize.height,
                width: widget.dispSize.width,
                // decoration: new BoxDecoration(
                //     image: new DecorationImage(
                //   image: new AssetImage("assets/images/fishback.jpg"),
                //   fit: BoxFit.cover,
                // )),
                child: SingleChildScrollView(
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Column(children: [
                          Text(
                            "おつかれさまでした",
                            style: TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                              shadows: <Shadow>[
                                Shadow(
                                  color: Colors.black,
                                  offset: Offset(2.0, 2.0),
                                  blurRadius: 3.0,
                                ),
                              ],
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 20),
                            child: Text("釣った魚の数",
                                style: TextStyle(
                                  fontSize: 20,
                                )),
                          ),
                          Container(
                              width: double.maxFinite,
                              height: 150,
                              margin: EdgeInsets.only(bottom: 10),
                              child: Column(
                                children: [
                                  Expanded(
                                    child: ListView.builder(
                                      itemBuilder:
                                          (BuildContext context, int index) {
                                        return Container(
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              SizedBox(
                                                width: 100,
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  children: [
                                                    Stack(
                                                      children: [
                                                        for (var i = 0;
                                                            i < index + 1;
                                                            i++)
                                                          Container(
                                                            margin:
                                                                EdgeInsets.only(
                                                              left: i * 15,
                                                            ),
                                                            child: Icon(
                                                              Icons.star,
                                                              color:
                                                                  Colors.yellow,
                                                            ),
                                                          ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Text("：" +
                                                  lstFishCount[index]
                                                      .toString() +
                                                  "匹"),
                                            ],
                                          ),
                                        );
                                      },
                                      itemCount: lstFishCount.length,
                                    ),
                                  ),
                                  Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Text(
                                          "合計",
                                        ),
                                        Text(widget.fishResult.listFishResult
                                                .length
                                                .toString() +
                                            "匹"),
                                      ]),
                                ],
                              )),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              new Image(
                                image:
                                    AssetImage('assets/images/clown_gold.png'),
                                height: 24,
                                width: 24,
                              ),
                              Text(crownCountGold.toString() + "匹"),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              new Image(
                                image: AssetImage(
                                    'assets/images/clown_silver.png'),
                                height: 24,
                                width: 24,
                              ),
                              Text(crownCountSilver.toString() + "匹"),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text("最大サイズ："),
                              Text(maxSizeName +
                                  " " +
                                  maxSize.toStringAsFixed(1).toString() +
                                  " cm"),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text("最大風速："),
                              Text((10 * widget.maxWindLevel)
                                      .toStringAsFixed(1) +
                                  "m/s"),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text("最大水深："),
                              Text(((widget.maxDepth).round() / 10)
                                      .toStringAsFixed(1) +
                                  ' m'),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              ElevatedButton(
                                child: Text("図鑑を見る"),
                                onPressed: () async {
                                  // //図鑑モーダルの表示
                                  //soundManagerPool.playSound('se/book.mp3');
                                  var result = await showDialog<int>(
                                    context: context,
                                    barrierDismissible: false,
                                    builder: (_) {
                                      return BookDialog(
                                        fishsTable: FISH_TABLE,
                                        fishesResult: widget.fishResult,
                                        bgm: widget.bgm,
                                      );
                                    },
                                  );
                                },
                              ),
                              ElevatedButton(
                                child: Text("OK"),
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                              ),
                            ],
                          ),
                        ]),
                      ]),
                ),
              ),
            )),
      ),
      //最初に画面全体を光らす
      IgnorePointer(
        ignoring: (_lightingValue.value == 0.0),
        child: Container(
          decoration: BoxDecoration(
              color: Colors.white.withOpacity(_lightingValue.value > 1.0
                  ? 2.0 - _lightingValue.value
                  : _lightingValue.value)),
        ),
      ),
    ]);
  }
}

// builder: (BuildContext context) {
