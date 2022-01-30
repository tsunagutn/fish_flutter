import 'package:fish_flutter/View/Fishing.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'dart:math' as math;
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:flutter/services.dart' show rootBundle;

class imagePainter extends CustomPainter {
  const imagePainter({
    required this.image,
    //required this.imagePath,
    required this.top,
    required this.left,
    required this.width,
    required this.height,
    required this.dispSize,
  });
  final ui.Image image;
  //final String imagePath;
  final double top;
  final double left;
  final double width;
  final double height;
  final Size dispSize;

  @override
  void paint(Canvas canvas, Size size) async {
    // double peopleWidth = image.width / 12;
    // double peopleHeight = people.height / 8;
    // final rawData = await rootBundle.load(imagePath);
    // debugPrint("aeae");
    // final imgList = Uint8List.view(rawData.buffer);
    // debugPrint("aeae3");
    // if (imgList != null) {
    // ui.decodeImageFromList(imgList, (img) {
    //   final src = Rect.fromLTWH(0, 0, 1, 1);
    //   const dst = Rect.fromLTWH(0, 0, 1, 1);
    //   debugPrint(img.toString());
    //   canvas.drawImageRect(img, src, dst, new Paint());
    // });

    // final rawData = await rootBundle.load(imagePath);
    // debugPrint("aeae");
    // final imgList = Uint8List.view(rawData.buffer);

    //RenderRepaintBoundary boundary = widgetGlobalKey.currentContext.findRenderObject();
    //RenderRepaintBoundary boundary = image;

    //ui.Image image = await image.toImage();

    //Uint8List m= File(path).readAsBytesSync();
    //final Uint8List m = (await rootBundle.load(imagePath)) as Uint8List;

    // final rawData = await rootBundle.load(imagePath);
    // debugPrint("aeae");
    // final imgList = Uint8List.view(rawData.buffer);
    // final ui.Image image = await decodeImageFromList(imgList);

    // debugPrint(image.toString());

    canvas.drawImageRect(
      image,
      // Rect.fromLTWH(0, 0, image.width.toDouble(), image.height.toDouble()),
      // Rect.fromLTWH(0, 0, image.width.toDouble(), image.height.toDouble()),
      Rect.fromLTWH(0, 0, image.width.toDouble(), image.width.toDouble()),
      Rect.fromLTWH(left, top, width, height),
      new Paint(),
    );

    // final paint = Paint();

    // if (image != null) {
    //   canvas.drawImage(
    //     image,
    //     Offset(0, 0),
    //     paint,
    //   );
    // }

// ui.Image test;

//       canvas.drawImageRect(
//       image,
//       Rect.fromLTWH(0, 0, image.width.toDouble(), image.height.toDouble()),
//       Rect.fromLTWH(0, 0, size.width, size.height),
//       Paint(),
//     );
//   }
//     }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
