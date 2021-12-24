import 'package:fish_flutter/Model/FishModel.dart';
import 'package:flutter/material.dart';

class fishGetDialog extends StatefulWidget {
  @override
  const fishGetDialog({
    required this.dispSize,
    required this.fish,
    required this.fishSize,
    required this.addPoint,
    required this.flgNew,
  });
  final Size dispSize;
  final FishModel fish;
  final double fishSize;
  final int addPoint;
  final bool flgNew;
  _fishGetDialogState createState() => _fishGetDialogState();
}

class _fishGetDialogState extends State<fishGetDialog>
    with TickerProviderStateMixin {
  double fishCm = 0.0;
  late AnimationController _lightingAnimationController;
  late Animation<double> _lightingValue;
  late AnimationController _rColorAnimationController;
  late Animation<double> _rColorValue;
  late AnimationController _gColorAnimationController;
  late Animation<double> _gColorValue;
  late AnimationController _bColorAnimationController;
  late Animation<double> _bColorValue;

  @override
  void initState() {
    super.initState();
    fishCm = widget.fish.getSize(widget.fishSize);
    //最初の光
    _lightingAnimationController = AnimationController(
        duration: Duration(milliseconds: 3000), vsync: this);
    _lightingValue =
        Tween(begin: 1.5, end: 0.0).animate(_lightingAnimationController)
          ..addListener(() {
            setState(() {});
          });
    _lightingAnimationController.forward();
    //赤
    _rColorAnimationController =
        AnimationController(duration: Duration(milliseconds: 224), vsync: this);
    _rColorValue =
        Tween(begin: 0.0, end: 1.0).animate(_rColorAnimationController)
          ..addListener(() {
            setState(() {});
          });
    _rColorAnimationController.repeat(reverse: true);
    //緑
    _gColorAnimationController =
        AnimationController(duration: Duration(milliseconds: 203), vsync: this);
    _gColorValue =
        Tween(begin: 0.0, end: 1.0).animate(_gColorAnimationController)
          ..addListener(() {
            setState(() {});
          });
    _gColorAnimationController.repeat(reverse: true);
    //青
    _bColorAnimationController = AnimationController(
        duration: Duration(milliseconds: 1181), vsync: this);
    _bColorValue =
        Tween(begin: 0.0, end: 1.0).animate(_bColorAnimationController)
          ..addListener(() {
            setState(() {});
          });
    _bColorAnimationController.repeat(reverse: true);
  }

  @override
  void dispose() {
    _rColorAnimationController.dispose();
    _gColorAnimationController.dispose();
    _bColorAnimationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    int r = (255 * _rColorValue.value).floor();
    int g = (255 * _gColorValue.value).floor();
    int b = (255 * _bColorValue.value).floor();

    return Stack(children: [
      Opacity(
        //最初に画面全体を光らすために最初は透明にする
        opacity: _lightingValue.value <= 1.0 ? 1.0 : 0.0,
        child: Container(
            decoration: new BoxDecoration(
                image: new DecorationImage(
              image: new AssetImage("Assets/Images/fishback.jpg"),
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
              title: Text("あなたは満足を得ました",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: Color.fromRGBO(r, g, b, 1.0),
                    shadows: <Shadow>[
                      Shadow(
                          offset: Offset((4.0 * _rColorValue.value), 10.0),
                          blurRadius: 2.0,
                          color: Colors.black.withOpacity(0.3))
                    ],
                  )),
              content: Container(
                  height: widget.dispSize.height / 2,
                  // decoration: new BoxDecoration(
                  //     image: new DecorationImage(
                  //   image: new AssetImage("Assets/Images/fishback.jpg"),
                  //   fit: BoxFit.cover,
                  // )),
                  child: Column(children: <Widget>[
                    new Image(
                      image: AssetImage('Assets/Images/' + widget.fish.image),
                      // width: 150,
                      // height: 150,
                    ),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          if (widget.flgNew)
                            Container(
                              margin: EdgeInsets.only(right: 3),
                              padding: const EdgeInsets.all(2.0),
                              decoration: BoxDecoration(
                                  border:
                                      Border.all(color: Colors.black, width: 1),
                                  color: Colors.black),
                              child: Text("NEW!",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 10,
                                  )),
                            ),
                          Text(widget.fish.name +
                              "　" +
                              widget.fish
                                  .getSize(widget.fishSize)
                                  .toStringAsFixed(1) +
                              "cm"),
                          if (widget.fishSize > 0.8 && widget.fishSize < 0.95)
                            Icon(Icons.star, color: Colors.teal),
                          if (widget.fishSize > 0.95)
                            Icon(
                              Icons.star,
                              color: Colors.yellow,
                            ),
                        ]),
                    Text(widget.addPoint.toString() + 'ポイント獲得です'),
                    Text(widget.fish.text),
                    if (widget.flgNew)
                      Container(
                        margin: EdgeInsets.only(top: 5),
                        child: Text("おさかな図鑑に登録します",
                            style: TextStyle(color: Colors.red)),
                      ),
                  ])),
              actions: <Widget>[
                ElevatedButton(
                  child: Text("OK"),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ],
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
