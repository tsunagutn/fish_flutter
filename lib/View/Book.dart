import 'package:flutter/material.dart';
import 'package:fish_flutter/View/DrawerItem.dart';
import 'package:fish_flutter/Class/BasePageState.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hive/hive.dart';

import '../Main.dart';
import '../TypeAdapter/typGameData.dart';
import '../TypeAdapter/typHistory.dart';
import '../widget/clsBook.dart';

class Book extends StatefulWidget {
  Book({Key? key, required this.arguments, required enumBgmMode this.bgmMode})
      : super(key: key);
  final enumBgmMode bgmMode;
  final String arguments;
  static List<String> screenBgms = [
    'bgm_book.mp3', //
  ];

  @override
  _bookState createState() => _bookState(bgmMode: bgmMode, keyName: arguments);
}

// 設定ページのステータス管理
class _bookState extends BasePageState<Book>
    with SingleTickerProviderStateMixin {
  _bookState({required enumBgmMode this.bgmMode, required this.keyName})
      : super(fileNames: Book.screenBgms, bgmMode: bgmMode);
  final enumBgmMode bgmMode;
  final String keyName;

  late typGameData gameData;
  late typHistory history;
  late typGameData mainData;

  bool _isHistory = false;
  bool _isHistoryNone = false;

  @override
  void initState() {
    super.initState();
    final historyBox = Hive.box(historyBoxName);
    //全釣果データ
    if (historyBox.containsKey(historyKeyName)) {
      history = historyBox.get(historyKeyName);
    } else {
      //履歴が無い場合
      _isHistoryNone = true;
    }
    final gameDataBox = Hive.box(gamedataBoxName);
    //指定のゲームのデータ
    gameData = gameDataBox.get(keyName);
    //釣果データをセット
    setData();
  }

  //釣果データをセット
  void setData() {
    final fishResultBox = Hive.box(fishResultBoxName);
    final lureDataBox = Hive.box(lureDataBoxName);
    //表示用データを初期化
    mainData = typGameData(
        gameId: 0,
        timeCount: 0,
        maxTimeCount: 0,
        point: 0,
        maxDepth: 0,
        windLevel: 0.0,
        maxWindLevel: 0.0,
        maxTension: 0.0,
        maxLineHp: 0.0,
        maxSpeed: 0.0,
        useLureIdx: 0,
        saveDateTime: '',
        isEnd: false);
    mainData.fishResults = HiveList(fishResultBox);
    mainData.lureData = HiveList(lureDataBox);
    if (_isHistory && !_isHistoryNone) {
      //履歴の釣果データをセット
      history.lstGameDatas.forEach((data) {
        mainData.fishResults.addAll(data.fishResults);
      });
      //今回の釣果データをセット
      mainData.fishResults.addAll(gameData.fishResults);
    } else {
      mainData = gameData;
    }
  }

  @override
  Widget buildChildWidget(BuildContext context) {
    return new WillPopScope(
      onWillPop: () async {
        return super.isBack;
      },
      child: Scaffold(
        appBar: AppBar(
          title:
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Text("おさかな図鑑"),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  (_isHistory ? "累計" : "今回"),
                ),
                new Switch(
                  value: _isHistory,
                  activeColor: Colors.orange,
                  activeTrackColor: Colors.grey,
                  inactiveThumbColor: Colors.blue,
                  inactiveTrackColor: Colors.grey,
                  onChanged: (bool e) => setState(() {
                    if (_isHistoryNone) {
                      //履歴が無い場合は今回のみ
                      //履歴データが存在しない
                      Fluttertoast.showToast(
                        msg: "履歴がありません！",
                        gravity: ToastGravity.TOP,
                        timeInSecForIosWeb: 3,
                        toastLength: Toast.LENGTH_SHORT,
                        backgroundColor: Colors.red[300],
                        textColor: Colors.white,
                        fontSize: 16.0,
                      );
                      _isHistory = false;
                      mainData = gameData;
                      return;
                    }
                    _isHistory = e;
                    //釣果データをセット
                    setData();
                  }),
                ),
              ],
            ),
          ]),
          leading: IconButton(
            // 表示アイコン
            icon: Icon(Icons.arrow_back),
            color: Colors.white,
            iconSize: 30.0,
            onPressed: () {
              //前画面に戻る
              super.isBack = true;
              Navigator.of(context).pop();
            },
          ),
        ),
        endDrawer: DrawerItem(),
        // 背景色
        //backgroundColor: Colors.teal[50],
        body: new clsBook(mainData: mainData),
      ),
    );
  }
}
