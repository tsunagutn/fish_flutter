import 'package:flutter/material.dart';
import 'package:fish_flutter/View/DrawerItem.dart';
import 'package:fish_flutter/Class/BasePageState.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hive/hive.dart';

import '../Main.dart';
import '../TypeAdapter/typGameData.dart';
import '../TypeAdapter/typHistory.dart';
import '../widget/clsBook.dart';

class BookHistory extends StatefulWidget {
  BookHistory({Key? key}) : super(key: key);
  static List<String> screenBgms = [
    'bgm_book.mp3', //
  ];

  @override
  _bookState createState() => _bookState();
}

// 設定ページのステータス管理
class _bookState extends BasePageState<BookHistory>
    with SingleTickerProviderStateMixin {
  _bookState()
      : super(fileNames: BookHistory.screenBgms, bgmMode: enumBgmMode.none);

  late typHistory history;
  late typGameData mainData;

  @override
  void initState() {
    super.initState();
    final historyBox = Hive.box(historyBoxName);
    //全釣果データ
    if (historyBox.containsKey(historyKeyName)) {
      history = historyBox.get(historyKeyName);
    } else {
      //履歴データが存在しない
      return;
    }
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
    //履歴の釣果データをセット
    history.lstGameDatas.forEach((data) {
      mainData.fishResults.addAll(data.fishResults);
    });
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
