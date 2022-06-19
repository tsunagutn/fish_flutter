
import 'package:fish_flutter/TypeAdapter/typHistory.dart';
import 'package:fish_flutter/widget/clsGoal.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';

import '../Class/BasePageState.dart';
import '../Main.dart';
import '../TypeAdapter/typGameData.dart';
import '../widget/goalDialog.dart';
import 'DrawerItem.dart';

class Goal extends StatefulWidget {
  Goal({Key? key}) : super(key: key);

  static List<String> screenBgms = [
    'result.mp3',
  ];
  @override
  _goalState createState() => _goalState();
}

class _goalState extends BasePageState<Goal>
    with TickerProviderStateMixin {
  _goalState() : super(fileNames: Goal.screenBgms, defaultPlay: true);
  late AnimationController _lightingAnimationController;
  late Animation<double> _lightingValue;
  late typGameData gameData;

  @override
  void initState() {
    super.initState();
    final gameDataBox = Hive.box(gamedataBoxName);
    gameData = gameDataBox.get(gamedataKeyName);

    //最初の光
    _lightingAnimationController = AnimationController(
        duration: Duration(milliseconds: 4000), vsync: this);
    _lightingValue =
    Tween(begin: 1.5, end: 0.0).animate(_lightingAnimationController)
      ..addListener(() {
        setState(() {});
      });
    _lightingAnimationController.forward();
  }

  @override
  void dispose() {
    _lightingAnimationController.dispose();
    super.dispose();
  }

  @override
  Widget buildChildWidget(BuildContext context) {
    // `ModalRoute.of()`メソッドを使用して引数を取得
    final String hiveKeyName = ModalRoute.of(context)?.settings.arguments as String;
    DateFormat outputFormat = DateFormat('yyyy/MM/dd HH:mm');

    return
      Stack(children: [
      Opacity(
      //最初に画面全体を光らすために最初は透明にする
      opacity: _lightingValue.value <= 1.0 ? 1.0 : 0.0,
          child: Container(
          // decoration: new BoxDecoration(
          //     image: new DecorationImage(
          //   image: new AssetImage("assets/images/fishback.jpg"),
          //   fit: BoxFit.cover,
          // )),
          child:
      Material(
      child: new WillPopScope(
          onWillPop: () async {
            return super.isBack;
          },
          child: Scaffold(
            appBar: AppBar(
              //戻るを非表示
              automaticallyImplyLeading: false,
              title: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("おつかれさまでした"),
                ],
              ),
              // leading: IconButton(
              //   // 表示アイコン
              //   icon: Icon(Icons.arrow_back),
              //   color: Colors.white,
              //   iconSize: 30.0,
              //   onPressed: () {
              //     //前画面に戻る
              //     super.isBack = true;
              //     Navigator.of(context).pop();
              //   },
              // ),
            ),
            //endDrawer: DrawerItem(),
            body: Column(
              children: [Expanded(
              child: new clsGoal(isHistory: false, keyName: hiveKeyName),
            ),
              Container(margin:EdgeInsets.only(bottom: 10),child:
                ElevatedButton(
                  child: Text("保存して終了"),
                  onPressed: () async {
    //ゲーム中データを終了
    gameData.isEnd = true;
    var histGameData = gameData.copy();
    final gameDataBox =
    await Hive.box(gamedataBoxName);
    //セーブ日時をキーにして保存
    gameDataBox.put(
    histGameData.saveDateTime.toString(),
    histGameData);
    //元のキーのデータは削除
    gameDataBox.delete(gamedataKeyName);

    //履歴に登録
    final historyBox = await Hive.box(historyBoxName);
    var history;
    if (!historyBox.containsKey(historyKeyName)) {
    //最初の履歴データの場合
    history = typHistory();
    final gameDataBox = Hive.box(gamedataBoxName);
    history.lstGameDatas =
    HiveList<typGameData>(gameDataBox);
    historyBox.put(historyKeyName, history);
    }
    history = await historyBox.get(historyKeyName);
    history.lstGameDatas.add(histGameData);
    history.save();

    Navigator.pop(context);
    },

                ),),

              ],
            ),
          )),
    ))) ,
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
