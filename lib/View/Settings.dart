import 'package:flutter/material.dart';
import 'package:fish_flutter/Model/SettingsModel.dart';
import 'package:fish_flutter/View/DrawerItem.dart';
import 'package:fish_flutter/Class/BasePageState.dart';
import 'package:hive/hive.dart';

import '../Main.dart';

class Settings extends StatefulWidget {
  Settings({Key? key}) : super(key: key);
  static List<String> screenBgms = [
    'bgm_book.mp3', //
  ];

  @override
  _SettingsState createState() => _SettingsState();
}

// 設定ページのステータス管理
class _SettingsState extends BasePageState<Settings>
    with SingleTickerProviderStateMixin {
  _SettingsState() : super(fileNames: Settings.screenBgms);
  final _tab = <Tab>[
    Tab(
      text: 'ゲームの設定',
    ),
    Tab(
      text: '音の設定',
    ),
    Tab(
      text: 'テスト用',
    ),
    // Tab(
    //   text: 'Ship',
    // ),
  ];

  var _bgm = false; //音再生の有フラグ
  var _controlRight = false; //スマホを持つ手が右手フラグ
  var _volumeBgm = 0.8; //BGM音量
  var _volumeSe = 0.8; //SE音量
  var _jerkSense = 0.5; //ジャーク感度
  var _makiSense = 0.5; //巻き速度変更の感度
  var _isVibe = true; //バイブレーション有無
  var _isReversal = false; //上下操作の反転

  void _changeBgm(bool? e) => setState(() {
        _bgm = e!;
        settings.flgBgm = _bgm;
        //BGN再生
        if (e) {
          //効果音managerで無音を再生
          soundManagerPool.SoundManagerPoolInit();
          //BGM ONなら再生
          super.bgmResume();
        } else {
          //OFFなら停止
          super.bgmStop();
        }
      });

  void _changeControl(bool? e) => setState(() {
        _controlRight = e!;
        settings.flgControlRight = _controlRight;
      });
  void _changeVolumeBgm(double? e) => setState(() {
        _volumeBgm = e!;
        settings.volumeBgm = _volumeBgm;
      });
  void _changeVolumeSe(double? e) => setState(() {
        _volumeSe = e!;
        settings.volumeSe = _volumeSe;
      });
  void _changeEndVolumeBgm(double? e) => setState(() {
        super.bgm.volumeBgm();
      });
  void _changeEndVolumeSe(double? e) => setState(() {
        //適当な音を再生
        soundManagerPool.playSound('se/linebreak.mp3');
      });

  void _changeJerkSense(double? e) => setState(() {
        _jerkSense = e!;
        settings.jerkSense = _jerkSense;
      });

  void _changeMakiSense(double? e) => setState(() {
        _makiSense = e!;
        settings.makiSense = _makiSense;
      });

  void _changeReversal(bool? e) => setState(() {
        _isReversal = e!;
        settings.isReversal = _isReversal;
      });

  void _changeVibe(bool? e) => setState(() {
        _isVibe = e!;
        settings.isVibe = _isVibe;
        if (_isVibe) {
          //バイブ動作
          super.vibe(200);
        }
      });

  @override
  void initState() {
    super.initState();
    //環境設定の読込
    _bgm = settings.flgBgm;
    _controlRight = settings.flgControlRight;
    _volumeBgm = settings.volumeBgm;
    _volumeSe = settings.volumeSe;
    _jerkSense = settings.jerkSense;
    _makiSense = settings.makiSense;
    _isVibe = settings.isVibe;
    _isReversal = settings.isReversal;

    WidgetsBinding.instance?.addPostFrameCallback((cb) {
      super.bgmPlay(Settings.screenBgms);
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
            title: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              Text("環境設定"),
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
          body: DefaultTabController(
            length: _tab.length,
            child: new WillPopScope(
              onWillPop: () async => false,
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
                    //ゲームの設定タブ
                    Container(
                      margin: EdgeInsets.only(left: 15, top: 15),
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            new SwitchListTile(
                              value: _controlRight,
                              activeColor: Colors.orange,
                              activeTrackColor: Colors.grey,
                              inactiveThumbColor: Colors.blue,
                              inactiveTrackColor: Colors.grey,
                              secondary: new Icon(
                                Icons.pan_tool_rounded,
                                color: _controlRight
                                    ? Colors.orange[700]
                                    : Colors.blue[700],
                                size: 50.0,
                              ),
                              title: Text('操作'),
                              subtitle: Text(_controlRight ? '右手' : '左手'),
                              onChanged: _changeControl,
                            ),
                            Row(
                              children: [
                                Container(
                                  width: 100,
                                  margin: EdgeInsets.only(left: 15),
                                  child: Text("ジャークの感度"),
                                ),
                                Expanded(
                                  child: Slider(
                                    value: _jerkSense,
                                    //MAX-MINはテンションと同じ
                                    min: 0.0,
                                    max: 1.0,
                                    onChanged: _changeJerkSense,
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Container(
                                  width: 100,
                                  margin: EdgeInsets.only(left: 15),
                                  child: Text("巻き速度の感度"),
                                ),
                                Expanded(
                                  child: Slider(
                                    value: _makiSense,
                                    //MAX-MINはテンションと同じ
                                    min: 0.0,
                                    max: 1.0,
                                    onChanged: _changeMakiSense,
                                  ),
                                ),
                              ],
                            ),
                            new SwitchListTile(
                              value: _isReversal,
                              activeColor: Colors.orange,
                              activeTrackColor: Colors.grey,
                              inactiveThumbColor: Colors.white,
                              inactiveTrackColor: Colors.grey,
                              secondary: new Icon(
                                Icons.import_export,
                                color: _isReversal
                                    ? Colors.orange[700]
                                    : Colors.grey[500],
                                size: 50.0,
                              ),
                              title: Text('上下操作の反転'),
                              subtitle: Text(_isReversal ? 'ON' : 'OFF'),
                              onChanged: _changeReversal,
                            ),
                          ]),
                    ),
                    //音の設定タブ
                    Container(
                      margin: EdgeInsets.only(left: 15, top: 15),
                      child: Column(children: [
                        new SwitchListTile(
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
                        Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text("音量",
                                  style: TextStyle(
                                    fontSize: 16,
                                  ))
                            ]),
                        Row(children: <Widget>[
                          Container(
                            width: 50,
                            margin: EdgeInsets.only(left: 15),
                            child: Text("BGM"),
                          ),
                          Expanded(
                            child: Slider(
                              value: _volumeBgm,
                              //MAX-MINはテンションと同じ
                              min: 0.0,
                              max: 1.0,
                              onChangeEnd: _changeEndVolumeBgm,
                              onChanged: _changeVolumeBgm,
                            ),
                          ),
                        ]),
                        Row(children: <Widget>[
                          Container(
                            width: 50,
                            margin: EdgeInsets.only(left: 15),
                            child: Text("効果音"),
                          ),
                          Expanded(
                            child: Slider(
                              value: _volumeSe,
                              //MAX-MINはテンションと同じ
                              min: 0.0,
                              max: 1.0,
                              onChangeEnd: _changeEndVolumeSe,
                              onChanged: _changeVolumeSe,
                            ),
                          ),
                        ]),
                        new SwitchListTile(
                          value: _isVibe,
                          activeColor: Colors.orange,
                          activeTrackColor: Colors.grey,
                          inactiveThumbColor: Colors.white,
                          inactiveTrackColor: Colors.grey,
                          secondary: new Icon(
                            Icons.edgesensor_low,
                            color:
                                _isVibe ? Colors.orange[700] : Colors.grey[500],
                            size: 50.0,
                          ),
                          title: Text('バイブレーション'),
                          subtitle: Text(_isVibe ? 'ON' : 'OFF'),
                          onChanged: _changeVibe,
                        ),
                      ]),
                    ),
                    //テスト用タブ
                    Container(
                      margin: EdgeInsets.only(left: 15, top: 15),
                      child: Column(children: [
                        ElevatedButton(
                            child: const Text('☠データ全部けす☠'),
                            style: ElevatedButton.styleFrom(
                              primary: Colors.amber, //背景色
                              onPrimary: Colors.black, //押したときの色
                              shape: const StadiumBorder(),
                              side: BorderSide(
                                color: Colors.black, //枠線の色
                                width: 2, //枠線の太さ
                              ),
                            ),
                            onPressed: () async {
                              final settingsBox = Hive.box(settingsBoxName);
                              settingsBox.delete(settingsKeyName);
                              // final relultBox = Hive.box('box');
                              // relultBox.delete('results');
                              final gamedataBox = Hive.box(gamedataBoxName);
                              gamedataBox.delete(gamedataKeyName);
                              final fishResultBox = Hive.box(fishResultBoxName);
                              gamedataBox.delete(fishResultKeyName);
                            }),
                      ]),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ));
  }
}
