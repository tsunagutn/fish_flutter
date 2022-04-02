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

class ShopDialog extends StatefulWidget {
  @override
  const ShopDialog({
    required this.haveTakcle,
    required this.soundManagerPool,
    required this.originPoint,
  });
  final HaveTackleModel haveTakcle;
  final SoundManagerPool soundManagerPool;
  final int originPoint;
  _ShopDialogState createState() => _ShopDialogState();
}

class _ShopDialogState extends State<ShopDialog>
    with SingleTickerProviderStateMixin {
  List<FishModel> fishList = [];
  int retPoint = 0;

  final _tab = <Tab>[
    Tab(
      text: 'Rod/Reel',
    ),
    Tab(
      text: 'Lure',
    ),
    // Tab(
    //   text: 'Ship',
    // ),
  ];

  @override
  void initState() {
    super.initState();
    retPoint = widget.originPoint;
  }

  //ポイントを使うときの処理
  bool usePoint(int use) {
    if (retPoint < use) {
      //ポイントが足りない
      return false;
    }
    setState(() {
      retPoint -= use;
    });
    return true;
  }

  @override
  Widget build(BuildContext context) {
    RodModel nowRod = widget.haveTakcle.getUseRod();
    RodModel nextRod = widget.haveTakcle.getNextRod();
    ReelModel nowReel = widget.haveTakcle.getUseReel();
    ReelModel nextReel = widget.haveTakcle.getNextReel();

    return AlertDialog(
      insetPadding: EdgeInsets.only(top: 40, bottom: 40, left: 10, right: 10),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text("お店"),
          Text("円：" + retPoint.toString()),
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
                            child: Column(
                          children: [
                            //竿
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Container(
                                  margin: EdgeInsets.only(left: 20),
                                  child: Text(
                                    '竿',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20),
                                  ),
                                ),
                              ],
                            ),
                            Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Column(
                                    children: [
                                      tackleIcon(
                                        tackleIconSize: 40.0,
                                        imagePath:
                                            'assets/images/' + nowRod.image,
                                        flgSelect: false,
                                        opacity: 1.0,
                                      ),
                                      Text(
                                        nowRod.name,
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Text(nowRod.text)
                                    ],
                                  ),
                                  Icon(Icons.next_plan),
                                  Column(
                                    children: [
                                      tackleIcon(
                                        tackleIconSize: 40.0,
                                        imagePath:
                                            'assets/images/' + nextRod.image,
                                        flgSelect: false,
                                        opacity: 1.0,
                                      ),
                                      Text(
                                        nextRod.name,
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Text(nextRod.text),
                                      Opacity(
                                        opacity: nextRod.id < 0 ? 0.0 : 1.0,
                                        child: ElevatedButton(
                                            child: Text(retPoint < nextRod.prise
                                                ? "ポイントが足りぬ"
                                                : nextRod.prise.toString() +
                                                    "PでLvUP"),
                                            style: ElevatedButton.styleFrom(
                                              primary: Colors.amber, //背景色
                                              onPrimary: Colors.black, //押したときの色
                                              shape: const StadiumBorder(),
                                              side: BorderSide(
                                                color: Colors.black, //枠線の色
                                                width: 2, //枠線の太さ
                                              ),
                                            ),
                                            onPressed: nextRod.id > 0 &&
                                                    retPoint < nextRod.prise
                                                ? null
                                                : () {
                                                    if (!usePoint(
                                                        nextRod.prise)) {
                                                      //ポイント不足
                                                      showDialog(
                                                        context: context,
                                                        builder: (_) {
                                                          return AlertDialog(
                                                            content: Text(
                                                                "ポイントが足りぬ"),
                                                            actions: <Widget>[
                                                              //
                                                              ElevatedButton(
                                                                child: Text(
                                                                    "すみません"),
                                                                onPressed: () =>
                                                                    Navigator.pop(
                                                                        context),
                                                              ),
                                                            ],
                                                          );
                                                        },
                                                      );
                                                      return;
                                                    }
                                                    //使用中ロッドIDを変更
                                                    widget.haveTakcle
                                                        .haveRodId = nextRod.id;
                                                    //効果音
                                                    widget.soundManagerPool
                                                        .playSound(
                                                            'se/shop.mp3');
                                                  }),
                                      ),
                                    ],
                                  ),
                                ]),
                            //リール
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Container(
                                  margin: EdgeInsets.only(left: 20),
                                  child: Text(
                                    'リール',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20),
                                  ),
                                ),
                              ],
                            ),
                            Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Column(
                                    children: [
                                      tackleIcon(
                                        tackleIconSize: 40.0,
                                        imagePath:
                                            'assets/images/' + nowReel.image,
                                        flgSelect: false,
                                        opacity: 1.0,
                                      ),
                                      Text(
                                        nowReel.name,
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Text(nowReel.text)
                                    ],
                                  ),
                                  Icon(Icons.next_plan),
                                  Column(
                                    children: [
                                      tackleIcon(
                                        tackleIconSize: 40.0,
                                        imagePath:
                                            'assets/images/' + nextReel.image,
                                        flgSelect: false,
                                        opacity: 1.0,
                                      ),
                                      Text(
                                        nextReel.name,
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Text(nextReel.text),
                                      Opacity(
                                        opacity: nextReel.id < 0 ? 0.0 : 1.0,
                                        child: ElevatedButton(
                                            child: Text(retPoint <
                                                    nextReel.prise
                                                ? "ポイントが足りぬ"
                                                : nextReel.prise.toString() +
                                                    "PでLvUP"),
                                            style: ElevatedButton.styleFrom(
                                              primary: Colors.amber, //背景色
                                              onPrimary: Colors.black, //押したときの色
                                              shape: const StadiumBorder(),
                                              side: BorderSide(
                                                color: Colors.black, //枠線の色
                                                width: 2, //枠線の太さ
                                              ),
                                            ),
                                            onPressed: nextReel.id > 0 &&
                                                    retPoint < nextReel.prise
                                                ? null
                                                : () {
                                                    if (!usePoint(
                                                        nextReel.prise)) {
                                                      //ポイント不足
                                                      showDialog(
                                                        context: context,
                                                        builder: (_) {
                                                          return AlertDialog(
                                                            content: Text(
                                                                "ポイントが足りぬ"),
                                                            actions: <Widget>[
                                                              //
                                                              ElevatedButton(
                                                                child: Text(
                                                                    "すみません"),
                                                                onPressed: () =>
                                                                    Navigator.pop(
                                                                        context),
                                                              ),
                                                            ],
                                                          );
                                                        },
                                                      );
                                                      return;
                                                    }
                                                    //使用中ロッドIDを変更
                                                    widget.haveTakcle
                                                            .haveReelId =
                                                        nextReel.id;
                                                    //効果音
                                                    widget.soundManagerPool
                                                        .playSound(
                                                            'se/shop.mp3');
                                                  }),
                                      ),
                                    ],
                                  ),
                                ]),
                          ],
                        )),
                        //FirstPage(),
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

class FirstPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.orange,
      body: Center(
        child: Text(
          "First Page",
          style: TextStyle(fontSize: 20),
        ),
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
