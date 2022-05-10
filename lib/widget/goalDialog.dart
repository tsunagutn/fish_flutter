import 'package:fish_flutter/Model/FishModel.dart';
import 'package:fish_flutter/Model/FishResultsModel.dart';
import 'package:fish_flutter/Model/LuresModel.dart';
import 'package:flutter/material.dart';

import '../Main.dart';
import 'BgmPlayer.dart';

class goalDialog extends StatefulWidget {
  @override
  const goalDialog({
    required this.bgm,
    required this.dispSize,
    required this.fishResult,
  });

  final BgmPlayer bgm;
  final Size dispSize;
  final FishesResultModel fishResult;

  _goalDialogState createState() => _goalDialogState();
}

class _goalDialogState extends State<goalDialog> with TickerProviderStateMixin {
  late AnimationController _lightingAnimationController;
  late Animation<double> _lightingValue;

  Future subBgmLoop(file) async {
    if (settings.flgBgm) {
      widget.bgm.playBgm(name: file);
    }
  }

  @override
  void initState() {
    super.initState();

    //最初の光
    _lightingAnimationController = AnimationController(
        duration: Duration(milliseconds: 2000), vsync: this);
    _lightingValue =
        Tween(begin: 1.5, end: 0.0).animate(_lightingAnimationController)
          ..addListener(() {
            setState(() {});
          });
    _lightingAnimationController.forward();
    //ジングル鳴らす
    //soundManagerPool.playSound('se/jingle01.mp3');
    //リザルト画面BCM再生
    subBgmLoop('bgm_book.mp3');
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Opacity(
        //最初に画面全体を光らすために最初は透明にする
        opacity: _lightingValue.value <= 1.0 ? 1.0 : 0.0,
        child: Container(
            decoration: new BoxDecoration(
                image: new DecorationImage(
              image: new AssetImage("assets/images/fishback.jpg"),
              fit: BoxFit.cover,
            )),
            child: AlertDialog(
              titleTextStyle: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  shadows: <Shadow>[
                    Shadow(
                        offset: Offset(2.0, 4.0),
                        blurRadius: 2.0,
                        color: Colors.black)
                  ]),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(20.0))),
              // backgroundColor:
              //     clsColor._getColorFromHex('D1F6FF').withOpacity(0.7),

              content: Container(
                height: widget.dispSize.height,
                width: widget.dispSize.width,
                // decoration: new BoxDecoration(
                //     image: new DecorationImage(
                //   image: new AssetImage("assets/images/fishback.jpg"),
                //   fit: BoxFit.cover,
                // )),
                child: SingleChildScrollView(
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Column(children: [
                          Text(
                            "日没...",
                            style: TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                              shadows: <Shadow>[
                                Shadow(
                                  color: Colors.black,
                                  offset: Offset(2.0, 2.0),
                                  blurRadius: 3.0,
                                ),
                              ],
                            ),
                          ),
                          Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Text(
                                  "釣った魚の数",
                                ),
                                Text("xx"),
                              ]),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              ElevatedButton(
                                child: Text("OK"),
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                              ),
                            ],
                          ),
                        ]),
                      ]),
                ),
              ),
            )),
      ),
      //最初に画面全体を光らす
      IgnorePointer(
        ignoring: (_lightingValue.value == 0.0),
        child: Container(
          decoration: BoxDecoration(
              color: Colors.white.withOpacity(_lightingValue.value > 1.0
                  ? 2.0 - _lightingValue.value
                  : _lightingValue.value)),
        ),
      ),
    ]);
  }
}

// builder: (BuildContext context) {
