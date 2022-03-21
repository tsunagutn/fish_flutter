import 'package:fish_flutter/Main.dart';
import 'package:fish_flutter/Model/CheckListTestModel.dart';
import 'package:fish_flutter/Model/FishModel.dart';
import 'package:fish_flutter/Model/FishResultsModel.dart';
import 'package:fish_flutter/Model/RodsModel.dart';
import 'package:fish_flutter/Model/ReelsModel.dart';
import 'package:fish_flutter/View/Fishing.dart';
import 'package:fish_flutter/Model/HaveTackleModel.dart';
import 'package:fish_flutter/widget/SoundManagerPool.dart';
import 'package:flutter/material.dart';

import 'RadarChart.dart';
import 'SliderPainter.dart';

class SettingDialog extends StatefulWidget {
  @override
  const SettingDialog({
    required this.soundManagerPool,
  });
  final SoundManagerPool soundManagerPool;
  _SettingDialogState createState() => _SettingDialogState();
}

class _SettingDialogState extends State<SettingDialog>
    with SingleTickerProviderStateMixin {
  List<FishModel> fishList = [];
  int retPoint = 0;

  final _tab = <Tab>[
    Tab(
      text: 'ゲーム設定',
    ),
    Tab(
      text: 'システム設定',
    ),
    // Tab(
    //   text: 'Ship',
    // ),
  ];

  var _bgm = false; //音再生の有フラグ
  var _controlLeft = false; //スマホを持つ手が左手フラグ

  void _changeBgm(bool? e) => setState(() {
        _bgm = e!;
        settings.flgBgm = _bgm;
        //効果音managerで無音を再生
        widget.soundManagerPool.SoundManagerPoolInit();
      });

  void _changeControl(bool? e) => setState(() {
        _controlLeft = e!;
        settings.flgControlLeft = _controlLeft;
      });

  @override
  void initState() {
    super.initState();

    //環境設定の読込
    _bgm = settings.flgBgm;
    _controlLeft = settings.flgControlLeft;
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      insetPadding: EdgeInsets.only(top: 40, bottom: 40, left: 10, right: 10),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text("設定"),
        ],
      ),
      content: Container(
        //height: MediaQuery.of(context).size.height / 2,
        child: Stack(children: [
          Column(children: <Widget>[
            Container(
                width: double.maxFinite,
                height: MediaQuery.of(context).size.height / 1.5,
                margin: EdgeInsets.only(bottom: 10),
                child: DefaultTabController(
                  length: _tab.length,
                  child: Scaffold(
                    appBar: AppBar(
                      //title: Text("Tab Page"),
                      automaticallyImplyLeading: false,

                      title: TabBar(
                        tabs: _tab,
                      ),
                    ),
                    body: TabBarView(
                      children: <Widget>[
                        Container(
                          child: Column(children: [
                            new SwitchListTile(
                              value: _controlLeft,
                              activeColor: Colors.orange,
                              activeTrackColor: Colors.grey,
                              inactiveThumbColor: Colors.blue,
                              inactiveTrackColor: Colors.grey,
                              secondary: new Icon(
                                Icons.pan_tool_rounded,
                                color: _controlLeft
                                    ? Colors.orange[700]
                                    : Colors.grey[500],
                                size: 50.0,
                              ),
                              title: Text('操作'),
                              subtitle: Text(_controlLeft ? '左手' : '右手'),
                              onChanged: _changeControl,
                            ),
                            new SwitchListTile(
                              value: _bgm,
                              activeColor: Colors.orange,
                              activeTrackColor: Colors.grey,
                              inactiveThumbColor: Colors.white,
                              inactiveTrackColor: Colors.grey,
                              secondary: new Icon(
                                Icons.volume_up,
                                color: _bgm
                                    ? Colors.orange[700]
                                    : Colors.grey[500],
                                size: 50.0,
                              ),
                              title: Text('音再生'),
                              subtitle: Text(_bgm ? 'ON' : 'OFF'),
                              onChanged: _changeBgm,
                            ),
                          ]),
                        ),
                        SecondPage(),
                      ],
                    ),
                  ),
                )),
            ElevatedButton.icon(
              icon: const Icon(
                Icons.close,
                color: Colors.white,
              ),
              label: const Text('閉じる'),
              style: ElevatedButton.styleFrom(
                primary: Colors.black.withOpacity(0.5),
                onPrimary: Colors.white,
              ),
              onPressed: () {
                Navigator.of(context).pop(retPoint);
              },
            ),
          ]),
        ]),
      ),
    );
  }
}

class SecondPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.orange,
      body: Center(
        child: Text(
          "Second Page",
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
