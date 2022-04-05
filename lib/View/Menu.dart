import 'package:flutter/material.dart';

import 'package:fish_flutter/View/DrawerItem.dart';
import 'package:fish_flutter/View/Fishing.dart';
import 'package:fish_flutter/Class/BasePageState.dart';

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
      appBar: AppBar(
        title: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          Text("メインメニュー"),
        ]),
      ),
      endDrawer: DrawerItem(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Card(
              margin: const EdgeInsets.only(top: 30, bottom: 30),
              color: Color(0xffffffe0),
              elevation: 10,
              shadowColor: Color(0xff555555),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
              child: InkWell(
                  splashColor: Colors.blue.withAlpha(30),
                  borderRadius: BorderRadius.circular(30),
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
                      width: 400,
                      height: 100,
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Icon(
                              Icons.check,
                              color: Colors.green,
                              size: 60.0,
                            ),
                            Text(
                              "開始",
                              style:
                                  TextStyle(fontSize: 32, color: Colors.black),
                            ),
                          ]))),
            ),
            Card(
              margin: const EdgeInsets.only(top: 30, bottom: 30),
              color: Color(0xffffffe0),
              elevation: 10,
              shadowColor: Color(0xff555555),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
              child: InkWell(
                  splashColor: Colors.blue.withAlpha(30),
                  borderRadius: BorderRadius.circular(30),
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
                      width: 400,
                      height: 100,
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Icon(
                              Icons.settings,
                              color: Colors.green,
                              size: 60.0,
                            ),
                            Text(
                              "設定を変更する",
                              style:
                                  TextStyle(fontSize: 32, color: Colors.black),
                            ),
                          ]))),
            ),
            Card(
              margin: const EdgeInsets.only(top: 30, bottom: 30),
              color: Color(0xffffffe0),
              elevation: 10,
              shadowColor: Color(0xff555555),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
              child: InkWell(
                  splashColor: Colors.blue.withAlpha(30),
                  borderRadius: BorderRadius.circular(30),
                  onTap: () async {
                    final result =
                        await Navigator.of(context).pushNamed('/lightspot');
                    // if (result != null) {
                    //   setState(() {
                    //     todoList.add(result);
                    //   });
                  },
                  child: Container(
                      margin: const EdgeInsets.all(10.0),
                      width: 400,
                      height: 100,
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Icon(
                              Icons.settings,
                              color: Colors.green,
                              size: 60.0,
                            ),
                            Text(
                              "てすと",
                              style:
                                  TextStyle(fontSize: 32, color: Colors.black),
                            ),
                          ]))),
            ),
          ],
        ),
      ),
    ));
  }
}
