import 'package:fish_flutter/Model/FishModel.dart';
import 'package:fish_flutter/Model/LuresModel.dart';
import 'package:fish_flutter/TypeAdapter/typLureData.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

import '../Main.dart';
import '../TypeAdapter/typFishResult.dart';
import '../TypeAdapter/typGameData.dart';
import 'lureLvUpDialog.dart';
import 'RadarChart.dart';

class fishGetDialog extends StatefulWidget {
  @override
  const fishGetDialog({
    required this.dispSize,
    required this.fish,
    required this.fishSize,
    required this.depth,
  });
  final Size dispSize;
  final FishModel fish;
  final double fishSize;
  final double depth;

  _fishGetDialogState createState() => _fishGetDialogState();
}

class _fishGetDialogState extends State<fishGetDialog>
    with TickerProviderStateMixin {
  double fishCm = 0.0;
  late AnimationController _lightingAnimationController;
  late Animation<double> _lightingValue;
  late AnimationController _rColorAnimationController;
  late Animation<double> _rColorValue;
  late AnimationController _gColorAnimationController;
  late Animation<double> _gColorValue;
  late AnimationController _bColorAnimationController;
  late Animation<double> _bColorValue;

  String strLevel = '';
  var colorLevel;
  //String strLureLevel = "";
  //var colorLureLevel;

  static const Map<int, String> RARE_MESSAGE = {
    1: 'あなたはうれしい',
    2: 'あなたは喜びました',
    3: 'あなたは幸せになった',
    4: 'あなたは満足を得ました',
    5: 'あなたは感動しました',
  };

  late typGameData gameData;
  late int point;
  bool flgNew = false;

  @override
  void initState() {
    final gameDataBox = Hive.box(gamedataBoxName);
    gameData = gameDataBox.get(gamedataKeyName);

    fishCm = widget.fish.getSize(widget.fishSize);
    //最初の光
    _lightingAnimationController = AnimationController(
        duration: Duration(milliseconds: 2000), vsync: this);
    _lightingValue =
        Tween(begin: 1.5, end: 0.0).animate(_lightingAnimationController)
          ..addListener(() {
            setState(() {});
          });
    _lightingAnimationController.forward();
    //赤
    _rColorAnimationController =
        AnimationController(duration: Duration(milliseconds: 224), vsync: this);
    _rColorValue =
        Tween(begin: 0.0, end: 1.0).animate(_rColorAnimationController)
          ..addListener(() {
            setState(() {});
          });
    _rColorAnimationController.repeat(reverse: true);
    //緑
    _gColorAnimationController =
        AnimationController(duration: Duration(milliseconds: 203), vsync: this);
    _gColorValue =
        Tween(begin: 0.0, end: 1.0).animate(_gColorAnimationController)
          ..addListener(() {
            setState(() {});
          });
    _gColorAnimationController.repeat(reverse: true);
    //青
    _bColorAnimationController = AnimationController(
        duration: Duration(milliseconds: 1181), vsync: this);
    _bColorValue =
        Tween(begin: 0.0, end: 1.0).animate(_bColorAnimationController)
          ..addListener(() {
            setState(() {});
          });
    _bColorAnimationController.repeat(reverse: true);

    //初釣果判定
    var flgNew = true;
    gameData.fishResults.forEach((val) {
      if (val.fishId == widget.fish.id &&
          val.resultKbn == enumResult.success.index) {
        flgNew = false;
        return;
      }
    });

    //ジングル鳴らす
    soundManagerPool.playSound('se/jingle01.mp3');

    //獲得ポイント
    point = widget.fish.point + (widget.fish.point * widget.fishSize).floor();
    //ポイントを加算
    gameData.point += point;

    //釣果データを追加
    var fishResultBox = Hive.box(fishResultBoxName);
    typFishResult fishResult = typFishResult(
        fishId: widget.fish.id,
        size: widget.fishSize,
        depth: widget.depth,
        maxDepth: gameData.maxDepth,
        resultKbn: enumResult.success.index);
    //FishResultに登録
    fishResultBox.add(fishResult);
    //fishResultBox.put(DateTime.now.toString(), fishResult);
    //GameDataに登録
    gameData.fishResults.add(fishResult);

    //タックルの成長
    switch (widget.fish.type) {
      case enumFishType.blue:
        gameData.maxTension += (point / 1);
        strLevel = "最大テンションが成長しました";
        colorLevel = Colors.indigo[500];
        break;
      case enumFishType.bream:
        gameData.maxSpeed += (point / 10);
        strLevel = "巻き速度が成長しました";
        colorLevel = Colors.red[200];
        break;
      case enumFishType.bottom:
        gameData.maxLineHp += (point / 1);
        strLevel = "ライン強さが成長しました";
        colorLevel = Colors.green[200];
        break;
    }

    //ゲームデータをセーブ
    gameData.save();

    super.initState();
  }

  @override
  void dispose() {
    _lightingAnimationController.dispose();
    _rColorAnimationController.dispose();
    _gColorAnimationController.dispose();
    _bColorAnimationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    int r = (255 * _rColorValue.value).floor();
    int g = (255 * _gColorValue.value).floor();
    int b = (255 * _bColorValue.value).floor();

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
              title: Text(RARE_MESSAGE[widget.fish.rare]!,
                  style: TextStyle(
                    //fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: Color.fromRGBO(r, g, b, 1.0),
                    shadows: <Shadow>[
                      Shadow(
                          offset: Offset((4.0 * _rColorValue.value), 10.0),
                          blurRadius: 2.0,
                          color: Colors.black.withOpacity(0.3))
                    ],
                  )),
              //insetPadding: EdgeInsets.all(8),
              insetPadding:
                  EdgeInsets.only(top: 20, bottom: 20, left: 8, right: 8),
              content: Container(
                  height: widget.dispSize.height,
                  width: widget.dispSize.width,
                  // decoration: new BoxDecoration(
                  //     image: new DecorationImage(
                  //   image: new AssetImage("assets/images/fishback.jpg"),
                  //   fit: BoxFit.cover,
                  // )),
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Column(
                          children: [
                            new Image(
                              image: AssetImage(
                                  'assets/images/' + widget.fish.image),
                              width: 250,
                              fit: BoxFit.contain,
                            ),
                            Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  if (flgNew)
                                    Container(
                                      margin: EdgeInsets.only(right: 3, top: 5),
                                      padding: const EdgeInsets.all(2.0),
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                            color: Colors.black, width: 1),
                                        color: Color.fromRGBO(r, g, b, 1.0),
                                      ),
                                      child: Text("NEW!",
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 10,
                                          )),
                                    ),
                                  Container(
                                    margin: EdgeInsets.only(top: 5, right: 5),
                                    child: widget.fish
                                        .getNameContainer(widget.fish.type, 14),
                                  ),
                                  Text(widget.fish.name +
                                      "　" +
                                      widget.fish
                                          .getSize(widget.fishSize)
                                          .toStringAsFixed(1) +
                                      "cm"),
                                  if (widget.fishSize > 0.8 &&
                                      widget.fishSize < 0.95)
                                    //Icon(Icons.star, color: Colors.teal),
                                    new Image(
                                      image: AssetImage(
                                          'assets/images/clown_silver.png'),
                                      height: 24,
                                      width: 24,
                                    ),
                                  if (widget.fishSize > 0.95)
                                    // Icon(
                                    //   Icons.star,
                                    //   color: Colors.yellow,
                                    // ),
                                    new Image(
                                      image: AssetImage(
                                          'assets/images/clown_gold.png'),
                                      height: 24,
                                      width: 24,
                                    ),
                                ]),
                            Container(
                              margin: EdgeInsets.only(top: 5, bottom: 5),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  for (var i = 0; i < widget.fish.rare; i++)
                                    Icon(
                                      Icons.star,
                                      color: Colors.yellow,
                                    ),
                                ],
                              ),
                            ),
                            Text("あなたは" + point.toString() + 'ポイントを得ました'),
                            Text(
                              strLevel,
                              style: TextStyle(
                                color: colorLevel,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            // Text(
                            //   strLureLevel,
                            //   style: TextStyle(
                            //     color: colorLureLevel,
                            //     fontWeight: FontWeight.bold,
                            //   ),
                            // ),
                            if (flgNew)
                              Container(
                                margin: EdgeInsets.only(top: 10),
                                child: Text("おさかな図鑑に登録します",
                                    style: TextStyle(color: Colors.red)),
                              ),
                            // Container(
                            //   margin: EdgeInsets.only(top: 10),
                            //   child: Text(widget.fish.text),
                            // ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            ElevatedButton(
                              child: Text("OK"),
                              onPressed: () async {
                                //ルアー成長判定
                                var useLureData = gameData.getUseLure();
                                useLureData.totalExp += point;
                                int nowLv = useLureData.lv;
                                int newLv = gameData.getLv();
                                if (nowLv < newLv) {
                                  //成長前のデータ取得
                                  var nowLvData = RadarChartCommon.getLureRadarChartItem(gameData.getUseLure());
                                  //レベルアップ
                                  var weightMsg = gameData.lureLvUp();
                                  gameData.save();
                                  //成長後のデータ取得
                                  var newLvData = RadarChartCommon.getLureRadarChartItem(gameData.getUseLure());

                                  var result = await showDialog<int>(
                                    context: context,
                                    barrierDismissible: false,
                                    builder: (_) {
                                      return Stack(
                                        children: [
                                          //釣りあげダイアログ
                                          lureLvUpDialog(
                                            lureIdx: gameData.useLureIdx,
                                            radarDatas: [newLvData, nowLvData],
                                            nowLv: nowLv,
                                            newLv: newLv,
                                            dispSize: widget.dispSize,
                                            weightMsg: weightMsg,
                                          ),
                                        ],
                                      );
                                    },
                                  );
                                }

                                Navigator.pop(context);
                              },
                            ),
                          ],
                        ),
                      ])),
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
