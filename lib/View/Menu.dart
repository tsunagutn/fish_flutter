import 'package:flutter/material.dart';

import 'package:fish_flutter/View/DrawerItem.dart';
import 'package:fish_flutter/View/Fishing.dart';
import 'package:fish_flutter/Class/BasePageState.dart';
import 'package:fish_flutter/Class/clsColor.dart';

import '../Main.dart';
import '../widget/SettingDialog.dart';

class Menu extends StatefulWidget {
  @override
  _menuState createState() {
    return _menuState();
  }
}

class _menuState extends BasePageState<Menu> {
  _menuState() : super(fileName: "bgm_fight.mp3");

  @override
  Widget buildChildWidget(BuildContext context) {
    // <-- 通常のbuildメソッドの代わりに実装
    return Material(
        child: Scaffold(
      // appBar: AppBar(
      //   title: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
      //     Text("メインメニュー"),
      //   ]),
      // ),
      endDrawer: DrawerItem(),
      body: Container(
        decoration: BoxDecoration(
          border: Border.all(color: clsColor.getColorFromHex("4C58FF")),
          color: clsColor.getColorFromHex("4C58FF"),
        ),
        child: Stack(
          children: <Widget>[
            FittedBox(
              fit: BoxFit.fill,
//              margin: EdgeInsets.only(top: 0, left: 0),
              child: new Image(
                image: AssetImage('assets/images/title.png'),
                //width: 60,
                //height: _appBarHeight - 10,
              ),
            ),
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Card(
                    margin: const EdgeInsets.only(bottom: 30),
                    color: Color(0xffffffe0),
                    elevation: 10,
                    shadowColor: Color(0xff555555),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: InkWell(
                        splashColor: Colors.blue.withAlpha(10),
                        borderRadius: BorderRadius.circular(10),
                        onTap: () async {
                          final result =
                              //await Navigator.of(context).pushNamed('/fishing');
                              bgm.loadBgm().then((_) {
                            // ここでBGMデータの全ロード処理実行
                            debugPrint(Fishing.screenBgm);
                            //効果音managerで無音を再生
                            soundManagerPool.SoundManagerPoolInit();
                            bgm.playBgm(name: Fishing.screenBgm); // 遷移先のBGM再生
                            Navigator.pushNamed(context, "/fishing"); // 遷移
                          });
                        },
                        child: Container(
                            margin: const EdgeInsets.all(10.0),
                            width: 200,
                            height: 50,
                            child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Icon(
                                    Icons.check,
                                    color: Colors.green,
                                    size: 30.0,
                                  ),
                                  Text(
                                    "ゲームを開始",
                                    style: TextStyle(
                                        fontSize: 16, color: Colors.black),
                                  ),
                                ]))),
                  ),
                  Card(
                    margin: const EdgeInsets.only(bottom: 60),
                    color: Color(0xffffffe0),
                    elevation: 10,
                    shadowColor: Color(0xff555555),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: InkWell(
                        splashColor: Colors.blue.withAlpha(10),
                        borderRadius: BorderRadius.circular(10),
                        onTap: () async {
                          // final result =
                          //     await Navigator.of(context).pushNamed('/settings');
                          // if (result != null) {
                          //   setState(() {
                          //     todoList.add(result);
                          //   });
                          super.bgm.stopBgmAny();
                          int? result = await showDialog<int>(
                            context: context,
                            barrierDismissible: false,
                            builder: (_) {
                              return SettingDialog(
                                bgm: super.bgm,
                              );
                            },
                          );
                          bgm.playBgm(name: Fishing.screenBgm); // 遷移先のBGM再生
                        },
                        child: Container(
                            margin: const EdgeInsets.all(10.0),
                            width: 200,
                            height: 50,
                            child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Icon(
                                    Icons.settings,
                                    color: Colors.green,
                                    size: 30.0,
                                  ),
                                  Text(
                                    "設定を変更する",
                                    style: TextStyle(
                                        fontSize: 16, color: Colors.black),
                                  ),
                                ]))),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    ));
  }
}
