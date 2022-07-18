import 'dart:ui';

import 'package:flutter/material.dart';
import 'dart:math' as math;

import 'SliderPainter.dart';
import 'package:fish_flutter/Class/clsColor.dart';

class FishingSliders extends StatefulWidget {
  const FishingSliders({
    required this.top,
    required this.flgHit,
    required this.tension,
    required this.tensionValMax,
    required this.backRadiusValue,  //光の大きさ
    required this.backRadiusMax,  //光の大きさ最大値
    required this.flgBait,
    required this.drag,
    required this.fookingTension,
    required this.tensionValMin,
    required this.nowLineHp,
    required this.maxLineHp,
    required this.nowSpeed,
    required this.maxSpeed,
    required this.flgTap,
  });
  final double top;
  final bool flgHit;
  final double tension;
  final double tensionValMax;
  final double backRadiusValue;
  final double backRadiusMax;
  final bool flgBait;
  final double drag;
  final double fookingTension;
  final double tensionValMin;
  final double nowLineHp;
  final double maxLineHp;
  final double nowSpeed;
  final double maxSpeed;
  final bool flgTap;
  @override
  _FishingSlidersState createState() => _FishingSlidersState();
}

class _FishingSlidersState extends State<FishingSliders> {

  final TENSION_COLOR_SAFE = clsColor.getColorFromHex("007FFF");
  final TENSION_COLOR_DANGER = clsColor.getColorFromHex("FFFF00");
  final LINE_HP_COLOR = clsColor.getColorFromHex("65B558");
  final SPEED_COLOR = clsColor.getColorFromHex("FFBABE");
  final SPEED_COLOR_REELING = clsColor.getColorFromHex("FF6B77");

  Color _tensionActiveTrackColor =
  clsColor.getColorFromHex("4CFF00"); //テンションゲージの色
  Color _speedActiveTrackColor = clsColor.getColorFromHex("0094FF"); //スピードゲージの色

