import 'package:fish_flutter/TypeAdapter/typFishResult.dart';
import 'package:hive/hive.dart';

part 'typGameData.g.dart';

enum enumResult {
  success,
  bare,
  cut,
}

@HiveType(typeId: 3)
class typGameData extends HiveObject {
  @HiveField(0)
  int gameId;

  @HiveField(1)
  int timeCount;

  @HiveField(2)
  int maxTimeCount;

  @HiveField(3)
  int point;

  @HiveField(4)
  double maxDepth;

  @HiveField(5)
  double windLevel;

  @HiveField(6)
  double maxWindLevel;

  @HiveField(7)
  double maxTension;

  @HiveField(8)
  double maxLineHp;

  @HiveField(9)
  double maxSpeed;

  @HiveField(10)
  late HiveList<typFishResult> fishResults;

  @HiveField(11)
  bool isEnd;

  typGameData({
    required this.gameId,
    required this.timeCount,
    required this.maxTimeCount,
    required this.point,
    required this.maxDepth,
    required this.windLevel,
    required this.maxWindLevel,
    required this.maxTension,
    required this.maxLineHp,
    required this.maxSpeed,
    required this.isEnd,
  });

  //釣果の最小サイズを返す
  double getMinSize(int fishId) {
    var minSize = 1.1;
    fishResults.forEach((val) {
      if (val.fishId == fishId && val.resultKbn == enumResult.success) {
        if (minSize > val.size) {
          minSize = val.size;
        }
      }
    });
    if (minSize == 1.1) minSize = 0.0;
    return minSize;
  }

  //釣果の最大サイズを返す
  double getMaxSize(int fishId) {
    var maxSize = -0.1;
    fishResults.forEach((val) {
      if (val.fishId == fishId && val.resultKbn == enumResult.success) {
        if (maxSize < val.size) {
          maxSize = val.size;
        }
      }
    });
    if (maxSize == -0.1) maxSize = 0.0;
    return maxSize;
  }
}
