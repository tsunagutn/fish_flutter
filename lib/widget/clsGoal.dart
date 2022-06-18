import 'package:fish_flutter/Model/FishModel.dart';
import 'package:fish_flutter/Model/FishResultsModel.dart';
import 'package:fish_flutter/Model/LuresModel.dart';
import 'package:fish_flutter/TypeAdapter/typFishResult.dart';
import 'package:fish_flutter/TypeAdapter/typHistory.dart';
import 'package:fish_flutter/TypeAdapter/typResults.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

import '../Main.dart';
import '../Model/relultAnimeModel.dart';
import '../TypeAdapter/typGameData.dart';
import 'BgmPlayer.dart';

class clsGoal extends StatefulWidget {
  @override
  const clsGoal({
    required this.isHistory,
    required this.keyName,
  });

  final bool isHistory;
  final String keyName;

  _clsGoalState createState() => _clsGoalState();
}

enum enumResultAnime {
  fishResultTitle, //釣った魚の数 見出し
  fishResultHeader, //釣った魚の数 ヘッダ
  fishResultRare, //釣った魚の数 レア毎
  fishResultTotal, //釣った魚の数 合計
  fishResultGold, //金数
  fishResultSilver, //銀数
  fishResultMax, //最大サイズ
  maxWind, //最大風速
  maxDepth, //最大水深
  point, //ポイント
  last, //閉じるボタン
}

class _clsGoalState extends State<clsGoal> with TickerProviderStateMixin {
  late AnimationController _lightingAnimationController;
  late Animation<double> _lightingValue;
  late AnimationController _dispController;
  late Animation<double> _dispValue;

  late FishsModel FISH_TABLE;
  late List<List<int>> lstFishCount; //fishtype,レア度毎の釣果数
  int fishCnt = 0;
  int bareCnt = 0;
  int cutCnt = 0;
  int crownCountSilver = 0;
  int crownCountGold = 0;
  double maxSize = 0.0;
  String maxSizeName = "なし";

  int animeSpan = 1000;
  int animeCount = 4;

  int animeCnt = 0;
  //表示アニメーションの設定
  late Map<enumResultAnime, relultAnimeModel> anime;

  final Map<int, Map<String, int>> mapAnime = {};

  late typGameData gameData;

