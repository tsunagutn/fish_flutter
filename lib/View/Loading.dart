import 'package:fish_flutter/Model/StageModel.dart';
import 'package:flutter/material.dart';

import 'package:fish_flutter/View/DrawerItem.dart';
import 'package:fish_flutter/View/Fishing.dart';
import 'package:fish_flutter/Class/BasePageState.dart';
import 'package:fish_flutter/Class/clsColor.dart';
import 'package:hive/hive.dart';

import '../Main.dart';

class Loading extends StatefulWidget {
  static List<String> screenBgms = [
    'muon01.mp3',
    // 'kaigarabushi.mp3',
    // 'saitarobushi.mp3'
  ];
  @override
  _LoadingState createState() {
    return _LoadingState();
  }
}

class _LoadingState extends BasePageState<Loading> {
  _LoadingState()
      : super(fileNames: Loading.screenBgms, bgmMode: enumBgmMode.none);

  var _bgm = settings.flgBgm; //音再生の有フラグ

  @override
  void initState() {
    super.initState();
  }

  void _changeBgm(bool? e) => setState(() {
        _bgm = e!;
        settings.flgBgm = _bgm;

        final box = Hive.box(settingsBoxName);
        box.put(settingsKeyName, settings);
      });

  @override
  Widget buildChildWidget(BuildContext context) {
    // <-- 通常のbuildメソッドの代わりに実装
    return Material(
      child: Scaffold(
        body: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            decoration: BoxDecoration(
              border: Border.all(color: clsColor.getColorFromHex("FFFFFF")),
              color: clsColor.getColorFromHex("FFFFFF"),
            ),
            //child: Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: new SwitchListTile(
                    value: _bgm,
                    activeColor: Colors.orange,
                    activeTrackColor: Colors.grey,
                    inactiveThumbColor: Colors.white,
                    inactiveTrackColor: Colors.grey,
                    secondary: new Icon(
                      Icons.volume_up,
                      color: _bgm ? Colors.orange[700] : Colors.grey[500],
                      size: 50.0,
                    ),
                    title: Text('音の再生'),
                    subtitle: Text(_bgm ? 'ON' : 'OFF'),
                    onChanged: _changeBgm,
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(bottom: 20),
                  child: Text(
                    "※いつでも設定から変更できます",
                    style: TextStyle(
                      color: Colors.red,
                    ),
                  ),
                ),
                ElevatedButton(
                  child: Text("ゲームを始める"),
                  onPressed: () async {
                    final result = bgm.loadBgm().then((_) {
                      // ここでBGMデータの全ロード処理実行
                      //効果音managerで無音を再生
                      soundManagerPool.SoundManagerPoolInit();
                      Navigator.of(context).pushReplacementNamed("/menu");
                    });
                  },
                ),
              ],
            )),
      ),
      //),
    );
  }
}
