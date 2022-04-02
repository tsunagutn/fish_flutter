import 'package:audioplayers/audioplayers.dart';
import 'package:fish_flutter/Main.dart';
import 'package:fish_flutter/Model/FishModel.dart';
import 'package:fish_flutter/widget/SoundManagerPool.dart';
import 'package:flutter/material.dart';

class SettingDialog extends StatefulWidget {
  @override
  const SettingDialog({
    //required this.soundManagerPool,
    required this.ap,
  });
  //final SoundManagerPool soundManagerPool;
  final AudioPlayer ap;
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
  var _controlRight = false; //スマホを持つ手が右手フラグ
  var _volumeBgm = 0.8; //BGM音量
  var _volumeSe = 0.8; //SE音量

  Future subBgmLoop(file) async {
    if (settings.flgBgm) {
      widget.ap.setReleaseMode(ReleaseMode.LOOP);
      await widget.ap.play('assets/' + file, volume: settings.volumeBgm);
    }
  }

  Future subBgmStop() async {
    await widget.ap.stop();
  }

  void _changeBgm(bool? e) => setState(() {
        _bgm = e!;
        settings.flgBgm = _bgm;
        //BGN再生
        if (e) {
          //効果音managerで無音を再生
          soundManagerPool.SoundManagerPoolInit();
          //BGM ONなら再生
          subBgmLoop('bgm/bgm_book.mp3');
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
        widget.ap.setVolume(_volumeBgm); //デフォルトは1.0
      });
  void _changeVolumeSe(double? e) => setState(() {
        _volumeSe = e!;
        settings.volumeSe = _volumeSe;
      });
  void _changeEndVolumeSe(double? e) => setState(() {
        //適当な音を再生
        soundManagerPool.playSound('se/linebreak.mp3');
      });

  @override
  void initState() {
    super.initState();

    //環境設定の読込
    _bgm = settings.flgBgm;
    _controlRight = settings.flgControlRight;
    _volumeBgm = settings.volumeBgm;
    _volumeSe = settings.volumeSe;

    //設定画面BCM再生
    subBgmLoop('bgm/bgm_book.mp3');
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
                                value: _controlRight,
                                activeColor: Colors.orange,
                                activeTrackColor: Colors.grey,
                                inactiveThumbColor: Colors.blue,
                                inactiveTrackColor: Colors.grey,
                                secondary: new Icon(
                                  Icons.pan_tool_rounded,
                                  color: _controlRight
                                      ? Colors.orange[700]
                                      : Colors.grey[500],
                                  size: 50.0,
                                ),
                                title: Text('操作'),
                                subtitle: Text(_controlRight ? '右手' : '左手'),
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
                              Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: <Widget>[
                                    Container(
                                      width: 50,
                                      child: Text("BGM"),
                                    ),
                                    Slider(
                                      value: _volumeBgm,
                                      //MAX-MINはテンションと同じ
                                      min: 0.0,
                                      max: 1.0,
                                      onChanged: _changeVolumeBgm,
                                    ),
                                  ]),
                              Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: <Widget>[
                                    Container(
                                      width: 50,
                                      child: Text("効果音"),
                                    ),
                                    Container(
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
                          SecondPage(),
                        ],
                      ),
                    ),
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
