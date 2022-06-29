import 'package:fish_flutter/Model/StageModel.dart';
import 'package:fish_flutter/TypeAdapter/typFishResult.dart';
import 'package:fish_flutter/TypeAdapter/typGameData.dart';
import 'package:fish_flutter/TypeAdapter/typLureData.dart';
import 'package:flutter/material.dart';

import 'package:fish_flutter/View/DrawerItem.dart';
import 'package:fish_flutter/View/Fishing.dart';
import 'package:fish_flutter/Class/BasePageState.dart';
import 'package:fish_flutter/Class/clsColor.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';

import '../Main.dart';
import '../widget/menuCard.dart';

class Menu extends StatefulWidget {
  static List<String> screenBgms = [
    'title.mp3',
  ];
  @override
  _menuState createState() {
    return _menuState();
  }
}

class _menuState extends BasePageState<Menu> {
  _menuState() : super(fileNames: Menu.screenBgms, bgmMode: enumBgmMode.auto);

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget buildChildWidget(BuildContext context) {
    // <-- 通常のbuildメソッドの代わりに実装
    return Material(
        child: new WillPopScope(
            onWillPop: () async => false,
            child: Scaffold(
              appBar: AppBar(
                title:
                    Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  //Text("メインメニュー"),
                ]),
              ),
              endDrawer: DrawerItem(),
              body:
              Stack(
                  children: <Widget>[
              Container(
                margin: EdgeInsets.only(top:40),
                decoration: BoxDecoration(
                  //border: Border.all(color: clsColor.getColorFromHex("4C58FF")),
                  color: clsColor.getColorFromHex("FFFFFF"),
                  image: DecorationImage(
                    fit: BoxFit.fitWidth,
                      alignment: Alignment.topCenter,
                    image: AssetImage('assets/images/title.png'),
                  ),
                ),
                child:
                    Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          GestureDetector(
                            onTap: () async {
                              bool isPush = false;
                              final gameDataBox = Hive.box(gamedataBoxName);
                              final fishResultBox = Hive.box(fishResultBoxName);
                              typGameData gameData;
                              if (gameDataBox.containsKey(gamedataKeyName)) {
                                // gameData =
                                //     await gameDataBox.get(gamedataKeyName);
                                // if (gameData.isEnd) {
                                //   //終了済みの場合は初期データをセット
                                //   // await gameDataBox.put(
                                //   //     gamedataKeyName, getStartGameData());
                                //   gameData = getStartGameData();
                                //   gameData.save();
                                //   isPush = true;
                                //   //gameData = getStartGameData();
                                // } else {
                                //中断データがある？？？ダイアログ
                                var result = await showDialog<int>(
                                  context: context,
                                  barrierDismissible: false,
                                  builder: (_) {
                                    return AlertDialog(
                                      title: Text("中断データがあります"),
                                      content: Text("途中から再開しますか？"),
                                      actions: <Widget>[
                                        TextButton(
                                          child: Text("再開"),
                                          onPressed: () {
                                            //モーダルを閉じる
                                            Navigator.of(context).pop(1);
                                          },
                                        ),
                                        TextButton(
                                            child: Text("消して最初から"),
                                            onPressed: () async {
                                              //ゲームデータを初期化
                                              typGameData gd =
                                                  await getStartGameData();
                                              await gameDataBox.put(
                                                  gamedataKeyName, gd);
                                              //モーダルを閉じる
                                              Navigator.of(context).pop(1);
                                            }),
                                        TextButton(
                                            child: Text("キャンセル"),
                                            onPressed: () async {
                                              //モーダルを閉じる
                                              Navigator.of(context).pop(0);
                                              return;
                                            }),
                                      ],
                                    );
                                  },
                                );
                                isPush = result == 1 ? true : false;
                                //}
                              } else {
                                //データ無しの場合は初期データをセット
                                typGameData gd = await getStartGameData();
                                await gameDataBox.put(gamedataKeyName, gd);
                                isPush = true;
                              }
                              if (isPush) {
                                Navigator.pushNamed(context, "/fishing");
                              }
                            },
                            child: new menuCard(
                                cardText: 'ゲームを開始', icon: Icons.start),
                          ),

                          GestureDetector(
                            onTap: () {
                              Navigator.pushNamed(context, "/gamemenu");
                            },
                            child: new menuCard(
                              cardText: 'ゲームメニュー',
                              icon: Icons.menu_book,
                            ),
                          ),
                          GestureDetector(
                            onTap: () async {
                              Navigator.pushNamed(context, "/settings");
                            },
                            child: new menuCard(
                              cardText: '設定',
                              icon: Icons.settings,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                          Container(
                            margin: EdgeInsets.only(top: 10),
                            alignment: Alignment.topCenter,
                            child:
                            Text("ああ",
                              style: GoogleFonts.kaiseiTokumin (fontSize: 40,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                //letterSpacing: 6.0,
                                shadows: <Shadow>[
                                Shadow(
                                color: Colors.grey,
                                offset: Offset(3.0, 3.0),
                                blurRadius: 5.0,
                                ),],
                              ),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(top:40),
                            alignment: Alignment.topCenter,
                            child:
                            Text("どてら流し",
                              style: GoogleFonts.delaGothicOne (fontSize: 80,
                                color: Colors.red,
                                //fontWeight: FontWeight.bold,
                                letterSpacing: 3.0,
                                shadows: <Shadow>[
                                  Shadow(
                                    color: Colors.yellowAccent,
                                    offset: Offset(1.0, 1.0),
                                    blurRadius: 30.0,
                                  ),],
                              ),
                            ),
                          ),

                  ]),
              ),
            ));
  }

  //ゲームの初期データをセット？？？シーダー追加して色々返れるようにする
  typGameData getStartGameData() {
    final fishResultBox = Hive.box(fishResultBoxName);
    final lureDataBox = Hive.box(lureDataBoxName);

    var now = DateTime.now().toString();
    debugPrint(now.toString());
    //初期データをセット
    var gameData = typGameData(
        gameId: 1,
        timeCount: 0,
        //timeCount: 30 * 60 * 10 + 1200, //すぐ終了
        maxTimeCount: (30 * 60 * 11),
        point: 0,
        maxDepth: 40,
        windLevel: 0.0,
        maxWindLevel: 0.0,
        maxTension: 2000.0,
        maxLineHp: 1000.0,
        maxSpeed: 200.0,
        useLureIdx: 0,
        saveDateTime: now,
        isEnd: false);
    gameData.fishResults = HiveList(fishResultBox);
    gameData.lureData = HiveList(lureDataBox);

    //ルアーの初期データをセット
    var tairaba = typLureData(
        lureId: enumLureDiv.tairaba.index,
        name: 'タイラバ',
        image: "tairaba.png",
        lv: 1,
        totalExp: 0,
        unLockweightid: 0,
        useWeightId: 0,
        fall: 0.2,
        reeling: 0.5,
        jerk: 0.1,
        lvAddFall: 0.02,
        lvAddReeling: 0.05,
        lvAddJerk: 0.01);
    var jig = typLureData(
        lureId: enumLureDiv.jig.index,
        name: 'ジグ',
        image: "jig.png",
        lv: 1,
        totalExp: 0,
        unLockweightid: 0,
        useWeightId: 0,
        fall: 0.2,
        reeling: 0.1,
        jerk: 0.5,
        lvAddFall: 0.03,
        lvAddReeling: 0.01,
        lvAddJerk: 0.05);
    var slowJig = typLureData(
        lureId: enumLureDiv.slowjig.index,
        name: 'スロージグ',
        image: "slowjig.png",
        lv: 1,
        totalExp: 0,
        unLockweightid: 0,
        useWeightId: 0,
        fall: 0.4,
        reeling: 0.2,
        jerk: 0.2,
        lvAddFall: 0.04,
        lvAddReeling: 0.02,
        lvAddJerk: 0.02);

    lureDataBox.add(jig);
    lureDataBox.add(tairaba);
    lureDataBox.add(slowJig);
    gameData.lureData.add(tairaba);
    gameData.lureData.add(jig);
    gameData.lureData.add(slowJig);

    return gameData;
  }
}
