import 'dart:ui';

import 'package:flutter/material.dart';
import 'dart:math' as math;

class RadarChart extends StatefulWidget {
  const RadarChart({
    required Key key,
    required this.items,
    required this.borderColor,
    required this.radarColors,
    required this.fontColor,
  }) : super(key: key);
  final List<RadarChartItemModel> items;
  final Color borderColor;
  final List<Color> radarColors;
  final Color fontColor;
  @override
  _RadarChartState createState() => _RadarChartState();
}

class _RadarChartState extends State<RadarChart> {
  @override
  Widget build(BuildContext context) {
    //チャートアイテムを取得
    //RadarChartItemsModel items = new RadarChartItemsModel(mode: widget.mode);

    return CustomPaint(
      //size: Size(double.infinity, double.infinity),
      size: Size(150, 150),
      painter: RadarChartPainter(
          items: widget.items,
          borderColor: widget.borderColor,
          radarColors: widget.radarColors,
          fontColor: widget.fontColor),
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

class RadarChartPainter extends CustomPainter {
  RadarChartPainter({
    required this.items,
    required this.borderColor,
    required this.radarColors,
    required this.fontColor,
  });
  final List<RadarChartItemModel> items;
  final Color borderColor;
  final List<Color> radarColors;
  final Color fontColor;

  @override
  void paint(Canvas canvas, Size size) {
    const tickLength = 5; //チャートの分割数
    //外枠の円
    var centerX = size.width / 2.0;
    var centerY = size.height / 2.0;
    var centerOffset = Offset(centerX, centerY);
    var radius = centerX * 0.8;
    var outlinePaint = Paint()
      ..color = borderColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.0
      ..isAntiAlias = true;
    canvas.drawCircle(centerOffset, radius, outlinePaint);

    List<double> ticks = []; //中のレベル
    for (var i = 0; i < tickLength; i++) {
      ticks.add(i / tickLength); //0.0～1.0
    }
    List<String> features = []; //要素毎の見出し
    List<List<double>> data = []; //値
    data.add([]);

    items.forEach((item) {
      features.add(item.itemName);
      data[0].add(item.value); //？？？複数のチャート出すときは連番変える、とりあえず0固定
    });

    var tickDistance = radius / (tickLength);
    const double tickLabelFontSize = 8;
    var ticksPaint = Paint()
      ..color = borderColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.0
      ..isAntiAlias = true;

    ticks.sublist(0, ticks.length - 1).asMap().forEach((index, tick) {
      var tickRadius = tickDistance * (index + 1);

      canvas.drawCircle(centerOffset, tickRadius, ticksPaint);

      // TextPainter(
      //   text: TextSpan(
      //     text: tick.toString(),
      //     style: TextStyle(color: Colors.white, fontSize: tickLabelFontSize),
      //   ),
      //   textDirection: TextDirection.ltr,
      // )
      //   ..layout(minWidth: 0, maxWidth: size.width)
      //   ..paint(
      //       canvas, Offset(centerX, centerY - tickRadius - tickLabelFontSize));
    });

    //var features = ["AA", "BB", "CC", "DD", "EE"];
    // var features = [];
    // items.forEach((element) {
    //   features.add(element.itemName);
    // });

    var angle = (2 * math.pi) / features.length;
    const double featureLabelFontSize = 12;
    const double featureLabelFontWidth = 10;

    features.asMap().forEach((index, feature) {
      var xAngle = math.cos(angle * index - math.pi / 2);
      var yAngle = math.sin(angle * index - math.pi / 2);

      var featureOffset =
          Offset(centerX + radius * xAngle, centerY + radius * yAngle);

      canvas.drawLine(centerOffset, featureOffset, ticksPaint);

      var labelYOffset = yAngle < 0 ? -featureLabelFontSize : 0;
      var labelXOffset =
          xAngle < 0 ? -featureLabelFontWidth * feature.length : 0;

      TextPainter(
        text: TextSpan(
          text: feature,
          style: TextStyle(color: fontColor, fontSize: featureLabelFontSize),
        ),
        textAlign: TextAlign.center,
        textDirection: TextDirection.ltr,
      )
        ..layout(minWidth: 0, maxWidth: size.width)
        ..paint(
            canvas,
            Offset(featureOffset.dx + labelXOffset,
                featureOffset.dy + labelYOffset));
    });

    //const graphColors = [Colors.green, Colors.blue];
    var scale = radius / ticks.last;
    // var data = [
    //   // [30, 20, 28, 15, 16],
    //   // [15, 30, 8, 24, 23]
    //   [0.1, 0.3, 0.3]
    // ];

    data.asMap().forEach((index, graph) {
      var graphPaint = Paint()
        ..color = radarColors[index % radarColors.length].withOpacity(0.3)
        ..style = PaintingStyle.fill;

      var graphOutlinePaint = Paint()
        ..color = radarColors[index % radarColors.length]
        ..style = PaintingStyle.stroke
        ..strokeWidth = 2.0
        ..isAntiAlias = true;

      // Start the graph on the initial point
      var scaledPoint = scale * graph[0];
      var path = Path();

      path.moveTo(centerX, centerY - scaledPoint);

      graph.sublist(1).asMap().forEach((index, point) {
        var xAngle = math.cos(angle * (index + 1) - math.pi / 2);
        var yAngle = math.sin(angle * (index + 1) - math.pi / 2);
        var scaledPoint = scale * point;

        path.lineTo(
            centerX + scaledPoint * xAngle, centerY + scaledPoint * yAngle);
      });

      path.close();
      canvas.drawPath(path, graphPaint);
      canvas.drawPath(path, graphOutlinePaint);
    });
  }

  @override
  bool shouldRepaint(RadarChartPainter oldDelegate) {
    return false;
  }
}

// class RadarChartItemsModel {
//   int mode;
//   List<RadarChartItemModel> items = [];
//   //コンストラクタ
//   RadarChartItemsModel({
//     required this.mode,
//   }) {
//     if (mode == 0) {
//       //ルアー
//       items.add(new RadarChartItemModel(itemName: '巻き', maxValue: 1.0));
//       items.add(new RadarChartItemModel(itemName: 'ﾌｫｰﾙ', maxValue: 1.0));
//       items.add(new RadarChartItemModel(itemName: 'ｼｬｸﾘ', maxValue: 1.0));
//     }
//   }
// }

class RadarChartItemModel {
  String itemName;
  double value;

  //コンストラクタ
  RadarChartItemModel({
    required this.itemName,
    required this.value,
  });
}
