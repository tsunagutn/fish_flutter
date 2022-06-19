import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:hive/hive.dart';

import '../Class/BasePageState.dart';
import '../Main.dart';
import '../widget/menuCard.dart';
import 'DrawerItem.dart';
import 'package:fish_flutter/Class/clsColor.dart';
import 'package:fluttertoast/fluttertoast.dart';

class GameMenu extends StatefulWidget {
  GameMenu({Key? key}) : super(key: key);
  static List<String> screenBgms = [
    'menu.mp3',
  ];

  @override
  _GameMenuState createState() => _GameMenuState();
}

class _GameMenuState extends BasePageState<GameMenu> {
  _GameMenuState()
      : super(fileNames: GameMenu.screenBgms, bgmMode: enumBgmMode.appOnly);

  @override
  void initState() {
    super.initState();
  }

  void dispose() {
    super.dispose();
  }

  @override
  Widget? buildChildWidget(BuildContext context) {
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
                Text("ゲームメニュー"),
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
            decoration: BoxDecoration(
              border: Border.all(color: clsColor.getColorFromHex("4C58FF")),
              color: clsColor.getColorFromHex("4C58FF"),
              // image: DecorationImage(
              //   fit: BoxFit.fitWidth,
              //   image: AssetImage('assets/images/title.png'),
              // ),
            ),
            child: Stack(children: <Widget>[
              Center(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: () {
                          final historyBox = Hive.box(historyBoxName);
                          if (!historyBox.containsKey(historyKeyName)) {
                            //履歴データが存在しない
                            Fluttertoast.showToast(
                              msg: "履歴がありません！",
                              gravity: ToastGravity.CENTER,
                              timeInSecForIosWeb: 3,
                              toastLength: Toast.LENGTH_SHORT,
                              backgroundColor: Colors.red[300],
                              textColor: Colors.white,
                              fontSize: 16.0,
                            );
                            return;
                          }
                          Navigator.pushNamed(context, "/history");
                        },
                        child:
                            new menuCard(cardText: '履歴', icon: Icons.history),
                      ),
                    ]),
              ),
            ]),
          ),
        ),
      ),
    );
  }
}