  @override
  void initState() {
    super.initState();
    final gameDataBox = Hive.box(gamedataBoxName);
    gameData = gameDataBox.get(widget.keyName);

    var duration = 4000;
    if (widget.isHistory) {
      duration = 0;
    }

    //アニメーション管理
    anime = new Map<enumResultAnime, relultAnimeModel>();
    anime[enumResultAnime.fishResultTitle] = new relultAnimeModel(span: 1000);
    anime[enumResultAnime.fishResultHeader] = new relultAnimeModel(span: 1000);
    anime[enumResultAnime.fishResultRare] = new relultAnimeModel(span: 1000);
    anime[enumResultAnime.fishResultTotal] = new relultAnimeModel(span: 2000);
    anime[enumResultAnime.fishResultGold] = new relultAnimeModel(span: 1000);
    anime[enumResultAnime.fishResultSilver] = new relultAnimeModel(span: 1000);
    anime[enumResultAnime.fishResultMax] = new relultAnimeModel(span: 2000);
    anime[enumResultAnime.maxWind] = new relultAnimeModel(span: 1000);
    anime[enumResultAnime.maxDepth] = new relultAnimeModel(span: 1000);
    anime[enumResultAnime.point] = new relultAnimeModel(span: 2000);
    anime[enumResultAnime.last] = new relultAnimeModel(span: 10);

    _dispController = AnimationController(
        duration: Duration(
            milliseconds: anime[enumResultAnime.fishResultTitle]!.span),
        vsync: this);
    _dispValue = Tween(begin: 0.0, end: 1.0).animate(_dispController)
      ..addListener(() {
        setState(() {});
      });
    //項目表示フェード用のアニメーションスタート
    _dispController.forward();

    if (widget.isHistory) {
      //履歴画面から来た場合はアニメーションしない
      anime.forEach((key, value) {
        value.state = enumAnimeState.end;
      });
    } else {
      //アニメ実行中
      anime[enumResultAnime.fishResultTitle]!.state = enumAnimeState.doing;
      _dispController.addStatusListener((status) {
        //アニメーション終了後かの確認
        if (status == AnimationStatus.completed) {
          _dispController.reset();
          anime[enumResultAnime.values[animeCnt]]!.state = enumAnimeState.end;
          animeCnt++;
          if (animeCnt < enumResultAnime.values.length) {
            //次のアニメがあればスタート
            _dispController.duration = Duration(
                milliseconds: anime[enumResultAnime.values[animeCnt]]!.span);
            //アニメ実行中
            anime[enumResultAnime.values[animeCnt]]!.state =
                enumAnimeState.doing;
            _dispController.forward();
          }
        }
      });
    }

    //魚テーブルを初期化
    FISH_TABLE = new FishsModel();
    lstFishCount = [];

    for (var i = 0; i < 5; i++) {
      //レア度、fishtype3種毎のアイテムを作成 初期値0
      lstFishCount.add([0, 0, 0]);
    }
    gameData.fishResults.forEach((typFishResult result) {
      //魚種データを取得
      var fishdata = FISH_TABLE.getFishDetail(result.fishId);

      if (result.resultKbn == enumResult.success.index) {
        //釣れた場合
        //レア度、fishtype毎の釣果数取得
        lstFishCount[fishdata.rare - 1][fishdata.type.index] += 1;
        if (result.size > 0.8 && result.size < 0.95) {
          crownCountSilver++;
        } else if (result.size > 0.95) {
          crownCountGold++;
        }
        //最大サイズデータ取得
        if (maxSize < fishdata.getSize(result.size)) {
          maxSize = fishdata.getSize(result.size);
          maxSizeName = fishdata.name;
        }
      } else if (result.resultKbn == enumResult.bare.index) {
        //バレた場合
        bareCnt++;
      } else if (result.resultKbn == enumResult.cut.index) {
        //切られた場合
        cutCnt++;
      } else {}
    });
  }

