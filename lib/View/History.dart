import 'package:fish_flutter/TypeAdapter/typHistory.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';

import '../Class/BasePageState.dart';
import '../Main.dart';
import '../widget/goalDialog.dart';

class History extends StatefulWidget {
  History({Key? key}) : super(key: key);

  static List<String> screenBgms = [
    'menu.mp3', //？？？BGMかえること
  ];
  @override
  _historyState createState() => _historyState();
}

class _historyState extends BasePageState<History> {
  _historyState() : super(fileNames: History.screenBgms);
  late typHistory history;

  @override
  void initState() {
    super.initState();
    final historyBox = Hive.box(historyBoxName);
    if (!historyBox.containsKey(historyKeyName)) {
      //履歴データが存在しない
      return;
    }
    history = historyBox.get(historyKeyName);
  }

  void dispose() {
    super.dispose();
  }

  @override
  Widget buildChildWidget(BuildContext context) {
    DateFormat outputFormat = DateFormat('yyyy/MM/dd HH:mm');

    return Scaffold(
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
                            bgm: super.bgm,
                            isHistory: true,
                            keyName: hist.saveDateTime.toString(),
                            lockBook: true,
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
    );
  }
}
