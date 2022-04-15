import 'dart:typed_data';
import 'dart:ui' as ui;
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../Model/ImageModel.dart';

class ImageItem extends StatefulWidget {
  ImageItem({
    Key? key,
    required this.painterKey,
    required this.id,
    required this.imageName,
    required this.type,
    required this.top,
    required this.left,
    //required this.nowMaxDepth,
    required this.startDepth,
    required this.endDepth,
    required this.size,
  }) : super(key: key);

  final GlobalKey painterKey;
  final int id;
  final String imageName;
  final enumImageDispType type;
  final double top;
  final double left;
  //late double nowMaxDepth; //現在のMAX水深
  final double startDepth; //MAX水深がこの値の時右から描画開始
  final double endDepth; //MAX水深がこの値の時左に描画終了
  final Size size; //MAX水深がこの値の時左に描画終了

  @override
  _ImageItemState createState() => _ImageItemState();
}

class _ImageItemState extends State<ImageItem>{


  @override
  Widget build(BuildContext context) {
    return Container(
      //margin: EdgeInsets.only(top: _shoreHeight),
      width: double.infinity,
      height: double.infinity,
      child: CustomPaint(
        key: widget.painterKey,
        painter: ImagePainter(
          id: widget.id,
          imageName: widget.imageName,
          type: widget.type,
          top: widget.top,
          left: widget.left,
          //nowMaxDepth: widget.nowMaxDepth,
          startDepth: widget.startDepth,
          endDepth: widget.endDepth,
          size: widget.size,
        ),
      ),
    );

    // return CustomPaint(
    //   painter: ImagePainter(
    //     id: widget.id,
    //     image: widget.image,
    //     type: widget.type,
    //     top: widget.top,
    //     left: widget.left,
    //     nowMaxDepth: widget.nowMaxDepth,
    //     startDepth: widget.startDepth,
    //     endDepth: widget.endDepth,
    //     size: widget.size,
    //     flgDisp: widget.flgDisp,
    //   ),
    // );
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

class ImagePainter extends CustomPainter {
  ImagePainter({
    required this.id,
    required this.imageName,
    required this.type,
    required this.top,
    required this.left,
    //required this.nowMaxDepth,
    required this.startDepth,
    required this.endDepth,
    required this.size,
  });

  final int id;
  final String imageName;
  final enumImageDispType type;
  final double top;
  late double left;
  //late double nowMaxDepth; //現在のMAX水深
  final double startDepth; //MAX水深がこの値の時右から描画開始
  final double endDepth; //MAX水深がこの値の時左に描画終了
  final Size size;

  late ui.Image image;
  bool flgDisp = false;
  bool flgSetImage = false;
  double nowMaxDepth = 0.0; //現在のMAX水深

  @override
  Future<void> paint(Canvas canvas, Size size) async {
    if (!flgSetImage) {
      setImage();
      return;
    }

    if (startDepth < nowMaxDepth && endDepth > nowMaxDepth) {
      flgDisp = true;
      double diffDepth = endDepth - startDepth;
      //depth 0.1毎の移動ピクセル数
      double moveLeft = ((image.width * 2) + size.width) / diffDepth;
      left = size.width - (nowMaxDepth - startDepth) * moveLeft;
    } else {
      flgDisp = false;
    }

    if (flgDisp) {
      canvas.drawImageRect(
        image,
        // Rect.fromLTWH(0, 0, image.width.toDouble(), image.height.toDouble()),
        // Rect.fromLTWH(0, 0, image.width.toDouble(), image.height.toDouble()),
        Rect.fromLTWH(0, 0, image.width.toDouble(), image.width.toDouble()),
        Rect.fromLTWH(
            left, top, image.width.toDouble(), image.height.toDouble()),
        new Paint(),
      );
    } else {}
  }

  setImage() async {
    var rawData = await rootBundle.load('assets/images/' + imageName);
    var imgList = Uint8List.view(rawData.buffer);
    image = await decodeImageFromList(imgList);
    flgSetImage = true;
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}
