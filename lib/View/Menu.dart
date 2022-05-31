import 'package:fish_flutter/Model/StageModel.dart';
import 'package:flutter/material.dart';

import 'package:fish_flutter/View/DrawerItem.dart';
import 'package:fish_flutter/View/Fishing.dart';
import 'package:fish_flutter/Class/BasePageState.dart';
import 'package:fish_flutter/Class/clsColor.dart';

import '../Main.dart';
import '../widget/SettingDialog.dart';

class Menu extends StatefulWidget {
  static List<String> screenBgms = [
    'title.mp3',
    // 'kaigarabushi.mp3',
    // 'saitarobushi.mp3'
  ];
  @override
  _menuState createState() {
    return _menuState();
  }
}

class _menuState extends BasePageState<Menu> {
  _menuState() : super(fileNames: Menu.screenBgms);

  @override
  void initState() {
    super.initState();
    //super.bgmPlay(Menu.screenBgms);
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
              body: Container(
                decoration: BoxDecoration(
                  border: Border.all(color: clsColor.getColorFromHex("4C58FF")),
                  color: clsColor.getColorFromHex("4C58FF"),
                  image: DecorationImage(
                    fit: BoxFit.fitWidth,
                    image: AssetImage('assets/images/title.png'),
                  ),
                ),
                child: Stack(
                  children: <Widget>[
                    Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Card(
                            margin: const EdgeInsets.only(bottom: 30),
                            color: clsColor.getColorFromHex("ffffe0"),
                            elevation: 10,
                            shadowColor: clsColor.getColorFromHex("555555"),
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
                                    //効果音managerで無音を再生
                                    soundManagerPool.SoundManagerPoolInit();
                                    //bgm.playBgm(name: Fishing.screenBgms); // 遷移先のBGM再生
                                    //super.bgmPlay(Fishing.screenBgms);
                                    Navigator.pushNamed(context, "/fishing",
                                            arguments: stages.getStageData(1))
                                        .then(
                                      (value) {
                                        //メニュー画面のBGMを再生
                                        super.bgmPlay(Menu.screenBgms);
                                      },
                                    );
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
                                                fontSize: 16,
                                                color: Colors.black),
                                          ),
                                        ]))),
                          ),
                          // Card(
                          //   margin: const EdgeInsets.only(bottom: 30),
                          //   color: clsColor.getColorFromHex("ffffe0"),
                          //   elevation: 10,
                          //   shadowColor: clsColor.getColorFromHex("555555"),
                          //   shape: RoundedRectangleBorder(
                          //     borderRadius: BorderRadius.circular(10),
                          //   ),
                          //   child: InkWell(
                          //       splashColor: Colors.blue.withAlpha(10),
                          //       borderRadius: BorderRadius.circular(10),
                          //       onTap: () async {
                          //         final result =
                          //             bgm.loadBgm().then((_) {
                          //           // ここでBGMデータの全ロード処理実行
                          //           //効果音managerで無音を再生
                          //           soundManagerPool.SoundManagerPoolInit();
                          //           //bgm.playBgm(name: Fishing.screenBgm); // 遷移先のBGM再生
                          //           super.bgmPlay(Fishing.screenBgms);
                          //           Navigator.pushNamed(context, "/fishing",
                          //               arguments: stages.getStageData(0));
                          //         });
                          //       },
                          //       child: Container(
                          //           margin: const EdgeInsets.all(10.0),
                          //           width: 200,
                          //           height: 50,
                          //           child: Row(
                          //               mainAxisAlignment:
                          //                   MainAxisAlignment.spaceAround,
                          //               children: [
                          //                 Icon(
                          //                   Icons.check,
                          //                   color: Colors.green,
                          //                   size: 30.0,
                          //                 ),
                          //                 Text(
                          //                   "あそびかた",
                          //                   style: TextStyle(
                          //                       fontSize: 16, color: Colors.black),
                          //                 ),
                          //               ]))),
                          // ),
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
                                  super.bgmPlay(Menu.screenBgms);
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
                                            "設定",
                                            style: TextStyle(
                                                fontSize: 16,
                                                color: Colors.black),
                                          ),
                                        ]))),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            )));
  }
}
