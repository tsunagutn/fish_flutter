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
    required this.haveTakcle,
    required this.soundManagerPool,
    required this.originPoint,
  });
  final HaveTackleModel haveTakcle;
  final SoundManagerPool soundManagerPool;
  final int originPoint;
  _SettingDialogState createState() => _SettingDialogState();
}

enum bgmSetting { On, Off }

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

  var _type = bgmSetting.Off;

  void _handleRadio(bgmSetting? e) => setState(() {
        _type = e!;
      });

  @override
  void initState() {
    super.initState();
    retPoint = widget.originPoint;
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
                        //タックル
                        Container(
                          child: Column(children: [
                            Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text(
                                    "BGMの設定",
                                    style: TextStyle(fontSize: 20),
                                  ),
                                ]),
                            Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    children: <Widget>[
                                      RadioListTile(
                                          title: Text('OFF'),
                                          value: bgmSetting.Off,
                                          groupValue: _type,
                                          onChanged: _handleRadio),
                                      RadioListTile(
                                          title: Text('ON'),
                                          value: bgmSetting.On,
                                          groupValue: _type,
                                          onChanged: _handleRadio),
                                    ],
                                  ),
                                ]),
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