  @override
  void dispose() {
    _lightingAnimationController.dispose();
    _dispController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(child: GestureDetector(
        onTap: () {
          //タップでアニメーションをスキップ
          if (_dispController.isAnimating) {
            _dispController.value = 1.0;
          }
        },
        child:Container(
                    height: MediaQuery.of(context).size.height,
                    width: MediaQuery.of(context).size.width,
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
                              Opacity(
                                opacity: (anime[enumResultAnime
                                    .fishResultTitle]!
                                    .state ==
                                    enumAnimeState.doing
                                    ? _dispValue.value
                                    : anime[enumResultAnime.fishResultTitle]!
                                    .state ==
                                    enumAnimeState.end
                                    ? 1.0
                                    : 0.0),
                                child: Container(
                                  margin: EdgeInsets.only(top: 20, bottom: 10),
                                  child: Text("釣った魚の数",
                                      style: TextStyle(
                                        fontSize: 20,
                                      )),
                                ),
                              ),
                              Opacity(
                                opacity: (anime[enumResultAnime
                                    .fishResultHeader]!
                                    .state ==
                                    enumAnimeState.doing
                                    ? _dispValue.value
                                    : anime[enumResultAnime.fishResultHeader]!
                                    .state ==
                                    enumAnimeState.end
                                    ? 1.0
                                    : 0.0),
                                child: Container(
                                  width: double.maxFinite,
                                  child: Row(
                                      mainAxisAlignment:
                                      MainAxisAlignment.center,
                                      children: [
                                        Container(
                                          width: 100,
                                          margin: EdgeInsets.only(right: 4),
                                          child: Center(
                                            child: Text("レア度"),
                                          ),
                                        ),
                                        Container(
                                          width: 46,
                                          margin: EdgeInsets.only(right: 4),
                                          child: FISH_TABLE.fishs[0]
                                              .getNameContainer(
                                              enumFishType.blue, 14),
                                        ),
                                        Container(
                                          width: 46,
                                          margin: EdgeInsets.only(right: 4),
                                          child: FISH_TABLE.fishs[0]
                                              .getNameContainer(
                                              enumFishType.bream, 14),
                                        ),
                                        Container(
                                          width: 46,
                                          margin: EdgeInsets.only(right: 4),
                                          child: FISH_TABLE.fishs[0]
                                              .getNameContainer(
                                              enumFishType.bottom, 14),
                                        ),
                                        Container(
                                          width: 46,
                                          margin: EdgeInsets.only(right: 4),
                                          child: Center(
                                            child: Text("計"),
                                          ),
                                        ),
                                      ]),
                                ),
                              ),
                              Container(
                                  width: double.maxFinite,
                                  height: 150,
                                  margin: EdgeInsets.only(bottom: 10),
                                  child: Column(
                                    children: [
                                      Expanded(
                                        child: Opacity(
                                          opacity: (anime[enumResultAnime
                                              .fishResultRare]!
                                              .state ==
                                              enumAnimeState.doing
                                              ? _dispValue.value
                                              : anime[enumResultAnime
                                              .fishResultRare]!
                                              .state ==
                                              enumAnimeState.end
                                              ? 1.0
                                              : 0.0),
                                          child: ListView.builder(
                                            itemBuilder: (BuildContext context,
                                                int index) {
                                              return Container(
                                                child: Row(
                                                  mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                                  children: [
                                                    Container(
                                                      width: 100,
                                                      margin: EdgeInsets.only(
                                                          right: 4),
                                                      child: Row(
                                                        mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .start,
                                                        children: [
                                                          Stack(
                                                            children: [
                                                              for (var i = 0;
                                                              i < index + 1;
                                                              i++)
                                                                Container(
                                                                  margin:
                                                                  EdgeInsets
                                                                      .only(
                                                                    left:
                                                                    i * 15,
                                                                  ),
                                                                  child: Icon(
                                                                    Icons.star,
                                                                    color: Colors
                                                                        .yellow,
                                                                  ),
                                                                ),
                                                            ],
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    //青魚数
                                                    Container(
                                                      width: 50,
                                                      margin: EdgeInsets.only(
                                                          right: 4),
                                                      child: Center(
                                                        child: Text(
                                                            lstFishCount[index][
                                                            enumFishType
                                                                .blue
                                                                .index]
                                                                .toString()),
                                                      ),
                                                    ),
                                                    //赤魚数
                                                    Container(
                                                      width: 50,
                                                      margin: EdgeInsets.only(
                                                          right: 4),
                                                      child: Center(
                                                        child: Text(
                                                            lstFishCount[index][
                                                            enumFishType
                                                                .bream
                                                                .index]
                                                                .toString()),
                                                      ),
                                                    ),
                                                    //底魚数
                                                    Container(
                                                      width: 50,
                                                      margin: EdgeInsets.only(
                                                          right: 4),
                                                      child: Center(
                                                        child: Text(
                                                            lstFishCount[index][
                                                            enumFishType
                                                                .bottom
                                                                .index]
                                                                .toString()),
                                                      ),
                                                    ),
                                                    //計
                                                    Container(
                                                      width: 50,
                                                      margin: EdgeInsets.only(
                                                          right: 4),
                                                      child: Center(
                                                        child: Text((lstFishCount[
                                                        index][
                                                        enumFishType
                                                            .blue
                                                            .index] +
                                                            lstFishCount[
                                                            index][
                                                            enumFishType
                                                                .bream
                                                                .index] +
                                                            lstFishCount[
                                                            index][
                                                            enumFishType
                                                                .bottom
                                                                .index])
                                                            .toString()),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              );
                                            },
                                            itemCount: lstFishCount.length,
                                          ),
                                        ),
                                      ),
                                      Opacity(
                                        opacity: (anime[enumResultAnime
                                            .fishResultTotal]!
                                            .state ==
                                            enumAnimeState.doing
                                            ? _dispValue.value
                                            : anime[enumResultAnime
                                            .fishResultTotal]!
                                            .state ==
                                            enumAnimeState.end
                                            ? 1.0
                                            : 0.0),
                                        child: Row(
                                            mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                            children: [
                                              Text(
                                                "合計",
                                              ),
                                              Text(gameData.fishResults.length
                                                  .toString() +
                                                  "匹"),
                                              if (!widget.isHistory)
                                                ElevatedButton(
                                                  child: Text("図鑑"),
                                                  onPressed: () async {
                                                    if (anime[enumResultAnime
                                                        .fishResultTotal]!
                                                        .state !=
                                                        enumAnimeState.end) {
                                                      return;
                                                    }
                                                    // //図鑑画面の表示
                                                    Navigator.pushNamed(context, "/book");
                                                  },
                                                ),
                                            ]),
                                      ),
                                    ],
                                  )),
                              Opacity(
                                opacity: (anime[enumResultAnime.fishResultGold]!
                                    .state ==
                                    enumAnimeState.doing
                                    ? _dispValue.value
                                    : anime[enumResultAnime.fishResultGold]!
                                    .state ==
                                    enumAnimeState.end
                                    ? 1.0
                                    : 0.0),
                                child: Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceEvenly,
                                  children: [
                                    new Image(
                                      image: AssetImage(
                                          'assets/images/clown_gold.png'),
                                      height: 24,
                                      width: 24,
                                    ),
                                    Text(crownCountGold.toString() + "匹"),
                                  ],
                                ),
                              ),
                              Opacity(
                                opacity: (anime[enumResultAnime
                                    .fishResultSilver]!
                                    .state ==
                                    enumAnimeState.doing
                                    ? _dispValue.value
                                    : anime[enumResultAnime.fishResultSilver]!
                                    .state ==
                                    enumAnimeState.end
                                    ? 1.0
                                    : 0.0),
                                child: Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceEvenly,
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
                              ),
                              Opacity(
                                opacity: (anime[enumResultAnime.fishResultMax]!
                                    .state ==
                                    enumAnimeState.doing
                                    ? _dispValue.value
                                    : anime[enumResultAnime.fishResultMax]!
                                    .state ==
                                    enumAnimeState.end
                                    ? 1.0
                                    : 0.0),
                                child: Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Text("最大サイズ："),
                                    Text(maxSizeName +
                                        " " +
                                        maxSize.toStringAsFixed(1).toString() +
                                        " cm"),
                                  ],
                                ),
                              ),
                              Opacity(
                                opacity: (anime[enumResultAnime.maxWind]!
                                    .state ==
                                    enumAnimeState.doing
                                    ? _dispValue.value
                                    : anime[enumResultAnime.maxWind]!.state ==
                                    enumAnimeState.end
                                    ? 1.0
                                    : 0.0),
                                child: Container(
                                  margin: EdgeInsets.only(top: 20),
                                  child: Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Text("最大風速："),
                                      Text((10 * gameData.maxWindLevel)
                                          .toStringAsFixed(1) +
                                          "m/s"),
                                    ],
                                  ),
                                ),
                              ),
                              Opacity(
                                opacity: (anime[enumResultAnime.maxDepth]!
                                    .state ==
                                    enumAnimeState.doing
                                    ? _dispValue.value
                                    : anime[enumResultAnime.maxDepth]!.state ==
                                    enumAnimeState.end
                                    ? 1.0
                                    : 0.0),
                                child: Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Text("最大水深："),
                                    Text(((gameData.maxDepth).round() / 10)
                                        .toStringAsFixed(1) +
                                        ' m'),
                                  ],
                                ),
                              ),
                              Opacity(
                                opacity: (anime[enumResultAnime.point]!.state ==
                                    enumAnimeState.doing
                                    ? _dispValue.value
                                    : anime[enumResultAnime.point]!.state ==
                                    enumAnimeState.end
                                    ? 1.0
                                    : 0.0),
                                child: Container(
                                  margin: EdgeInsets.only(top: 20),
                                  child: Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Text("ポイント："),
                                      Text(gameData.point.toString() + " ポイント"),
                                    ],
                                  ),
                                ),
                              ),
                            ]),
                          ]),
                    ),
                  )));
  }
}

// builder: (BuildContext context) {
