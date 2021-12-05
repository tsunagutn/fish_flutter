//装備しているタックルのモデル
import 'package:fish_flutter/Model/LuresModel.dart';
import 'package:flutter/foundation.dart';

class SpeedRange {
  int justSpeed;
  int rangeSpeed;
  double hitSpeedProb;

  //コンストラクタ
  SpeedRange(
      {required this.justSpeed,
      required this.rangeSpeed,
      required this.hitSpeedProb});
}
