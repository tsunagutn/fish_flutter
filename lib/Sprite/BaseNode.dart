import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:spritewidget/spritewidget.dart';

import 'GameNode.dart';

class BaseNode extends NodeWithSize {
  BaseNode(Size size) : super(size) {
    nodes.forEach((node) {
      // 子スプライトを追加
      this.addChild(node);
    });
  }

  final nodes = <GameNode>[
    GameNode(
      color: Colors.blue,
      length: 50,
    )..position = Offset(0, 0),
    GameNode(
      color: Colors.blue,
      length: 40,
    )..position = Offset(0, 70.0),
    GameNode(
      color: Colors.black45,
      length: 45,
      reverse: true,
    )
      ..position = Offset(0, 70)
      ..rotation = 90.0
      ..zPosition = -1.0,
  ];
}