  @override
  Widget build(BuildContext context) {

    //テンションによってテンションバーの色を変える
    _tensionActiveTrackColor = clsColor.getColorRange(
        TENSION_COLOR_SAFE, TENSION_COLOR_DANGER, widget.tension, widget.tensionValMax);

    if (widget.flgTap) {
      //タップ時はスピードスライダの色替え
      _speedActiveTrackColor = SPEED_COLOR_REELING;
    } else {
      //スピードスライダの色を戻す
      _speedActiveTrackColor = SPEED_COLOR;
    }

    return
      Container(
        child:
        Column(children: <Widget>[
          Container(
            //appBarは透過なのでその分の高さを加算
              margin:
              EdgeInsets.only(top: widget.top),
              height: 40,
              //テンションとドラグレベルのスライダーをstackで重ねて表示
              child: new Stack(children: <Widget>[
                // //テンションスライダー
                Container(
                    margin:
                    EdgeInsets.only(left: 10, right: 10),
                    child: Column(
                        crossAxisAlignment:
                        CrossAxisAlignment.start,
                        children: <Widget>[
                          Row(
                            mainAxisAlignment:
                            MainAxisAlignment
                                .spaceBetween,
                            crossAxisAlignment:
                            CrossAxisAlignment.start,
                            children: [
                              // new Image(
                              //   image: AssetImage(
                              //       'assets/images/TENSIONDRAG.png'),
                              // ),
                              Text("テンション",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  shadows: <Shadow>[
                                    Shadow(
                                      color: Colors.black,
                                      offset: Offset(1.0, 1.0),
                                      blurRadius: 5.0,
                                    ),
                                  ],
                                ),),
                            ],
                          ),
                          Container(
                            margin: EdgeInsets.only(left: 8),
                            child: Transform(
                              transform: Matrix4.skewX(-0.3),
                              child: new Stack(children: <
                                  Widget>[
                                CustomPaint(
                                  painter: new SliderPainter(
                                    height: 20,
                                    activeColor:
                                    _tensionActiveTrackColor,
                                    inactiveColor: (widget.flgHit)
                                        ? Colors.black
                                        : Colors.white.withOpacity(0.7),
                                    value: widget.tension,
                                    maxValue: widget.tensionValMax,
                                    backRadius:
                                    widget.backRadiusValue,
                                    maxBackRadius:
                                    widget.backRadiusMax,
                                    flgShaKe: (widget.flgBait ||
                                        (widget.tension >
                                            (widget.tensionValMax *
                                                widget.drag)))
                                        ? true
                                        : false,
                                    flgDispValue: true,
                                    flgDispMaxValue: true,
                                    value2: widget.fookingTension,
                                    value2Color: Colors.black
                                        .withOpacity(0.1),
                                  ),
                                  child: Container(),
                                ),
                              ]),
                            ),
                          ),
                        ])),
                //ドラグスライダー
                Container(
                  margin: EdgeInsets.only(top: 16),
                  height: 40,
                  child: SliderTheme(
                      data: SliderTheme.of(context).copyWith(
                        //trackHeight: 1, //全体の縦長
                        valueIndicatorColor: Colors.black
                            .withOpacity(0.0), //背景の色
                        activeTrackColor: Colors.black
                            .withOpacity(0.0), //値有りエリアの色
                        inactiveTrackColor: Colors.black
                            .withOpacity(0.0), //値無しエリアの色
                        activeTickMarkColor: Colors.black
                            .withOpacity(0.0), //各value値の色
                        thumbColor: Colors.red
                            .withOpacity(0.5), //値ツマミの色
                        thumbShape: RoundSliderThumbShape(
                            enabledThumbRadius: 10), //ツマミの大きさ
                        overlayColor: Colors.black
                            .withOpacity(0.0), //値ツマミフォーカス時の色
                      ),
                      child: Slider(
                        value: widget.drag,
                        min: 0.0,
                        max: 1.0,
                        divisions:
                        (widget.tensionValMax - widget.tensionValMin)
                            .floor(),
                         onChanged: (double value) {
                        //   setState(() {
                        //     widget.drag = value;
                        //   });
                        },
                      )),
                )
              ])),
          //ラインHPスライダー
          Container(
              margin: EdgeInsets.only(
                  left: 10, right: 10, bottom: 5),
              height: 5,
              child: Column(
                  crossAxisAlignment:
                  CrossAxisAlignment.start,
                  children: <Widget>[
                    CustomPaint(
                      painter: new SliderPainter(
                        height: 10,
                        activeColor: LINE_HP_COLOR,
                        inactiveColor: Colors.white,
                        value: widget.nowLineHp,
                        maxValue: widget.maxLineHp,
                        backRadius: 0,
                        maxBackRadius: 0,
                        flgShaKe: false,
                        flgDispValue: true,
                        flgDispMaxValue: false,
                      ),
                      child: Container(),
                    ),
                  ])),

          //巻速度スライダー
          Container(
              margin: EdgeInsets.only(left: 10, right: 10),
              height: 40,
              child: Column(
                  crossAxisAlignment:
                  CrossAxisAlignment.start,
                  children: <Widget>[
                    //Text("SPEED"),
                    // new Image(
                    //   image: AssetImage(
                    //       'assets/images/SPEED.png'),
                    // ),
                    Text("スピード",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        shadows: <Shadow>[
                          Shadow(
                            color: Colors.black,
                            offset: Offset(1.0, 1.0),
                            blurRadius: 5.0,
                          ),
                        ],
                      ),),
                    Container(
                      margin: EdgeInsets.only(left: 8),
                      child: Transform(
                        transform: Matrix4.skewX(-0.3),
                        child: CustomPaint(
                          painter: new SliderPainter(
                            height: 20,
                            activeColor:
                            _speedActiveTrackColor,
                            inactiveColor: Colors.white.withOpacity(0.7),
                            value: widget.nowSpeed,
                            maxValue: widget.maxSpeed,
                            backRadius: 0,
                            maxBackRadius: 0,
                            flgShaKe: false,
                            flgDispValue: true,
                            flgDispMaxValue: true,
                          ),
                          child: Container(),
                        ),
                      ),
                    ),
                    //可能性のある魚種の速度範囲表示
                  ])),
        ]),
      );
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }
}
