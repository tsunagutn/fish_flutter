
import 'package:fish_flutter/Model/FishModel.dart';
import 'package:fish_flutter/Model/LuresModel.dart';
import 'package:fish_flutter/TypeAdapter/typLureData.dart';
import 'package:fish_flutter/widget/tackleIcon.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

import '../Main.dart';
import '../TypeAdapter/typFishResult.dart';
import '../TypeAdapter/typGameData.dart';
import 'SliderPainter.dart';
import 'lureLvUpDialog.dart';
import 'RadarChart.dart';
import 'package:fish_flutter/Class/clsColor.dart';

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
  String strLevel2 = '';
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
  late double oldExp;
  late double nowExp;
  late double newExp;
  double prevExp = 0;

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
        strLevel = "最大テンションが成長しました";
        strLevel2 = gameData.maxTension.toInt().toString() +
            " → " + (gameData.maxTension + point).toInt().toString();
        gameData.maxTension += (point / 1);
        colorLevel = Colors.indigo[500];
        break;
      case enumFishType.bream:
        strLevel = "巻き速度が成長しました";
        strLevel2 = gameData.maxSpeed.toInt().toString() +
            " → " + (gameData.maxSpeed + (point / 10)).toInt().toString();
        gameData.maxSpeed += (point / 10);
        colorLevel = Colors.red[200];
        break;
      case enumFishType.bottom:
        strLevel = "ライン強さが成長しました";
        strLevel2 = gameData.maxLineHp.toInt().toString() +
            " → " + (gameData.maxLineHp + (point / 1)).toInt().toString();
        gameData.maxLineHp += (point / 1);
        colorLevel = Colors.green[200];
        break;
    }

    //ルアー 現EXP
    var useLureData = gameData.getUseLure();
    nowExp = useLureData.totalExp + point;
    int Lv = 1;
    double nextExp = typGameData.BASIC_EXP;
    double divExp = nextExp;
    //最大レベルまでループ
    while (Lv < typGameData.MAXLV) {
      if (useLureData.totalExp >= divExp) {
        Lv++;
      } else {
        //現Lv判明時にループ抜け
        break;
      }
      //前LvのEXPを記憶
      prevExp = nextExp;
      //次Lvに必要なEXP
      nextExp = nextExp * typGameData.NEXT_DIV;
      divExp += nextExp;
    }
    //ルアー 次のレベルまで
    oldExp = useLureData.totalExp - prevExp;
    newExp = divExp - prevExp;
    nowExp = nowExp - prevExp;

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
                            Text(
                              strLevel2,
                              style: TextStyle(
                                color: colorLevel,
                                //fontWeight: FontWeight.bold,
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
                            Container(margin: EdgeInsets.only(top:10, left: 10, right: 10),
                            child: Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly
                                ,crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                tackleIcon(
                                  tackleIconSize: 40.0,
                                  lure: gameData.getUseLure(),
                                  flgSelect: false,
                                  opacity:1.0,
                                ),
                                Container(
                                  width: widget.dispSize.width / 2,
                                  child:
                                Column(
                                  children: [
                                    Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Container(child:
                                    Text("Lv " + gameData.getUseLure().lv.toString()),),
                                          Container(child: Text("次まで " + ((newExp - nowExp) < 0 ? 0: (newExp - nowExp)).toInt().toString()),),
                                        ]),
                                  Container(
                                    width: widget.dispSize.width / 2,
                                    child:
                                    CustomPaint(
                                    painter: new SliderPainter(
                                      height: 12,
                                      activeColor: clsColor.getColorFromHex("ABE8C9"),
                                      inactiveColor: Colors.white,
                                      value: oldExp,
                                      maxValue: newExp,
                                      backRadius: 1.0,
                                      maxBackRadius: 1.0,
                                      flgShaKe: false,
                                      flgDispValue: false,
                                      flgDispMaxValue: false,
                                      value2: (nowExp > newExp) ? newExp:nowExp,
                                      value2Color: clsColor.getColorFromHex("5DA983")
                                          .withOpacity(0.2),
                                    ),),),

                                  ],),),
                              ]),
                            ),
                          ]),
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
