import 'package:fish_flutter/Main.dart';
import 'package:fish_flutter/Model/FishModel.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

import '../TypeAdapter/typSettings.dart';
import 'BgmPlayer.dart';

class SettingDialog extends StatefulWidget {
  @override
  const SettingDialog({
    required this.bgm,
  });
  final BgmPlayer bgm;
  _SettingDialogState createState() => _SettingDialogState();
}

class _SettingDialogState extends State<SettingDialog>
    with SingleTickerProviderStateMixin {
  List<FishModel> fishList = [];
  int retPoint = 0;

  final _tab = <Tab>[
    Tab(
      text: 'ゲームの設定',
    ),
    Tab(
      text: '音の設定',
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

  Future subBgmLoop(file) async {
    if (settings.flgBgm) {
      widget.bgm.playBgm(name: file);
    }
  }

  Future subBgmStop() async {
    widget.bgm.stopBgmAny();
  }

  void _changeBgm(bool? e) => setState(() {
        _bgm = e!;
        settings.flgBgm = _bgm;
        //BGN再生
        if (e) {
          //効果音managerで無音を再生
          soundManagerPool.SoundManagerPoolInit();
          //BGM ONなら再生
          subBgmLoop('bgm_book.mp3');
        } else {
          //OFFなら停止
          subBgmStop();
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
        widget.bgm.volumeBgm();
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

    //設定画面BCM再生
    subBgmLoop('bgm_book.mp3');
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
            Expanded(
              child: Container(
                  width: double.maxFinite,
                  // height: MediaQuery.of(context).size.height / 1.5,
                  margin: EdgeInsets.only(bottom: 10),
                  child: DefaultTabController(
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
                                        subtitle:
                                            Text(_controlRight ? '右手' : '左手'),
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
                                      color: _bgm
                                          ? Colors.orange[700]
                                          : Colors.grey[500],
                                      size: 50.0,
                                    ),
                                    title: Text('音の再生'),
                                    subtitle: Text(_bgm ? 'ON' : 'OFF'),
                                    onChanged: _changeBgm,
                                  ),
                                  Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
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
                                ]),
                              ),
                            ],
                          ),
                        )),
                  )),
            ),
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
                //Hiveに書き込み
                final box = Hive.box('box');
                box.put(
                    'settings',
                    typSettings(
                        flgBgm: settings.flgBgm,
                        flgControlRight: settings.flgControlRight,
                        volumeBgm: settings.volumeBgm,
                        volumeSe: settings.volumeBgm,
                        jerkSense: settings.jerkSense,
                        makiSense: settings.makiSense));

                Navigator.of(context).pop(retPoint);
              },
            ),
          ]),
        ]),
      ),
    );
  }
}
