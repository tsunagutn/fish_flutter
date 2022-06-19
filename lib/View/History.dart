import 'package:fish_flutter/TypeAdapter/typHistory.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';

import '../Class/BasePageState.dart';
import '../Main.dart';
import '../widget/goalDialog.dart';
import 'DrawerItem.dart';

class History extends StatefulWidget {
  History({Key? key}) : super(key: key);

  static List<String> screenBgms = [
    'menu.mp3', //？？？BGMかえること
  ];
  @override
  _historyState createState() => _historyState();
}

class _historyState extends BasePageState<History> {
  _historyState() : super(fileNames: History.screenBgms, defaultPlay: true);
  late typHistory history;
  double _appBarHeight = 0.0;

  @override
  void initState() {
    super.initState();
    final historyBox = Hive.box(historyBoxName);
    if (!historyBox.containsKey(historyKeyName)) {
      //履歴データが存在しない
      return;
    }
    history = historyBox.get(historyKeyName);

    WidgetsBinding.instance?.addPostFrameCallback((cb) {
      //AppBarの高さを取得 ステータスバーの高さも加算
      _appBarHeight =
          AppBar().preferredSize.height;
    });
  }

  void dispose() {
    super.dispose();
  }

  @override
  Widget buildChildWidget(BuildContext context) {
    DateFormat outputFormat = DateFormat('yyyy/MM/dd HH:mm');

    return Material(
      child: new WillPopScope(
          onWillPop: () async {
            return super.isBack;
          },
          child: Scaffold(
            appBar: AppBar(
              title: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("履歴"),
                ],
              ),
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
            body: Container(
              width: double.infinity,
              child: ListView.builder(
                itemCount: history.lstGameDatas.length,
                itemBuilder: (context, index) {
                  var hist = history.lstGameDatas[index];
                  return GestureDetector(
                      onTap: () async {
                          var result = await showDialog<int>(
                            context: context,
                            barrierDismissible: false,
                            builder: (_) {
                              return Stack(
                                children: [
                                  //ゴールダイアログ
                                  goalDialog(
                                    isHistory: true,
                                    keyName: history.lstGameDatas[index].saveDateTime,
                                    marginTop: _appBarHeight,
                                  ),
                                ],
                              );
                            },
                          );
                        },
                      child: ListTile(
                        title: Column(
                          children: [
                            Text(hist.saveDateTime),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Text("釣った数:"
                                        '${hist.fishResults.length}' +
                                    " 匹"),
                                Text('${hist.point}' + " ポイント"),
                              ],
                            )
                          ],
                        ),
                      ));
                },
              ),
            ),
          )),
    );
  }
}
